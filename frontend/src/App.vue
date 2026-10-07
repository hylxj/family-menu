<script setup>
import { RouterView } from 'vue-router'
</script>

<template>
  <el-container class="app-container">
    <el-header class="app-header">
      <div class="logo">
        <span class="logo-icon">🍽️</span>
        <span class="logo-text">家庭饭桌决策系统</span>
      </div>
      <div class="header-tip">
        <el-tag size="small" type="success" effect="plain">让做饭不再纠结</el-tag>
      </div>
    </el-header>
    <el-main class="app-main">
      <RouterView />
    </el-main>
  </el-container>
</template>

<style scoped>
.app-container {
  min-height: 100vh;
  background: linear-gradient(135deg, #fff8e7 0%, #ffeed1 100%);
}
.app-header {
  background: #fff;
  border-bottom: 1px solid #f0e6d2;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
  height: 64px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.04);
}
.logo {
  display: flex;
  align-items: center;
  gap: 12px;
}
.logo-icon { font-size: 28px; }
.logo-text {
  font-size: 18px;
  font-weight: 600;
  color: #8b5a2b;
}
.app-main {
  padding: 24px;
  max-width: 1400px;
  margin: 0 auto;
  width: 100%;
}
</style>