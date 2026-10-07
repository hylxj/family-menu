import request from './request'

/** 生成菜单 */
export const generateMenu = (params) => request.post('/menu/generate', null, { params })

/** 换一道菜 */
export const swapDish = (category, excludeDishIds, spicyLevel = 3) =>
  request.post(`/menu/swap?category=${category}&spicyLevel=${spicyLevel}`, excludeDishIds || [])
