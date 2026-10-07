import { createRouter, createWebHashHistory } from 'vue-router'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: () => import('@/views/Home.vue'),
    meta: { title: '晚饭吃什么' }
  },
  {
    path: '/menu',
    name: 'WeekMenu',
    component: () => import('@/views/WeekMenu.vue'),
    meta: { title: '本周菜单', parent: '/' }
  },
  {
    path: '/shopping-list',
    name: 'ShoppingList',
    component: () => import('@/views/ShoppingList.vue'),
    meta: { title: '购物清单', parent: '/' }
  },
  {
    path: '/dishes',
    name: 'DishManage',
    component: () => import('@/views/DishManage.vue'),
    meta: { title: '菜谱库', parent: '/' }
  },
  {
    path: '/members',
    name: 'MemberManage',
    component: () => import('@/views/MemberManage.vue'),
    meta: { title: '家庭成员', parent: '/' }
  },
  {
    path: '/history',
    name: 'MealHistory',
    component: () => import('@/views/MealHistory.vue'),
    meta: { title: '吃饭历史', parent: '/' }
  }
]

const router = createRouter({
  history: createWebHashHistory(),
  routes
})

// 路由切换时自动更新页面标题
router.afterEach((to) => {
  const base = '家庭饭桌决策系统'
  document.title = to.meta?.title ? `${to.meta.title} · ${base}` : base
})

export default router
