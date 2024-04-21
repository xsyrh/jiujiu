package com.itag.jiujiu.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itag.jiujiu.entity.OrderDetail;
import com.itag.jiujiu.mapper.OrderDetailMapper;
import com.itag.jiujiu.service.OrderDetailService;
import org.springframework.stereotype.Service;

@Service
public class OrderDetailServiceImpl extends ServiceImpl<OrderDetailMapper, OrderDetail> implements OrderDetailService {

}