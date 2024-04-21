package com.itag.jiujiu.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.itag.jiujiu.common.BaseContext;
import com.itag.jiujiu.common.R;
import com.itag.jiujiu.entity.ShoppingCart;
import com.itag.jiujiu.service.ShoppingCartService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 购物车
 */
@Slf4j
@RestController
@RequestMapping("/shoppingCart")
public class ShoppingCartController {

    @Autowired
    private ShoppingCartService shoppingCartService;

    /**
     * 添加购物车
     * @param shoppingCart
     * @return
     */
    @PostMapping("/add")
    public R<ShoppingCart> add(@RequestBody ShoppingCart shoppingCart){
        log.info("购物车数据:{}",shoppingCart);

        //设置用户id，指定当前是哪个用户的购物车数据
        Long currentId = BaseContext.getCurrentId();
        shoppingCart.setUserId(currentId);

        Long drugId = shoppingCart.getDrugId();

        LambdaQueryWrapper<ShoppingCart> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ShoppingCart::getUserId,currentId);

        if(drugId != null){
            //添加到购物车的是药品
            queryWrapper.eq(ShoppingCart::getDrugId,drugId);

        }else{
            //添加到购物车的是组合
            queryWrapper.eq(ShoppingCart::getCombinationId,shoppingCart.getCombinationId());
        }

        //查询当前药品或者组合是否在购物车中
        //SQL:select * from shopping_cart where user_id = ? and drug_id/combination_id = ?
        ShoppingCart cartServiceOne = shoppingCartService.getOne(queryWrapper);

        if(cartServiceOne != null){
            //如果已经存在，就在原来数量基础上加一
            Integer number = cartServiceOne.getNumber();
            cartServiceOne.setNumber(number + 1);
            shoppingCartService.updateById(cartServiceOne);
        }else{
            //如果不存在，则添加到购物车，数量默认就是一
            shoppingCart.setNumber(1);
            shoppingCart.setCreateTime(LocalDateTime.now());
            shoppingCartService.save(shoppingCart);
            cartServiceOne = shoppingCart;
        }

        return R.success(cartServiceOne);
    }

    /**
     * 查看购物车
     * @return
     */
    @GetMapping("/list")
    public R<List<ShoppingCart>> list(){
        log.info("查看购物车...");

        LambdaQueryWrapper<ShoppingCart> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ShoppingCart::getUserId,BaseContext.getCurrentId());
        queryWrapper.orderByAsc(ShoppingCart::getCreateTime);

        List<ShoppingCart> list = shoppingCartService.list(queryWrapper);

        return R.success(list);
    }

    /**
     * 清空购物车
     * @return
     */
    @DeleteMapping("/clean")
    public R<String> clean(){
        //SQL:delete from shopping_cart where user_id = ?

        LambdaQueryWrapper<ShoppingCart> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ShoppingCart::getUserId,BaseContext.getCurrentId());

        shoppingCartService.remove(queryWrapper);

        return R.success("清空购物车成功");
    }

    /**
     * 减少商品数量
     * @param drugId
     * @param combinationId
     * @return
     */
    @PostMapping("/sub")
    public R<String> sub(Long drugId, Long combinationId){

        LambdaUpdateWrapper<ShoppingCart> updateWrapper = new LambdaUpdateWrapper<>();
        //判断此用户的购物车
        updateWrapper.eq(ShoppingCart::getUserId,BaseContext.getCurrentId());
        updateWrapper.eq(drugId !=null, ShoppingCart::getDrugId, drugId);
        updateWrapper.eq(combinationId != null, ShoppingCart::getCombinationId, combinationId);

        ShoppingCart shoppingCartOne = shoppingCartService.getOne(updateWrapper);

        //如果购物车此商品数量为1，直接删除商品
        if (shoppingCartOne.getNumber() == 1){
            shoppingCartService.remove(updateWrapper);
        } else {
            int number = shoppingCartOne.getNumber() - 1;
            updateWrapper.set(ShoppingCart::getNumber, number);
            shoppingCartService.update(updateWrapper);
        }
        return R.success("修改成功");

    }
}