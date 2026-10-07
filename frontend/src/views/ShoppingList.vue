<script setup>
import { computed, onMounted, ref } from 'vue'
import { useMenuStore } from '@/stores/menu'
import { ElMessage } from 'element-plus'
import PageBack from '@/components/PageBack.vue'

const menuStore = useMenuStore()
const checkedItems = ref(new Set())

function isChecked(name) {
  return checkedItems.value.has(name)
}

const shoppingList = computed(() => menuStore.weekMenu?.shoppingList)

const summary = computed(() => {
  if (!shoppingList.value) return ''
  const lines = []
  lines.push(`🛒 ${shoppingList.value.startDate} 至 ${shoppingList.value.endDate} 购物清单`)
  lines.push(`共 ${shoppingList.value.totalCount} 种食材\n`)
  for (const group of shoppingList.value.groups) {
    lines.push(`${group.icon} ${group.category}`)
    for (const item of group.items) {
      lines.push(`  · ${item.name} ${item.amount || ''}${item.unit || ''}`)
    }
    lines.push('')
  }
  return lines.join('\n')
})

function toggleCheck(key) {
  if (checkedItems.value.has(key)) {
    checkedItems.value.delete(key)
  } else {
    checkedItems.value.add(key)
  }
  // 触发 Set 响应式更新（Set/Map 直接 mutate 不会通知依赖）
  checkedItems.value = new Set(checkedItems.value)
}

async function copyToClipboard() {
  try {
    await navigator.clipboard.writeText(summary.value)
    ElMessage.success('已复制到剪贴板，去微信发给妈妈吧')
  } catch (e) {
    ElMessage.error('复制失败，请手动截图')
  }
}

function printList() {
  window.print()
}

onMounted(() => {
  if (!menuStore.weekMenu) {
    ElMessage.warning('请先到「本周菜单」生成菜单')
  }
})
</script>

<template>
  <div class="shopping-list">
    <PageBack to="/menu" label="返回本周菜单" />
    <el-card v-if="!shoppingList" class="empty">
      <el-empty description="还没有购物清单，请先到「本周菜单」生成" />
    </el-card>

    <template v-else>
      <el-card class="header-card" shadow="never">
        <div class="header-row">
          <div>
            <h2>🛒 {{ shoppingList.startDate }} 至 {{ shoppingList.endDate }} 购物清单</h2>
            <p class="subtitle">共 {{ shoppingList.totalCount }} 种食材</p>
          </div>
          <div class="actions">
            <el-button type="primary" @click="copyToClipboard">📋 复制文本</el-button>
            <el-button @click="printList">🖨️ 打印</el-button>
          </div>
        </div>
      </el-card>

      <el-card v-for="group in shoppingList.groups" :key="group.category" class="group-card" shadow="hover">
        <template #header>
          <div class="group-header">
            <span class="group-icon">{{ group.icon }}</span>
            <span class="group-title">{{ group.category }}</span>
            <el-tag size="small">{{ group.items.length }} 种</el-tag>
          </div>
        </template>

        <div class="items">
          <div v-for="item in group.items" :key="item.name"
               class="item-row"
               :class="{ checked: isChecked(item.name) }"
               @click="toggleCheck(item.name)">
            <el-checkbox :model-value="isChecked(item.name)" @change="toggleCheck(item.name)" />
            <span class="item-name">{{ item.name }}</span>
            <span class="item-amount">
              <span v-if="item.amount">{{ item.amount }}</span>
              <span v-if="item.unit">{{ item.unit }}</span>
            </span>
            <span v-if="item.usedIn" class="item-used">用于：{{ item.usedIn }}</span>
          </div>
        </div>
      </el-card>

      <el-card class="share-card" shadow="never">
        <h3>📱 一键分享给妈妈</h3>
        <p>点击"复制文本"后，到微信粘贴发给妈妈即可：</p>
        <pre class="share-preview">{{ summary }}</pre>
      </el-card>
    </template>
  </div>
</template>

<style scoped>
.shopping-list { max-width: 900px; margin: 0 auto; }
.empty { background: #fff; }
.header-card { background: linear-gradient(135deg, #fff8e7 0%, #ffeed1 100%); margin-bottom: 16px; }
.header-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 12px;
}
.actions { display: flex; gap: 8px; }
.subtitle { color: #909399; font-size: 14px; margin-top: 4px; }

.group-card { margin-bottom: 16px; background: #fff; }
.group-header { display: flex; align-items: center; gap: 8px; }
.group-icon { font-size: 24px; }
.group-title { font-size: 18px; font-weight: 600; flex: 1; }

.items { display: flex; flex-direction: column; gap: 4px; }
.item-row {
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 12px;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.2s;
}
.item-row:hover { background: #fafafa; }
.item-row.checked { opacity: 0.5; text-decoration: line-through; }
.item-name { font-size: 16px; flex: 1; font-weight: 500; }
.item-amount {
  background: #fff8e7;
  padding: 4px 10px;
  border-radius: 4px;
  color: #8b5a2b;
  font-weight: 600;
}
.item-used { font-size: 12px; color: #909399; }

.share-card { background: #fafafa; margin-top: 16px; }
.share-card h3 { color: #8b5a2b; margin-bottom: 8px; }
.share-preview {
  background: #fff;
  padding: 16px;
  border-radius: 8px;
  font-family: 'Courier New', monospace;
  font-size: 14px;
  white-space: pre-wrap;
  margin-top: 12px;
  border: 1px solid #f0e6d2;
}

@media print {
  .header-card, .share-card, .actions { display: none !important; }
  .item-row.checked { display: none; }
}
</style>