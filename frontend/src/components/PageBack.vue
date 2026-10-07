<script setup>
import { computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'

const props = defineProps({
  /** 返回到指定路由路径；不传则用路由 meta.parent，默认 / */
  to: { type: String, default: '' },
  /** 按钮文字 */
  label: { type: String, default: '返回主页' }
})

const router = useRouter()
const route = useRoute()

const target = computed(() => props.to || route.meta?.parent || '/')

function goBack() {
  if (target.value && route.path !== target.value) {
    router.push(target.value)
    return
  }
  if (window.history.length > 1) {
    router.back()
    return
  }
  router.push('/')
}
</script>

<template>
  <div class="page-back">
    <el-button class="back-btn" round @click="goBack">
      <span class="arrow">←</span>
      <span class="label">{{ label }}</span>
    </el-button>
  </div>
</template>

<style scoped>
.page-back {
  margin: 4px 0 16px 0;
  display: flex;
  align-items: center;
}
.back-btn {
  background: #fff;
  border: 1px solid #f0e6d2;
  color: #8b5a2b;
  font-weight: 600;
  padding: 6px 16px;
  height: 32px;
  box-shadow: 0 2px 6px rgba(139, 90, 43, 0.08);
  transition: all 0.2s;
}
.back-btn:hover {
  background: #fff8e7;
  border-color: #8b5a2b;
  transform: translateX(-2px);
  box-shadow: 0 4px 12px rgba(139, 90, 43, 0.16);
}
.arrow {
  display: inline-block;
  font-size: 18px;
  margin-right: 8px;
  font-weight: 700;
  transition: transform 0.2s;
}
.back-btn:hover .arrow {
  transform: translateX(-3px);
}
.label { font-size: 14px; }
</style>
