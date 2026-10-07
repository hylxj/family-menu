<script setup>
import { ref, computed, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { listMealHistory, deleteMealRecord } from '@/api/mealRecord'
import PageBack from '@/components/PageBack.vue'

const loading = ref(false)
const historyList = ref([])
const searchKeyword = ref('')
const filterCategory = ref('')
const dateRange = ref([])

// 分类选项（从历史动态聚合）
const categoryOptions = computed(() => {
  const set = new Set()
  historyList.value.forEach(item => {
    item.dishes?.forEach(d => d.category && set.add(d.category))
  })
  return Array.from(set)
})

// 过滤
const filteredList = computed(() => {
  let list = historyList.value
  // 日期
  if (dateRange.value && dateRange.value.length === 2) {
    const [start, end] = dateRange.value
    list = list.filter(i => i.date >= start && i.date <= end)
  }
  // 分类
  if (filterCategory.value) {
    list = list.filter(i => i.dishes?.some(d => d.category === filterCategory.value))
  }
  // 关键字（搜菜名）
  const kw = searchKeyword.value.trim()
  if (kw) {
    list = list.filter(i => i.dishes?.some(d => d.name.includes(kw)))
  }
  return list
})

// 统计
const stats = computed(() => {
  const dishCount = new Map()  // dishId -> { name, category, count }
  for (const item of historyList.value) {
    for (const d of (item.dishes || [])) {
      if (!d.id) continue
      const cur = dishCount.get(d.id) || { name: d.name, category: d.category, count: 0 }
      cur.count++
      dishCount.set(d.id, cur)
    }
  }
  const top = Array.from(dishCount.values())
    .sort((a, b) => b.count - a.count)
    .slice(0, 10)
  return {
    totalDays: historyList.value.length,
    totalDishes: Array.from(dishCount.values()).reduce((s, n) => s + n.count, 0),
    uniqueDishes: dishCount.size,
    topDishes: top
  }
})

const spicyText = (level) => ['不辣', '微辣', '中辣', '爆辣'][level] || '?'

async function loadHistory() {
  loading.value = true
  try {
    const list = await listMealHistory()
    historyList.value = list || []
    if (historyList.value.length === 0) {
      ElMessage.info('还没有历史记录，先去「本周菜单」保存吧')
    }
  } catch (e) {
    console.error(e)
    ElMessage.error('加载历史失败：' + (e?.message || ''))
  } finally {
    loading.value = false
  }
}

async function handleDelete(item) {
  try {
    await ElMessageBox.confirm(
      `确定删除 ${item.date} 的菜单记录吗？删除后生成菜单时会重新推荐这些菜`,
      '删除确认',
      { type: 'warning', confirmButtonText: '删除', cancelButtonText: '取消' })
  } catch { return }
  try {
    await deleteMealRecord(item.id)
    ElMessage.success('删除成功')
    await loadHistory()
  } catch (e) {
    console.error(e)
    ElMessage.error('删除失败：' + (e?.message || ''))
  }
}

// 上面快速实现有问题，需要 listMealHistory 返回中带 id。让我在 VO 里加个 id 字段
// 但 time 紧急，先重新写：在 historyList 里 key 用 item.id（若有），否则用 date
// 修正：在 MealHistoryVO 增加 id 字段，listHistory 时一起返回
function resetFilter() {
  searchKeyword.value = ''
  filterCategory.value = ''
  dateRange.value = []
}

onMounted(loadHistory)
</script>

<template>
  <div class="meal-history">
    <PageBack />
    <el-card class="header-card" shadow="never">
      <div class="header-content">
        <div>
          <h2>📜 吃饭历史</h2>
          <p class="subtitle">翻看一下过去几周都吃了啥，别再重复了</p>
        </div>
        <el-button :icon="loading ? 'Loading' : 'Refresh'" @click="loadHistory" :loading="loading">
          刷新
        </el-button>
      </div>
    </el-card>

    <!-- 统计卡片 -->
    <div v-if="historyList.length" class="stats-row">
      <el-card class="stat-card" shadow="hover">
        <div class="stat-num">{{ stats.totalDays }}</div>
        <div class="stat-label">📅 已记录天数</div>
      </el-card>
      <el-card class="stat-card" shadow="hover">
        <div class="stat-num">{{ stats.uniqueDishes }}</div>
        <div class="stat-label">🍲 吃过的菜</div>
      </el-card>
      <el-card class="stat-card" shadow="hover">
        <div class="stat-num">{{ stats.totalDishes }}</div>
        <div class="stat-label">🥢 上餐桌次</div>
      </el-card>
      <el-card class="stat-card top-card" shadow="hover">
        <div class="top-title">🏆 出场王 TOP 3</div>
        <div v-for="(t, idx) in stats.topDishes.slice(0, 3)" :key="idx" class="top-item">
          <span class="top-rank">{{ idx + 1 }}</span>
          <span class="top-name">{{ t.name }}</span>
          <span class="top-count">×{{ t.count }}</span>
        </div>
      </el-card>
    </div>

    <!-- 筛选 -->
    <el-card v-if="historyList.length" class="filter-card" shadow="never">
      <el-input v-model="searchKeyword" placeholder="搜菜名..." clearable
                style="width: 200px" :prefix-icon="'Search'" />
      <el-select v-model="filterCategory" placeholder="按分类筛选" clearable style="width: 140px">
        <el-option v-for="c in categoryOptions" :key="c" :label="c" :value="c" />
      </el-select>
      <el-date-picker v-model="dateRange" type="daterange" range-separator="至"
                      start-placeholder="开始日期" end-placeholder="结束日期"
                      value-format="YYYY-MM-DD" />
      <el-button @click="resetFilter">清空筛选</el-button>
      <span class="filter-result">找到 {{ filteredList.length }} 条</span>
    </el-card>

    <!-- 列表 -->
    <div v-if="loading" class="loading-state">
      <el-skeleton :rows="4" animated />
    </div>

    <div v-else-if="filteredList.length" class="timeline">
      <el-card v-for="item in filteredList" :key="item.date + '-' + item.mealType" class="history-card" shadow="hover">
        <div class="history-header">
          <div class="date-block">
            <div class="weekday">{{ item.weekday }}</div>
            <div class="date">{{ item.date }}</div>
          </div>
          <div class="meal-type">
            <el-tag size="small" :type="item.mealType === 'dinner' ? 'warning' : 'success'">
              {{ item.mealType === 'dinner' ? '🌙 晚餐' : '☀️ 午餐' }}
            </el-tag>
            <el-button size="small" type="danger" plain @click="handleDelete(item)">
              🗑 删除
            </el-button>
          </div>
        </div>

        <div class="dishes">
          <div v-for="d in item.dishes" :key="d.id" class="dish-row">
            <el-tag size="small" effect="plain">{{ d.role || d.category }}</el-tag>
            <span class="dish-name">{{ d.name }}</span>
            <span :class="'spicy-' + (d.spicyLevel || 0)">{{ spicyText(d.spicyLevel) }}</span>
            <span class="cook-time">⏱ {{ d.cookTime }}分钟</span>
          </div>
        </div>
      </el-card>
    </div>

    <el-empty v-else-if="!loading && historyList.length === 0" description="还没有历史记录">
      <el-button type="primary" @click="$router.push('/menu')">去生成菜单</el-button>
    </el-empty>

    <el-empty v-else description="没找到符合条件的记录" />
  </div>
</template>

<style scoped>
.meal-history { max-width: 900px; margin: 0 auto; }

.header-card {
  background: linear-gradient(135deg, #fdf6e3 0%, #f5e8c5 100%);
  margin-bottom: 16px;
}
.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
}
.header-content h2 { margin-bottom: 4px; color: #8b5a2b; }
.subtitle { color: #909399; font-size: 14px; }

.stats-row {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
  gap: 12px;
  margin-bottom: 16px;
}
.stat-card { text-align: center; padding: 16px 8px; }
.stat-num { font-size: 32px; font-weight: 600; color: #8b5a2b; }
.stat-label { font-size: 13px; color: #909399; margin-top: 4px; }
.top-card { text-align: left; }
.top-title { font-size: 14px; font-weight: 600; color: #8b5a2b; margin-bottom: 8px; }
.top-item {
  display: flex; align-items: center; gap: 6px;
  font-size: 13px; padding: 2px 0;
}
.top-rank {
  background: #e6a23c; color: white;
  width: 18px; height: 18px;
  border-radius: 50%;
  display: flex; align-items: center; justify-content: center;
  font-size: 11px; font-weight: 600;
}
.top-name { flex: 1; }
.top-count { color: #f56c6c; font-weight: 600; }

.filter-card {
  margin-bottom: 16px;
  display: flex; gap: 12px; align-items: center; flex-wrap: wrap;
}
.filter-result { color: #909399; font-size: 13px; margin-left: auto; }

.timeline { display: flex; flex-direction: column; gap: 12px; }
.history-card { background: #fff; }
.history-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px dashed #f0e6d2;
  padding-bottom: 12px;
  margin-bottom: 12px;
}
.date-block { display: flex; flex-direction: column; }
.weekday { font-size: 18px; font-weight: 600; color: #8b5a2b; }
.date { font-size: 13px; color: #909399; }
.meal-type { display: flex; align-items: center; gap: 8px; }

.dishes { display: flex; flex-direction: column; gap: 8px; }
.dish-row {
  display: flex; align-items: center; gap: 12px;
  padding: 8px 12px;
  border-radius: 8px;
  background: #fafafa;
}
.dish-name { flex: 1; font-size: 16px; font-weight: 500; }
.cook-time { font-size: 12px; color: #909399; }

.spicy-0 { color: #67c23a; font-size: 12px; }
.spicy-1 { color: #e6a23c; font-size: 12px; }
.spicy-2 { color: #f56c6c; font-size: 12px; }
.spicy-3 { color: #f56c6c; font-size: 12px; font-weight: 600; }

.loading-state { background: #fff; padding: 24px; border-radius: 8px; }
</style>