package com.itag.jiujiu.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itag.jiujiu.entity.ShoppingCart;
import com.itag.jiujiu.mapper.ShoppingCartMapper;
import com.itag.jiujiu.service.ShoppingCartService;
import org.springframework.stereotype.Service;

@Service
public class ShoppingCartServiceImpl extends ServiceImpl<ShoppingCartMapper, ShoppingCart> implements ShoppingCartService {

}
