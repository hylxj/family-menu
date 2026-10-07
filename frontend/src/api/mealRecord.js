import request from './request'

/** 保存某天菜单（已存在则覆盖） */
export const saveMealRecord = (data) => request.post('/meal-records', data)

/** 查询某天菜单 */
export const getMealRecord = (date, mealType = 'dinner') =>
  request.get('/meal-records', { params: { date, mealType } })

/** 历史菜单（按日期倒序） */
export const listMealHistory = (params = {}) =>
  request.get('/meal-records/history', { params })

/** 删除某条历史记录 */
export const deleteMealRecord = (id) => request.delete(`/meal-records/${id}`)
