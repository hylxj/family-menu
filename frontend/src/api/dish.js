import request from './request'

export const listDishes = (params) => request.get('/dishes', { params })
export const getDishDetail = (id) => request.get(`/dishes/${id}`)
export const saveDish = (data) => request.post('/dishes', data)
export const updateDish = (id, data) => request.put(`/dishes/${id}`, data)
export const deleteDish = (id) => request.delete(`/dishes/${id}`)
export const batchImportDishes = (data) => request.post('/dishes/batch', data)
export const listAllIngredients = () => request.get('/dishes/ingredients')
/** 只更新某道菜的食材列表（不修改菜品本身） */
export const updateDishIngredients = (id, ingredients) => request.put(`/dishes/${id}/ingredients`, ingredients)