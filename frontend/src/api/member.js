import request from './request'

export const listMembers = () => request.get('/members')
export const saveMember = (data) => request.post('/members', data)
export const updateMember = (id, data) => request.put(`/members/${id}`, data)
export const deleteMember = (id) => request.delete(`/members/${id}`)
export const toggleMember = (id) => request.post(`/members/${id}/toggle`)