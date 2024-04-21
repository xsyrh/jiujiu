package com.itag.jiujiu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itag.jiujiu.common.CustomException;
import com.itag.jiujiu.entity.Category;
import com.itag.jiujiu.entity.Drug;
import com.itag.jiujiu.entity.Combination;
import com.itag.jiujiu.mapper.CategoryMapper;
import com.itag.jiujiu.service.CategoryService;
import com.itag.jiujiu.service.DrugService;
import com.itag.jiujiu.service.CombinationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements CategoryService {

    @Autowired
    private DrugService drugService;

    @Autowired
    private CombinationService combinationService;

    /**
     * 根据id删除分类，删除之前需要进行判断
     * @param id
     */
    @Override
    public void remove(Long id) {
        LambdaQueryWrapper<Drug> drugLambdaQueryWrapper = new LambdaQueryWrapper<>();
        //添加查询条件，根据分类id进行查询
        drugLambdaQueryWrapper.eq(Drug::getCategoryId,id);
        int count1 = drugService.count(drugLambdaQueryWrapper);

        //查询当前分类是否关联了药品，如果已经关联，抛出一个业务异常
        if(count1 > 0){
            //已经关联药品，抛出一个业务异常
            throw new CustomException("当前分类下关联了药品，不能删除");
        }

        //查询当前分类是否关联了组合，如果已经关联，抛出一个业务异常
        LambdaQueryWrapper<Combination> combinationLambdaQueryWrapper = new LambdaQueryWrapper<>();
        //添加查询条件，根据分类id进行查询
        combinationLambdaQueryWrapper.eq(Combination::getCategoryId,id);
        int count2 = combinationService.count();
        if(count2 > 0){
            //已经关联组合，抛出一个业务异常
            throw new CustomException("当前分类下关联了组合，不能删除");
        }

        //正常删除分类
        super.removeById(id);
    }
}
