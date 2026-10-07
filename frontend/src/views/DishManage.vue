<script setup>
import { ref, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { listDishes, getDishDetail, deleteDish, saveDish } from '@/api/dish'
import PageBack from '@/components/PageBack.vue'
import IngredientPanel from '@/components/IngredientPanel.vue'
import DishIngredientPopover from '@/components/DishIngredientPopover.vue'

const dishes = ref([])
const loading = ref(false)
const keyword = ref('')
const categoryFilter = ref('')

// 展开行：每行缓存 { loading, ingredients, dish }
const expandedRows = ref(new Map())

const categories = [
  { value: '', label: '全部' },
  { value: '主荤', label: '主荤' },
  { value: '素菜', label: '素菜' },
  { value: '汤', label: '汤' },
  { value: '凉菜', label: '凉菜' },
  { value: '主食', label: '主食' }
]

const spicyLabels = ['', '🌶️微辣', '🌶️🌶️中辣', '🌶️🌶️🌶️爆辣']

async function loadDishes() {
  loading.value = true
  try {
    const params = {}
    if (categoryFilter.value) params.category = categoryFilter.value
    if (keyword.value) params.keyword = keyword.value
    dishes.value = await listDishes(params)
    // 清空已展开的缓存（列表刷新后行 id 可能没变，保留也可）
    expandedRows.value.clear()
  } finally {
    loading.value = false
  }
}

/** 行展开时按需加载食材 */
async function handleExpand(row, rows) {
  if (rows.length === 0) return
  const cached = expandedRows.value.get(row.id)
  if (cached && cached.ingredients) return
  expandedRows.value.set(row.id, { loading: true, ingredients: [], dish: row })
  try {
    const data = await getDishDetail(row.id)
    expandedRows.value.set(row.id, {
      loading: false,
      ingredients: data.ingredients || [],
      dish: data.dish || row
    })
  } catch (e) {
    expandedRows.value.set(row.id, { loading: false, ingredients: [], dish: row })
    ElMessage.error('食材加载失败')
  }
}

async function handleDelete(dish) {
  try {
    await ElMessageBox.confirm(`确定删除「${dish.name}」？`, '确认', { type: 'warning' })
    await deleteDish(dish.id)
    ElMessage.success('删除成功')
    await loadDishes()
  } catch (e) {
    if (e !== 'cancel') console.error(e)
  }
}

function handleAdd() {
  ElMessage.info('新增菜谱功能开发中，可手动编辑数据库')
}

onMounted(loadDishes)
</script>

<template>
  <div class="dish-manage">
    <PageBack />
    <el-card class="filter-card" shadow="never">
      <div class="filter-row">
        <el-input v-model="keyword" placeholder="搜索菜名" clearable style="width: 240px"
                  @keyup.enter="loadDishes">
          <template #prefix>🔍</template>
        </el-input>
        <el-select v-model="categoryFilter" placeholder="分类" clearable style="width: 160px">
          <el-option v-for="c in categories" :key="c.value" :value="c.value" :label="c.label" />
        </el-select>
        <el-button type="primary" @click="loadDishes">查询</el-button>
        <el-button @click="handleAdd">➕ 新增菜谱</el-button>
      </div>
    </el-card>

    <el-card v-loading="loading" class="list-card" shadow="never">
      <template #header>
        <div class="list-header">
          <h3>📖 菜谱库（{{ dishes.length }} 道）</h3>
          <span class="hint">💡 点击行首 ▶ 展开查看所需食材</span>
        </div>
      </template>

      <el-table :data="dishes" stripe row-key="id" @expand-change="handleExpand">
        <!-- 展开行：食材详情 -->
        <el-table-column type="expand">
          <template #default="{ row }">
            <IngredientPanel :row="expandedRows.get(row.id)" />
          </template>
        </el-table-column>

        <el-table-column prop="name" label="菜名" width="160">
          <template #default="{ row }">
            <span class="dish-name">{{ row.name }}</span>
          </template>
        </el-table-column>

        <el-table-column prop="category" label="分类" width="100">
          <template #default="{ row }">
            <el-tag :type="row.category === '主荤' ? 'danger' : row.category === '素菜' ? 'success' : 'info'" size="small">
              {{ row.category }}
            </el-tag>
          </template>
        </el-table-column>

        <el-table-column label="辣度" width="100">
          <template #default="{ row }">
            <span :class="'spicy-' + row.spicyLevel">{{ spicyLabels[row.spicyLevel] || '不辣' }}</span>
          </template>
        </el-table-column>

        <el-table-column label="时长" width="90">
          <template #default="{ row }">
            ⏱ {{ row.cookTime }}分钟
          </template>
        </el-table-column>

        <el-table-column label="适配" width="180">
          <template #default="{ row }">
            <span v-if="row.kidFriendly" class="tag-kid">👶 宝宝</span>
            <span v-if="row.elderFriendly" class="tag-elder">👴 老人</span>
          </template>
        </el-table-column>

        <el-table-column prop="description" label="做法" show-overflow-tooltip />

        <el-table-column label="食材" width="100" align="center">
          <template #default="{ row }">
            <DishIngredientPopover :dish-id="row.id" trigger-text="🥕 查看" />
          </template>
        </el-table-column>

        <el-table-column label="操作" width="120" fixed="right">
          <template #default="{ row }">
            <el-button size="small" type="danger" link @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<style scoped>
.dish-manage { max-width: 1200px; margin: 0 auto; }
.filter-card { margin-bottom: 16px; background: #fff; }
.filter-row { display: flex; gap: 12px; align-items: center; flex-wrap: wrap; }
.list-card { background: #fff; }
.list-header { display: flex; align-items: baseline; justify-content: space-between; }
.list-header h3 { color: #8b5a2b; margin: 0; }
.hint { color: #909399; font-size: 12px; }
.dish-name { font-weight: 600; color: #303133; }
</style>
