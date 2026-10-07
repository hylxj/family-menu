<script setup>
import { onMounted, ref, reactive, computed } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { listMembers, saveMember, updateMember, deleteMember, toggleMember } from '@/api/member'
import { listAllIngredients } from '@/api/dish'
import PageBack from '@/components/PageBack.vue'

const members = ref([])
const ingredientOptions = ref([])
const dialogVisible = ref(false)
const submitting = ref(false)
const formRef = ref(null)

const SPICY_LABELS = ['不辣', '微辣', '中辣', '爆辣']
const SPICY_EMOJIS = ['🌱', '🌶️', '🌶️🌶️', '🔥']

const form = reactive({
  id: null,
  name: '',
  relation: '',
  spicyMax: 1,
  allergies: [],   // 多选
  notes: '',
  isActive: true
})

const rules = {
  name: [{ required: true, message: '请输入称呼', trigger: 'blur' }]
}

const activeCount = computed(() => members.value.filter(m => m.isActive).length)

async function loadMembers() {
  const res = await listMembers()
  members.value = Array.isArray(res) ? res : (res?.data || [])
}

async function loadIngredients() {
  try {
    const res = await listAllIngredients()
    ingredientOptions.value = Array.isArray(res) ? res : (res?.data || [])
  } catch (e) {
    console.warn('食材列表加载失败，可手动输入过敏食材', e)
  }
}

function resetForm() {
  Object.assign(form, {
    id: null,
    name: '',
    relation: '',
    spicyMax: 1,
    allergies: [],
    notes: '',
    isActive: true
  })
}

function openAdd() {
  resetForm()
  dialogVisible.value = true
}

function openEdit(row) {
  Object.assign(form, {
    id: row.id,
    name: row.name,
    relation: row.relation || '',
    spicyMax: row.spicyMax ?? 1,
    allergies: row.allergies ? row.allergies.split(',').map(s => s.trim()).filter(Boolean) : [],
    notes: row.notes || '',
    isActive: row.isActive
  })
  dialogVisible.value = true
}

async function submit() {
  try {
    await formRef.value.validate()
  } catch { return; }
  submitting.value = true
  try {
    const payload = {
      name: form.name,
      relation: form.relation || null,
      spicyMax: form.spicyMax,
      allergies: (form.allergies || []).join(',') || null,
      notes: form.notes || null,
      isActive: form.isActive
    }
    if (form.id) {
      await updateMember(form.id, payload)
      ElMessage.success('已更新')
    } else {
      await saveMember(payload)
      ElMessage.success('已添加')
    }
    dialogVisible.value = false
    await loadMembers()
  } finally {
    submitting.value = false
  }
}

async function remove(row) {
  await ElMessageBox.confirm(`确定删除「${row.name}」吗？`, '提示', { type: 'warning' })
  await deleteMember(row.id)
  ElMessage.success('已删除')
  await loadMembers()
}

async function toggle(row) {
  await toggleMember(row.id)
  ElMessage.success(row.isActive ? '已停用' : '已启用')
  await loadMembers()
}

function spicyText(level) {
  return SPICY_LABELS[level] || '?'
}
function spicyEmoji(level) {
  return SPICY_EMOJIS[level] || '?'
}

onMounted(() => {
  loadMembers()
  loadIngredients()
})
</script>

<template>
  <div class="member-manage">
    <PageBack />
    <el-card shadow="never" class="header-card">
      <div class="header-row">
        <div>
          <h2>👨‍👩‍👧 家庭成员</h2>
          <p class="subtitle">共 {{ members.length }} 位，活跃 {{ activeCount }} 位</p>
        </div>
        <el-button type="primary" size="large" @click="openAdd">
          ➕ 添加成员
        </el-button>
      </div>
    </el-card>

    <el-empty v-if="!members.length" description="还没有家庭成员，先加一个吧" />

    <el-row :gutter="16" v-else>
      <el-col :xs="24" :sm="12" :md="8" v-for="m in members" :key="m.id" class="member-col">
        <el-card shadow="hover" class="member-card" :class="{ inactive: !m.isActive }">
          <div class="member-top">
            <div class="avatar">{{ m.name?.[0] || '?' }}</div>
            <div class="info">
              <div class="name-row">
                <span class="name">{{ m.name }}</span>
                <el-tag v-if="m.relation" size="small" type="info">{{ m.relation }}</el-tag>
                <el-tag v-if="!m.isActive" size="small" type="warning">已停用</el-tag>
              </div>
              <div class="spicy">
                <span class="emoji">{{ spicyEmoji(m.spicyMax) }}</span>
                <span>最高辣度：{{ spicyText(m.spicyMax) }}</span>
              </div>
            </div>
          </div>

          <div v-if="m.allergies" class="allergies">
            <span class="label">过敏食材：</span>
            <el-tag
              v-for="a in m.allergies.split(',').filter(Boolean)"
              :key="a"
              size="small"
              type="danger"
              effect="plain"
              class="allergy-tag"
            >🚫 {{ a }}</el-tag>
          </div>

          <p v-if="m.notes" class="notes">💬 {{ m.notes }}</p>

          <div class="actions">
            <el-button size="small" @click="openEdit(m)">编辑</el-button>
            <el-button size="small" @click="toggle(m)">
              {{ m.isActive ? '停用' : '启用' }}
            </el-button>
            <el-button size="small" type="danger" plain @click="remove(m)">删除</el-button>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <!-- 编辑弹窗 -->
    <el-dialog
      v-model="dialogVisible"
      :title="form.id ? '编辑成员' : '添加成员'"
      width="520px"
      :close-on-click-modal="false"
    >
      <el-form ref="formRef" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="称呼" prop="name">
          <el-input v-model="form.name" placeholder="如：爸爸、妈妈、女儿" maxlength="20" />
        </el-form-item>
        <el-form-item label="身份">
          <el-input v-model="form.relation" placeholder="如：奶奶、宝宝（可选）" maxlength="20" />
        </el-form-item>
        <el-form-item label="辣度上限">
          <el-radio-group v-model="form.spicyMax">
            <el-radio-button :value="0">🌱 不辣</el-radio-button>
            <el-radio-button :value="1">🌶️ 微辣</el-radio-button>
            <el-radio-button :value="2">🌶️ 中辣</el-radio-button>
            <el-radio-button :value="3">🔥 爆辣</el-radio-button>
          </el-radio-group>
          <div class="hint">取家庭中最严格的（最低的）作为全局上限</div>
        </el-form-item>
        <el-form-item label="过敏食材">
          <el-select
            v-model="form.allergies"
            multiple
            filterable
            allow-create
            default-first-option
            placeholder="选择或输入过敏食材（如：花生、海鲜）"
            style="width: 100%"
          >
            <el-option v-for="opt in ingredientOptions" :key="opt" :label="opt" :value="opt" />
          </el-select>
          <div class="hint">从已有食材中选，没有的可以直接打字</div>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="form.notes" type="textarea" :rows="2" maxlength="200" show-word-limit />
        </el-form-item>
        <el-form-item label="状态">
          <el-switch v-model="form.isActive" active-text="启用" inactive-text="停用" />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" :loading="submitting" @click="submit">保存</el-button>
      </template>
    </el-dialog>
  </div>
</template>

<style scoped>
.member-manage { padding: 16px; }
.header-card { margin-bottom: 16px; }
.header-row { display: flex; align-items: center; justify-content: space-between; }
.header-row h2 { margin: 0 0 4px; }
.subtitle { margin: 0; color: #999; font-size: 13px; }

.member-col { margin-bottom: 16px; }
.member-card { height: 100%; transition: all 0.2s; }
.member-card.inactive { opacity: 0.6; }

.member-top { display: flex; gap: 14px; align-items: flex-start; margin-bottom: 12px; }
.avatar {
  width: 52px; height: 52px; border-radius: 50%;
  background: linear-gradient(135deg, #ffd89b, #19547b);
  color: #fff; font-size: 22px; font-weight: bold;
  display: flex; align-items: center; justify-content: center;
  flex-shrink: 0;
}
.info { flex: 1; min-width: 0; }
.name-row { display: flex; align-items: center; gap: 6px; margin-bottom: 6px; flex-wrap: wrap; }
.name { font-size: 18px; font-weight: 600; }
.spicy { color: #666; font-size: 13px; display: flex; gap: 6px; align-items: center; }
.emoji { font-size: 16px; }

.allergies { margin: 8px 0; }
.allergies .label { color: #999; font-size: 12px; margin-right: 4px; }
.allergy-tag { margin: 2px 4px 2px 0; }

.notes {
  font-size: 13px; color: #888; margin: 8px 0;
  padding: 6px 10px; background: #f8f8f8; border-radius: 6px;
}

.actions {
  display: flex; gap: 8px; margin-top: 12px;
  padding-top: 12px; border-top: 1px dashed #eee;
}

.hint { font-size: 12px; color: #999; margin-top: 4px; line-height: 1.4; }
</style>