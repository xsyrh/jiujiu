package com.itag.jiujiu.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itag.jiujiu.common.BaseContext;
import com.itag.jiujiu.common.R;
import com.itag.jiujiu.entity.Orders;
import com.itag.jiujiu.service.OrderService;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * 订单
 */
@Slf4j
@RestController
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    /**
     * 用户下单
     *
     * @param orders
     * @return
     */
    @PostMapping("/submit")
    public R<String> submit(@RequestBody Orders orders) {
        log.info("订单数据：{}", orders);
        orderService.submit(orders);
        return R.success("下单成功");
    }

    /**
     * 后台查看订单信息
     *
     * @param page
     * @param pageSize
     * @param number
     * @return
     */
    @GetMapping("/page")
    public R<Page> page(int page, int pageSize, Long number) {

        Page<Orders> pageInfo = new Page<>(page, pageSize);

        LambdaQueryWrapper<Orders> queryWrapper = new LambdaQueryWrapper<>();
        //添加过滤条件
        queryWrapper.like(number != null, Orders::getNumber, number);

        orderService.page(pageInfo, queryWrapper);

        return R.success(pageInfo);
    }

    /**
     * 用户查询订单
     * @param page
     * @param pageSize
     * @return
     */
    @GetMapping("/userPage")
    public R<Page> userPage(int page, int pageSize){

        Long id = BaseContext.getCurrentId();

        Page<Orders> pageInfo = new Page<>(page, pageSize);

        LambdaQueryWrapper<Orders> queryWrapper = new LambdaQueryWrapper<>();
        //此用户的id
        queryWrapper.eq(Orders::getUserId, id);
        //排序orderByDesc
        queryWrapper.orderByAsc(Orders::getOrderTime);
        orderService.page(pageInfo);

        return R.success(pageInfo);
    }

}