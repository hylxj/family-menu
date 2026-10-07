<script setup>
import { ref, computed, watch } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { getDishDetail, updateDishIngredients } from '@/api/dish'

const props = defineProps({
  dishId: { type: [Number, String], required: true },
  /** 触发器文字/图标 */
  triggerText: { type: String, default: '🥕 食材' }
})

const visible = ref(false)
const loading = ref(false)
const ingredients = ref([])

// 编辑态
const editMode = ref(false)
const saving = ref(false)
const draftList = ref([])
const dishInfo = ref(null)

const hasIngredients = computed(() => ingredients.value.length > 0)
const draftCount = computed(() => draftList.value.length)

const categorySelectOptions = [
  { value: '蔬菜', label: '🥬 蔬菜' },
  { value: '肉类', label: '🥩 肉类' },
  { value: '水产', label: '🐟 水产' },
  { value: '主食', label: '🍚 主食' },
  { value: '调料', label: '🧂 调料' },
  { value: '其他', label: '📦 其他' }
]

async function loadIngredients() {
  if (loading.value) return
  loading.value = true
  try {
    const data = await getDishDetail(props.dishId)
    ingredients.value = data.ingredients || []
    dishInfo.value = data.dish || null
  } catch (e) {
    ElMessage.error('食材加载失败')
  } finally {
    loading.value = false
  }
}

function onShow() {
  visible.value = true
  if (ingredients.value.length === 0 && !loading.value) {
    loadIngredients()
  }
}

function onHide() {
  if (editMode.value) {
    // 关闭时如果有未保存的修改，提示
    // 这里用 sync 弹窗简单处理
    ElMessageBox.confirm('有未保存的修改，确定关闭？', '提示', { type: 'warning' })
      .then(() => { editMode.value = false; visible.value = false; draftList.value = [] })
      .catch(() => { /* 用户取消，保持打开 */ })
  } else {
    visible.value = false
  }
}

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
    category: '其他'
  })
}

function removeRow(idx) {
  draftList.value.splice(idx, 1)
}

async function saveEdit() {
  if (!dishInfo.value) return
  const invalid = draftList.value.find(i => !i.name || !i.name.trim())
  if (invalid) {
    ElMessage.warning('食材名称不能为空')
    return
  }
  saving.value = true
  try {
    const payload = draftList.value.map((i, idx) => ({
      id: i.id,
      dishId: dishInfo.value.id,
      name: i.name.trim(),
      amount: i.amount == null ? 0 : Number(i.amount),
      unit: i.unit || '',
      category: i.category || '其他',
      sortOrder: idx
    }))
    const count = await updateDishIngredients(dishInfo.value.id, payload)
    ElMessage.success(`已保存 ${count} 种食材`)
    ingredients.value = payload
    editMode.value = false
    draftList.value = []
  } catch (e) {
    ElMessage.error('保存失败：' + (e.message || '未知错误'))
  } finally {
    saving.value = false
  }
}
</script>

<template>
  <el-popover
    :width="editMode ? 640 : 380"
    placement="left-start"
    trigger="manual"
    v-model:visible="visible"
  >
    <template #reference>
      <el-button size="small" plain round class="trigger-btn" @click.stop="onShow">
        {{ triggerText }}
      </el-button>
    </template>

    <div class="ing-popover">
      <div class="popover-header">
        <div class="popover-title">
          <span>🥬 {{ dishInfo?.name || '菜品' }} 所需食材</span>
          <span v-if="!editMode && !loading" class="ing-count">（{{ ingredients.length }} 种）</span>
          <span v-else-if="editMode" class="ing-count">（编辑中：{{ draftCount }} 种）</span>
        </div>
        <el-button size="small" link @click.stop="onHide" class="close-btn">✕</el-button>
      </div>

      <div v-if="loading" class="state">⏳ 加载中…</div>

      <template v-else-if="!editMode">
        <div v-if="!hasIngredients" class="state empty">⚠️ 暂无食材数据</div>
        <div v-else class="ing-grid">
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
        <div v-if="hasIngredients" class="footer-tip">
          💡 购物清单中的用量会按天数自动汇总
        </div>
      </template>

      <template v-else>
        <div class="ing-edit">
          <el-table :data="draftList" size="small" border max-height="320">
            <el-table-column label="#" width="50" type="index" align="center" />
            <el-table-column label="食材名" min-width="120">
              <template #default="{ row }">
                <el-input v-model="row.name" size="small" placeholder="如：五花肉" />
              </template>
            </el-table-column>
            <el-table-column label="用量" width="90">
              <template #default="{ row }">
                <el-input-number v-model="row.amount" :min="0" :step="1" size="small" controls-position="right" style="width: 100%" />
              </template>
            </el-table-column>
            <el-table-column label="单位" width="80">
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
        <div class="edit-actions">
          <el-button size="small" type="primary" plain @click="addRow">➕ 新增一行</el-button>
          <div class="spacer" />
          <el-button size="small" @click="cancelEdit" :disabled="saving">取消</el-button>
          <el-button size="small" type="success" :loading="saving" @click="saveEdit">💾 保存</el-button>
        </div>
      </template>

      <div v-if="!loading && !editMode" class="footer-actions">
        <el-button size="small" type="primary" plain round @click="enterEdit">✏️ 修改食材</el-button>
      </div>
    </div>
  </el-popover>
</template>

<style scoped>
.trigger-btn {
  font-size: 12px;
  color: #8b5a2b;
  border-color: #f0e6d2;
  padding: 2px 10px;
  height: 24px;
}
.trigger-btn:hover {
  background: #fff8e7;
  border-color: #8b5a2b;
}
.ing-popover { padding: 4px 0; }
.popover-header {
  display: flex;
  align-items: flex-start;
  justify-content: space-between;
  margin-bottom: 10px;
}
.popover-title {
  font-weight: 600;
  color: #8b5a2b;
  display: flex;
  align-items: baseline;
  gap: 8px;
  flex-wrap: wrap;
}
.ing-count { color: #909399; font-size: 12px; font-weight: normal; }
.close-btn { color: #909399; padding: 0 4px; }
.ing-grid { display: flex; flex-wrap: wrap; gap: 6px; }
.ing-tag { font-size: 12px; padding: 0 8px; height: 24px; line-height: 22px; }
.state {
  padding: 20px 0;
  text-align: center;
  color: #909399;
  font-size: 13px;
}
.state.empty { color: #c0c4cc; }
.footer-tip {
  margin-top: 10px;
  padding-top: 8px;
  border-top: 1px dashed #f0e6d2;
  color: #909399;
  font-size: 11px;
}
.footer-actions {
  margin-top: 12px;
  padding-top: 10px;
  border-top: 1px dashed #f0e6d2;
  display: flex;
  justify-content: flex-end;
}
.ing-edit {
  background: #fff;
  border-radius: 6px;
  margin-top: 4px;
}
.edit-actions {
  margin-top: 10px;
  display: flex;
  align-items: center;
  gap: 6px;
}
.spacer { flex: 1; }
</style>
