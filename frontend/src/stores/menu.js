import { defineStore } from 'pinia'
import { ref, computed } from 'vue'

export const useMenuStore = defineStore('menu', () => {
  const weekMenu = ref(null)

  const hasMenu = computed(() => weekMenu.value !== null)

  function setMenu(menu) {
    weekMenu.value = menu
  }

  function clearMenu() {
    weekMenu.value = null
  }

  return { weekMenu, hasMenu, setMenu, clearMenu }
})