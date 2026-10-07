<script setup>
import { useRouter } from 'vue-router'
import { ElCard, ElButton } from 'element-plus'

const router = useRouter()

const features = [
  {
    icon: '🍲',
    title: '本周菜单',
    desc: '一键生成 7 天不重样的川菜晚餐',
    color: '#f56c6c',
    path: '/menu'
  },
  {
    icon: '🛒',
    title: '购物清单',
    desc: '自动汇总食材，方便发给妈妈',
    color: '#67c23a',
    path: '/shopping-list'
  },
  {
    icon: '📖',
    title: '菜谱库',
    desc: '管理你家的川菜菜谱',
    color: '#409eff',
    path: '/dishes'
  },
  {
    icon: '👨‍👩‍👧',
    title: '家庭成员',
    desc: '录入成员辣度、过敏食材',
    color: '#e6a23c',
    path: '/members'
  },
  {
    icon: '📜',
    title: '吃饭历史',
    desc: '翻看过去吃过的菜，别再重样',
    color: '#9c27b0',
    path: '/history'
  }
]
</script>

<template>
  <div class="home">
    <el-card class="welcome" shadow="hover">
      <div class="welcome-content">
        <h1>🍽️ 晚饭吃什么</h1>
        <p class="subtitle">告别每天纠结，让算法帮你决策</p>
        <el-button type="primary" size="large" @click="router.push('/menu')">
          🚀 立即生成本周菜单
        </el-button>
      </div>
    </el-card>

    <div class="features">
      <el-card v-for="f in features" :key="f.path" class="feature-card" shadow="hover"
               @click="router.push(f.path)">
        <div class="feature-icon" :style="{ background: f.color + '20', color: f.color }">
          {{ f.icon }}
        </div>
        <h3>{{ f.title }}</h3>
        <p>{{ f.desc }}</p>
      </el-card>
    </div>

    <el-card class="tips" shadow="never">
      <h3>💡 使用提示</h3>
      <ul>
        <li>第一次使用请先到「家庭成员」录入家人辣度和过敏食材</li>
        <li>然后到「菜谱库」录入你的家常菜</li>
        <li>默认已收录 50 道经典川菜</li>
        <li>生成菜单时会自动过滤最近 14 天吃过的菜</li>
        <li>购物清单可一键分享给妈妈</li>
        <li>点击<a @click="router.push('/history')" style="color:#9c27b0;cursor:pointer;font-weight:600">📜 吃饭历史</a>查看过去吃过的菜</li>
      </ul>
    </el-card>
  </div>
</template>

<style scoped>
.home { max-width: 1000px; margin: 0 auto; }
.welcome {
  background: linear-gradient(135deg, #ff9966 0%, #ff5e62 100%);
  color: white;
  border: none;
  margin-bottom: 24px;
}
.welcome-content { text-align: center; padding: 32px 16px; }
.welcome-content h1 { font-size: 36px; margin-bottom: 12px; }
.subtitle { font-size: 16px; opacity: 0.9; margin-bottom: 24px; }
.welcome :deep(.el-button) {
  background: white;
  color: #ff5e62;
  border: none;
  font-weight: 600;
}

.features {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 16px;
  margin-bottom: 24px;
}
.feature-card { cursor: pointer; transition: all 0.3s; }
.feature-card:hover { transform: translateY(-4px); }
.feature-icon {
  width: 64px; height: 64px;
  border-radius: 16px;
  display: flex; align-items: center; justify-content: center;
  font-size: 32px;
  margin-bottom: 12px;
}
.feature-card h3 { margin-bottom: 8px; color: #303133; }
.feature-card p { color: #606266; font-size: 14px; }

.tips { background: #fafafa; }
.tips h3 { margin-bottom: 12px; color: #8b5a2b; }
.tips ul { padding-left: 24px; color: #606266; line-height: 1.8; }
</style>