<script setup>
import { ref, computed, watch } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getDishDetail, updateDishIngredients } from '@/api/dish'

const props = defineProps({
  row: { type: Object, default: () => null }
})

// 编辑态：true 时每行可改；false 时只读
const editMode = ref(false)
const saving = ref(false)
// 本地编辑列表：[{ id, name, amount, unit, category, _isNew, _deleted }]
const draftList = ref([])

const isLoading = computed(() => !props.row || props.row.loading)
const isEmpty = computed(() => props.row && !props.row.loading && (!props.row.ingredients || props.row.ingredients.length === 0))
const ingredients = computed(() => props.row?.ingredients || [])

const categoryOptions = [
  { value: '蔬菜', label: '蔬菜' },
  { value: '肉类', label: '水产', split: true },
  { value: '水产', label: '水产' },
  { value: '主食', label: '主食' },
  { value: '调料', label: '调料' },
  { value: '其他', label: '其他' }
]
// 实际下拉项（去重 + 修正格式）
const categorySelectOptions = [
  { value: '蔬菜', label: '🥬 蔬菜' },
  { value: '肉类', label: '🥩 肉类' },
  { value: '水产', label: '🐟 水产' },
  { value: '主食', label: '🍚 主食' },
  { value: '调料', label: '🧂 调料' },
  { value: '其他', label: '📦 其他' }
]

function tagType(category) {
  switch (category) {
    case '蔬菜': return 'success'
    case '肉类': return 'danger'
    case '水产': return 'warning'
    case '主食': return 'info'
    default: return ''
  }
}

function formatAmount(ing) {
  if (ing.amount == null) return ing.unit || ''
  if (Number(ing.amount) === 0) return ing.unit || ''
  return `${ing.amount} ${ing.unit || ''}`.trim()
}

// 进入编辑态：把后端列表拷贝到 draft
function enterEdit() {
  draftList.value = ingredients.value.map(i => ({ ...i }))
  editMode.value = true
}

function cancelEdit() {
  draftList.value = []
  editMode.value = false
}

function addRow() {
  draftList.value.push({
    id: null,
    name: '',
    amount: 1,
    unit: 'g',
    category: '其他',
    _isNew: true
  })
}

function removeRow(idx) {
  draftList.value.splice(idx, 1)
}

// 保存：把 draftList 调接口，再回写到缓存
async function saveEdit() {
  if (!props.row) return
  // 校验：name 不能为空
  const invalid = draftList.value.find(i => !i.name || !i.name.trim())
  if (invalid) {
    ElMessage.warning('食材名称不能为空')
    return
  }
  saving.value = true
  try {
    // 仅传后端需要的字段
    const payload = draftList.value.map((i, idx) => ({
      id: i.id,
      dishId: props.row.dish?.id,
      name: i.name.trim(),
      amount: i.amount == null ? 0 : Number(i.amount),
      unit: i.unit || '',
      category: i.category || '其他',
      sortOrder: idx
    }))
    const count = await updateDishIngredients(props.row.dish.id, payload)
    ElMessage.success(`已保存 ${count} 种食材`)
    // 更新本地缓存，触发父组件重新渲染
    props.row.ingredients = payload
    editMode.value = false
    draftList.value = []
  } catch (e) {
    ElMessage.error('保存失败：' + (e.message || '未知错误'))
  } finally {
    saving.value = false
  }
}

// props.row 变化时（行折叠/切换），自动退出编辑态
watch(() => props.row, () => {
  if (editMode.value) cancelEdit()
})
</script>

<template>
  <div v-if="isLoading" class="ing-loading">
    {{ row && row.loading ? '⏳ 正在加载食材…' : '加载中…' }}
  </div>
  <div v-else-if="isEmpty" class="ing-empty">
    ⚠️ 暂无食材数据
    <el-button size="small" type="primary" plain class="empty-btn" @click="enterEdit">+ 添加食材</el-button>
  </div>
  <div v-else class="ing-panel">
    <div class="ing-title">
      <span>🥬 所需食材</span>
      <span v-if="!editMode" class="ing-count">（{{ ingredients.length }} 种）</span>
      <span v-else class="ing-count">（编辑中：{{ draftList.length }} 种）</span>
      <div class="title-actions">
        <template v-if="!editMode">
          <el-button size="small" type="primary" plain round @click="enterEdit">✏️ 修改</el-button>
        </template>
        <template v-else>
          <el-button size="small" type="success" :loading="saving" @click="saveEdit">💾 保存</el-button>
          <el-button size="small" @click="cancelEdit" :disabled="saving">取消</el-button>
          <el-button size="small" type="warning" plain @click="addRow">➕ 新增一行</el-button>
        </template>
      </div>
    </div>

    <!-- 只读态 -->
    <div v-if="!editMode" class="ing-grid">
      <el-tag
        v-for="ing in ingredients"
        :key="ing.id"
        :type="tagType(ing.category)"
        effect="plain"
        class="ing-tag"
      >
        {{ ing.name }}{{ formatAmount(ing) ? '  ' + formatAmount(ing) : '' }}
      </el-tag>
    </div>

    <!-- 编辑态 -->
    <div v-else class="ing-edit">
      <el-table :data="draftList" size="small" border>
        <el-table-column label="#" width="50" type="index" align="center" />
        <el-table-column label="食材名" min-width="120">
          <template #default="{ row }">
            <el-input v-model="row.name" size="small" placeholder="如：五花肉" />
          </template>
        </el-table-column>
        <el-table-column label="用量" width="100">
          <template #default="{ row }">
            <el-input-number v-model="row.amount" :min="0" :step="1" size="small" controls-position="right" style="width: 100%" />
          </template>
        </el-table-column>
        <el-table-column label="单位" width="90">
          <template #default="{ row }">
            <el-input v-model="row.unit" size="small" placeholder="g/勺/个" />
          </template>
        </el-table-column>
        <el-table-column label="分类" width="110">
          <template #default="{ row }">
            <el-select v-model="row.category" size="small" style="width: 100%">
              <el-option
                v-for="o in categorySelectOptions"
                :key="o.value"
                :value="o.value"
                :label="o.label"
              />
            </el-select>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="60" align="center" fixed="right">
          <template #default="{ $index }">
            <el-button size="small" type="danger" link @click="removeRow($index)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<style scoped>
.ing-panel {
  background: linear-gradient(135deg, #faf6ee 0%, #fff8e7 100%);
  border-left: 3px solid #8b5a2b;
  border-radius: 6px;
  padding: 12px 16px;
  margin: 4px 0;
}
.ing-title {
  font-weight: 600;
  color: #8b5a2b;
  margin-bottom: 10px;
  display: flex;
  align-items: center;
  gap: 8px;
  flex-wrap: wrap;
}
.ing-count { color: #909399; font-size: 12px; font-weight: normal; }
.title-actions { margin-left: auto; display: flex; gap: 6px; }
.ing-grid { display: flex; flex-wrap: wrap; gap: 6px; }
.ing-tag { font-size: 12px; padding: 0 8px; height: 24px; line-height: 22px; }
.ing-loading,
.ing-empty {
  padding: 12px 16px;
  color: #909399;
  font-size: 13px;
  text-align: center;
}
.empty-btn { margin-left: 12px; }
.ing-edit {
  background: #fff;
  border-radius: 6px;
  padding: 8px;
  margin-top: 4px;
}
</style>
