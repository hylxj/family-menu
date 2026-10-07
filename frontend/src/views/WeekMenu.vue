<script setup>
import { ref, onMounted, computed, watch } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage, ElMessageBox } from 'element-plus'
import { generateMenu, swapDish } from '@/api/menu'
import { getDishDetail } from '@/api/dish'
import PageBack from '@/components/PageBack.vue'
import DishIngredientPopover from '@/components/DishIngredientPopover.vue'
import { saveMealRecord, getMealRecord } from '@/api/mealRecord'
import { useMenuStore } from '@/stores/menu'

const router = useRouter()
const menuStore = useMenuStore()

const loading = ref(false)
const saving = ref(false)
const weekMenu = ref(null)
const startDate = ref(new Date().toISOString().split('T')[0])
const days = ref(1)            // ★ 默认 1 天
const historyDays = ref(14)
const dayScope = ref('today')  // ★ 默认 1 天

const scopeDays = computed(() => dayScope.value === 'today' ? 1 : 7)

// 跟踪已保存过的日期（用于显示 ✅ 标记）
const savedDates = ref(new Set())

// ================= 视图同步 =================
function pickToday() {
  dayScope.value = 'today'
  days.value = 1
  startDate.value = new Date().toISOString().split('T')[0]
}
function pickWeek() {
  dayScope.value = 'week'
  days.value = 7
}
// 修复 radio 状态：用 v-model 双向同步
watch(dayScope, (v) => {
  if (v === 'today') { days.value = 1; startDate.value = new Date().toISOString().split('T')[0] }
  if (v === 'week') { days.value = 7 }
})

// ================= 生成 =================
async function handleGenerate() {
  loading.value = true
  try {
    const data = await generateMenu({
      startDate: startDate.value,
      days: days.value,
      historyDays: historyDays.value
    })
    weekMenu.value = data
    menuStore.setMenu(data)
    // ★ 前端实时重算购物清单（保证换菜后也对得上）
    await recomputeShoppingList()
    menuStore.setMenu(weekMenu.value)
    // 检查哪些天已经保存过
    for (const d of data.dayMenus) {
      const rec = await getMealRecord(d.date).catch(() => null)
      if (rec && rec.data) savedDates.value.add(d.date)
    }
    ElMessage.success(`菜单生成成功！共 ${data.dayMenus.length} 天`)
  } catch (e) {
    console.error(e)
  } finally {
    loading.value = false
  }
}

// ================= 换一道菜 =================
async function handleSwap(day, oldDish) {
  if (!oldDish) return
  // 收集当天其他菜的 id（避免换到的菜和现有重复）
  const excludeIds = (day.allDishes || []).map(d => d.id).filter(Boolean)
  try {
    const newDish = await swapDish(oldDish.category, excludeIds, 3)  // spicy=3 全开放，后端按家庭偏好过滤
    // 替换逻辑
    const idx = day.allDishes.findIndex(d => d.id === oldDish.id)
    if (idx >= 0) day.allDishes[idx] = newDish
    if (day.mainDish?.id === oldDish.id) day.mainDish = newDish
    if (day.sideDish?.id === oldDish.id) day.sideDish = newDish
    if (day.soupDish?.id === oldDish.id) day.soupDish = newDish
    if (day.coldDish?.id === oldDish.id) day.coldDish = newDish
    // ★ 换菜后重算购物清单
    await recomputeShoppingList()
    menuStore.setMenu(weekMenu.value)
    ElMessage.success(`已换成：${newDish.name}`)
  } catch (e) {
    console.error(e)
    ElMessage.error('换菜失败：' + (e?.message || ''))
  }
}

// ================= 保存某天 =================
async function handleSaveDay(day) {
  saving.value = true
  try {
    const dishes = (day.allDishes || []).map(d => ({
      dishId: d.id,
      role: d.category
    }))
    await saveMealRecord({
      mealDate: day.date,
      mealType: 'dinner',
      dishes
    })
    savedDates.value.add(day.date)
    ElMessage.success(`${day.date} 的菜单已保存，下次生成会避开这些菜`)
  } catch (e) {
    console.error(e)
    ElMessage.error('保存失败：' + (e?.message || ''))
  } finally {
    saving.value = false
  }
}

// ================= 保存全部 =================
async function handleSaveAll() {
  if (!weekMenu.value) return
  try {
    await ElMessageBox.confirm(
      `将保存 ${weekMenu.value.dayMenus.length} 天的菜单，确定？`,
      '批量保存', { type: 'info' })
  } catch { return }
  for (const day of weekMenu.value.dayMenus) {
    await handleSaveDay(day)
  }
}

function spicyText(level) {
  return ['不辣', '微辣', '中辣', '爆辣'][level] || '?'
}

// ================= 购物清单聚合（前端实时计算，与后端规则一致） =================
const CATEGORY_ICONS = {
  '蔬菜': '🥬',
  '肉类': '🥩',
  '水产': '🐟',
  '调料': '🧂',
  '主食': '🌾',
  '其他': '📦'
}
const CATEGORY_ORDER = ['蔬菜', '肉类', '水产', '主食', '调料', '其他']

/**
 * 重新计算购物清单
 * 用法：菜单生成后、换菜后都要调一次，保证 shoppingList 与 dayMenus 一致
 */
async function recomputeShoppingList() {
  if (!weekMenu.value || !weekMenu.value.dayMenus?.length) return

  // 1. 收集所有菜 id（去重）
  const dishIds = new Set()
  for (const day of weekMenu.value.dayMenus) {
    for (const dish of (day.allDishes || [])) {
      if (dish?.id) dishIds.add(dish.id)
    }
  }
  if (dishIds.size === 0) {
    weekMenu.value.shoppingList = emptyShoppingList(weekMenu.value)
    return
  }

  // 2. 并行拉每道菜的食材
  const detailList = await Promise.all(
    [...dishIds].map(id => getDishDetail(id).catch(() => null))
  )

  // 3. 聚合 name+unit 为 key
  const merged = new Map()
  for (const detail of detailList) {
    if (!detail || !detail.ingredients) continue
    for (const ing of detail.ingredients) {
      if (!ing.name) continue
      const key = ing.name + '|' + (ing.unit || '')
      if (!merged.has(key)) {
        merged.set(key, {
          name: ing.name,
          unit: '',
          category: '其他',
          amount: 0,
          usedIn: null
        })
      }
      const m = merged.get(key)
      if (ing.amount != null) m.amount += Number(ing.amount)
      if (ing.category) m.category = ing.category
      if (!m.unit && ing.unit) m.unit = ing.unit
      // 记录来源菜
      const dishName = detail.dish?.name
      if (dishName) {
        if (!m.usedIn) m.usedIn = dishName
        else if (!m.usedIn.includes(dishName)) m.usedIn += ', ' + dishName
      }
    }
  }

  // 4. 按分类分组
  const grouped = new Map()
  for (const m of merged.values()) {
    const cat = m.category || '其他'
    if (!grouped.has(cat)) grouped.set(cat, [])
    grouped.get(cat).push({
      name: m.name,
      amount: m.amount > 0 ? Number(m.amount.toFixed(2)) : null,
      unit: m.unit || '',
      usedIn: m.usedIn
    })
  }
  for (const items of grouped.values()) items.sort((a, b) => a.name.localeCompare(b.name, 'zh'))

  // 5. 组装 ShoppingListVO（按固定顺序）
  const groups = []
  for (const cat of CATEGORY_ORDER) {
    const items = grouped.get(cat)
    if (!items || items.length === 0) continue
    groups.push({ category: cat, icon: CATEGORY_ICONS[cat], items })
  }

  weekMenu.value.shoppingList = {
    startDate: weekMenu.value.startDate,
    endDate: weekMenu.value.endDate,
    totalCount: merged.size,
    groups
  }
}

function emptyShoppingList(wm) {
  return {
    startDate: wm.startDate,
    endDate: wm.endDate,
    totalCount: 0,
    groups: []
  }
}

async function generateAndShop() {
  // 没有本地菜单就先生成
  if (!weekMenu.value) {
    try {
      await ElMessageBox.confirm('还没有菜单，先生成吗？', '提示', { type: 'info' })
    } catch { return }
    await handleGenerate()
  }
  if (!weekMenu.value) return
  // 保证 shoppingList 是最新的（用户可能换过菜但还没刷过接口）
  await recomputeShoppingList()
  menuStore.setMenu(weekMenu.value)
  router.push('/shopping-list')
}

onMounted(() => {
  if (menuStore.weekMenu) {
    weekMenu.value = menuStore.weekMenu
  }
})
</script>

<template>
  <div class="week-menu">
    <PageBack />
    <el-card class="control-card" shadow="never">
      <div class="control-form">
        <el-radio-group v-model="dayScope" size="large" class="quick-switch">
          <el-radio-button value="today" @click="pickToday">📅 一天</el-radio-button>
          <el-radio-button value="week" @click="pickWeek">🗓️ 一周</el-radio-button>
        </el-radio-group>

        <span>起始：</span>
        <el-date-picker v-model="startDate" type="date" value-format="YYYY-MM-DD"
                        placeholder="选择日期" style="width: 160px" />

        <span>天数：</span>
        <el-input-number v-model="days" :min="1" :max="30" />

        <span>去重：</span>
        <el-tooltip content="查最近 N 天内吃过的菜，生成时自动避开。0=不避开，14=推荐（覆盖上一周）" placement="top">
          <el-input-number v-model="historyDays" :min="0" :max="60" />
        </el-tooltip>

        <el-button type="primary" :loading="loading" @click="handleGenerate">
          🍲 生成菜单（{{ scopeDays }} 天）
        </el-button>
      </div>
      <p class="hint">
        💡 默认生成今天的 1 天菜单；点"💾 保存"后该菜会进入历史，下次生成按"去重天数"避开已吃过的菜（默认 14 天）
      </p>
    </el-card>

    <!-- 生成成功后，顶部操作 -->
    <transition name="slide-down">
      <el-card v-if="weekMenu" class="result-actions" shadow="hover">
        <div class="result-info">
          <span class="badge">✅ 已生成 {{ weekMenu.dayMenus.length }} 天菜单</span>
          <span class="range">{{ weekMenu.startDate }} 至 {{ weekMenu.endDate }}</span>
          <span class="total">🛒 共 {{ weekMenu.shoppingList?.totalCount || 0 }} 种食材</span>
        </div>
        <div class="result-buttons">
          <el-button type="warning" size="large" round @click="handleSaveAll" :loading="saving">
            💾 一键保存全部
          </el-button>
          <el-button size="large" round @click="$router.push('/history')">
            📜 查看历史
          </el-button>
          <el-button type="success" size="large" round @click="generateAndShop">
            🛒 一键生成购物清单
          </el-button>
        </div>
      </el-card>
    </transition>

    <div v-if="loading" class="loading-state">
      <el-skeleton :rows="6" animated />
    </div>

    <div v-else-if="weekMenu" class="menu-list">
      <el-card v-for="day in weekMenu.dayMenus" :key="day.date" class="day-card" shadow="hover">
        <div class="day-header">
          <div class="date-block">
            <div class="weekday">{{ day.weekday }}</div>
            <div class="date">{{ day.date }}</div>
          </div>
          <div class="day-actions">
            <el-tag v-if="savedDates.has(day.date)" type="success" effect="dark">✅ 已保存</el-tag>
            <el-button size="small" type="warning" @click="handleSaveDay(day)"
                       :disabled="savedDates.has(day.date)" :loading="saving">
              💾 保存今日
            </el-button>
          </div>
        </div>

        <div class="dishes">
          <div v-for="dish in day.allDishes" :key="dish.id" class="dish-item">
            <span class="role">{{ dish.category }}</span>
            <span class="name">{{ dish.name }}</span>
            <span :class="'spicy-' + dish.spicyLevel">{{ spicyText(dish.spicyLevel) }}</span>
            <span class="time">⏱ {{ dish.cookTime }}分钟</span>
            <DishIngredientPopover :dish-id="dish.id" trigger-text="🥕 食材" />
            <el-button size="small" plain @click="handleSwap(day, dish)">🔄 换一道</el-button>
          </div>
        </div>
      </el-card>
    </div>

    <el-empty v-else description="还没有生成菜单，点击上方按钮开始" />
  </div>
</template>

<style scoped>
.week-menu { max-width: 900px; margin: 0 auto; }
.control-card { margin-bottom: 16px; background: #fff; }
.control-form {
  display: flex;
  align-items: center;
  gap: 12px;
  flex-wrap: wrap;
}
.quick-switch { margin-right: 8px; }
.hint { color: #909399; font-size: 12px; margin: 12px 0 0; }

.result-actions {
  margin-bottom: 16px;
  background: linear-gradient(135deg, #f0f9eb 0%, #e1f5e5 100%);
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  flex-wrap: wrap;
}
.result-info { display: flex; gap: 14px; align-items: center; flex-wrap: wrap; }
.result-buttons { display: flex; gap: 8px; }
.badge {
  background: #67c23a; color: white;
  padding: 4px 12px; border-radius: 16px;
  font-size: 14px; font-weight: 600;
}
.range, .total { color: #606266; font-size: 14px; }

.slide-down-enter-active, .slide-down-leave-active {
  transition: all 0.3s ease;
}
.slide-down-enter-from, .slide-down-leave-to {
  opacity: 0; transform: translateY(-12px);
}
.menu-list { display: flex; flex-direction: column; gap: 12px; }
.day-card { background: #fff; }
.day-header {
  display: flex; align-items: center; justify-content: space-between;
  border-bottom: 1px dashed #f0e6d2;
  padding-bottom: 12px; margin-bottom: 12px;
}
.day-actions { display: flex; gap: 8px; align-items: center; }
.date-block { display: flex; flex-direction: column; }
.weekday {
  font-size: 18px;
  font-weight: 600;
  color: #8b5a2b;
}
.date { font-size: 14px; color: #909399; }

.dishes { display: flex; flex-direction: column; gap: 8px; }
.dish-item {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 8px 12px;
  border-radius: 8px;
  background: #fafafa;
  transition: background 0.2s;
}
.dish-item:hover { background: #f0f0f0; }
.role {
  background: #fff;
  padding: 2px 8px;
  border-radius: 4px;
  font-size: 12px;
  color: #606266;
  min-width: 50px;
  text-align: center;
  border: 1px solid #ebeef5;
}
.name { flex: 1; font-size: 16px; font-weight: 500; }
.time { font-size: 12px; color: #909399; }

.loading-state { background: #fff; padding: 24px; border-radius: 8px; }

/* 辣度 */
.spicy-0 { color: #67c23a; font-size: 12px; }
.spicy-1 { color: #e6a23c; font-size: 12px; }
.spicy-2 { color: #f56c6c; font-size: 12px; }
.spicy-3 { color: #f56c6c; font-size: 12px; font-weight: 600; }
</style>
