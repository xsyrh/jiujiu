//获取所有的药品分类
function categoryListApi() {
    return $axios({
      'url': '/category/list',
      'method': 'get',
    })
  }

//获取药品分类对应的药品
function drugListApi(data) {
    return $axios({
        'url': '/drug/list',
        'method': 'get',
        params:{...data}
    })
}

//获取药品分类对应的组合
function combinationListApi(data) {
    return $axios({
        'url': '/combination/list',
        'method': 'get',
        params:{...data}
    })
}

//获取购物车内商品的集合
function cartListApi(data) {
    return $axios({
        'url': '/shoppingCart/list',
        //'url': '/front/cartData.json',
        'method': 'get',
        params:{...data}
    })
}

//购物车中添加商品
function  addCartApi(data){
    return $axios({
        'url': '/shoppingCart/add',
        'method': 'post',
        data
      })
}

//购物车中修改商品
function  updateCartApi(data){
    return $axios({
        'url': '/shoppingCart/sub',
        'method': 'post',
        data
      })
}

//删除购物车的商品
function clearCartApi() {
    return $axios({
        'url': '/shoppingCart/clean',
        'method': 'delete',
    })
}

//获取组合的全部药品
function setMealDrugDetailsApi(id) {
    return $axios({
        'url': `/combination/drug/${id}`,
        'method': 'get',
    })
}


