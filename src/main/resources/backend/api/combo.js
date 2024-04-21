// 查询列表数据
const getCombinationPage = (params) => {
  return $axios({
    url: '/combination/page',
    method: 'get',
    params
  })
}

// 删除数据接口
const deleteCombination = (ids) => {
  return $axios({
    url: '/combination',
    method: 'delete',
    params: { ids }
  })
}

// 修改数据接口
const editCombination = (params) => {
  return $axios({
    url: '/combination',
    method: 'put',
    data: { ...params }
  })
}

// 新增数据接口
const addCombination = (params) => {
  return $axios({
    url: '/combination',
    method: 'post',
    data: { ...params }
  })
}

// 查询详情接口
const queryCombinationById = (id) => {
  return $axios({
    url: `/combination/${id}`,
    method: 'get'
  })
}

// 批量起售禁售
const combinationStatusByStatus = (params) => {
  return $axios({
    url: `/combination/status/${params.status}`,
    method: 'post',
    params: { ids: params.ids }
  })
}
