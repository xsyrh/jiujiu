package com.itag.jiujiu.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itag.jiujiu.common.R;
import com.itag.jiujiu.dto.DrugDto;
import com.itag.jiujiu.dto.CombinationDto;
import com.itag.jiujiu.entity.Category;
import com.itag.jiujiu.entity.Combination;
import com.itag.jiujiu.service.CombinationDrugService;
import com.itag.jiujiu.service.CategoryService;
import com.itag.jiujiu.service.CombinationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 组合管理
 */

@RestController
@RequestMapping("/combination")
@Slf4j
public class CombinationController {

    @Autowired
    private CombinationService combinationService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private CombinationDrugService combinationDrugService;

    /**
     * 新增组合
     * @param combinationDto
     * @return
     */
    @PostMapping
    public R<String> save(@RequestBody CombinationDto combinationDto){
        log.info("组合信息：{}",combinationDto);

        combinationService.saveWithDrug(combinationDto);

        return R.success("新增组合成功");
    }

    /**
     * 组合分页查询
     * @param page
     * @param pageSize
     * @param name
     * @return
     */
    @GetMapping("/page")
    public R<Page> page(int page,int pageSize,String name){
        //分页构造器对象
        Page<Combination> pageInfo = new Page<>(page,pageSize);
        Page<CombinationDto> dtoPage = new Page<>();

        LambdaQueryWrapper<Combination> queryWrapper = new LambdaQueryWrapper<>();
        //添加查询条件，根据name进行like模糊查询
        queryWrapper.like(name != null,Combination::getName,name);
        //添加排序条件，根据更新时间降序排列
        queryWrapper.orderByDesc(Combination::getUpdateTime);

        combinationService.page(pageInfo,queryWrapper);

        //对象拷贝
        BeanUtils.copyProperties(pageInfo,dtoPage,"records");
        List<Combination> records = pageInfo.getRecords();

        List<CombinationDto> list = records.stream().map((item) -> {
            CombinationDto combinationDto = new CombinationDto();
            //对象拷贝
            BeanUtils.copyProperties(item,combinationDto);
            //分类id
            Long categoryId = item.getCategoryId();
            //根据分类id查询分类对象
            Category category = categoryService.getById(categoryId);
            if(category != null){
                //分类名称
                String categoryName = category.getName();
                combinationDto.setCategoryName(categoryName);
            }
            return combinationDto;
        }).collect(Collectors.toList());

        dtoPage.setRecords(list);
        return R.success(dtoPage);
    }

    /**
     * 删除组合
     * @param ids
     * @return
     */
    @DeleteMapping
    public R<String> delete(@RequestParam List<Long> ids){
        log.info("ids:{}",ids);

        combinationService.removeWithDrug(ids);

        return R.success("组合数据删除成功");
    }

    /**
     * 根据条件查询组合数据
     * @param combination
     * @return
     */
    @GetMapping("/list")
    public R<List<Combination>> list(Combination combination){
        LambdaQueryWrapper<Combination> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(combination.getCategoryId() != null,Combination::getCategoryId,combination.getCategoryId());
        queryWrapper.eq(combination.getStatus() != null,Combination::getStatus,combination.getStatus());
        queryWrapper.orderByDesc(Combination::getUpdateTime);

        List<Combination> list = combinationService.list(queryWrapper);

        return R.success(list);
    }

    /**
     * 根据id查询组合信息和对应的注意信息
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public R<CombinationDto> get(@PathVariable Long id){

        CombinationDto combinationDto = combinationService.getByIdWithAttention(id);

        return R.success(combinationDto);
    }

    /**
     * 修改组合
     * @param combinationDto
     * @return
     */
    @PutMapping
    public R<String> update(@RequestBody CombinationDto combinationDto){
        combinationService.updateWithAttention(combinationDto);
        return R.success("修改成功");
    }

    /**
     * 修改组合状态
     * @param status
     * @param ids
     * @return
     */
    @PostMapping("/status/{status}")
    public R<String> status(@PathVariable Long status, Long[] ids){
        LambdaUpdateWrapper<Combination> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.in(Combination::getId, ids);
        updateWrapper.set(Combination::getStatus, status);
        //修改
        combinationService.update(updateWrapper);
        return R.success("修改成功");
    }
}
