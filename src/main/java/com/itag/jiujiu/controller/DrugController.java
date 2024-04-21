package com.itag.jiujiu.controller;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.itag.jiujiu.common.CustomException;
import com.itag.jiujiu.dto.DrugDto;
import com.itag.jiujiu.common.R;
import com.itag.jiujiu.entity.Category;
import com.itag.jiujiu.entity.Drug;
import com.itag.jiujiu.entity.DrugAttention;
import com.itag.jiujiu.service.CategoryService;
import com.itag.jiujiu.service.DrugAttentionService;
import com.itag.jiujiu.service.DrugService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

/**
 * 药品管理
 */
@RestController
@RequestMapping("/drug")
@Slf4j
public class DrugController {
    @Autowired
    private DrugService drugService;

    @Autowired
    private DrugAttentionService drugAttentionService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private RedisTemplate redisTemplate;

    /**
     * 新增药品
     * @param drugDto
     * @return
     */
    @PostMapping
    public R<String> save(@RequestBody DrugDto drugDto){
        log.info(drugDto.toString());

        drugService.saveWithAttention(drugDto);
        //清理餐品缓存数据
        redisTemplate.delete("drug_" + drugDto.getCategoryId() + "_" + drugDto.getStatus());

        return R.success("新增药品成功");
    }

    /**
     * 药品信息分页查询
     * @param page
     * @param pageSize
     * @param name
     * @return
     */
    @GetMapping("/page")
    public R<Page> page(int page,int pageSize,String name){

        //构造分页构造器对象
        Page<Drug> pageInfo = new Page<>(page,pageSize);
        Page<DrugDto> drugDtoPage = new Page<>();

        //条件构造器
        LambdaQueryWrapper<Drug> queryWrapper = new LambdaQueryWrapper<>();
        //添加过滤条件
        queryWrapper.like(name != null,Drug::getName,name);
        //添加排序条件
        queryWrapper.orderByDesc(Drug::getUpdateTime);

        //执行分页查询
        drugService.page(pageInfo,queryWrapper);

        //对象拷贝
        BeanUtils.copyProperties(pageInfo,drugDtoPage,"records");

        List<Drug> records = pageInfo.getRecords();

        List<DrugDto> list = records.stream().map((item) -> {
            DrugDto drugDto = new DrugDto();

            BeanUtils.copyProperties(item,drugDto);

            Long categoryId = item.getCategoryId();//分类id
            //根据id查询分类对象
            Category category = categoryService.getById(categoryId);

            if(category != null){
                String categoryName = category.getName();
                drugDto.setCategoryName(categoryName);
            }
            return drugDto;
        }).collect(Collectors.toList());

        drugDtoPage.setRecords(list);

        return R.success(drugDtoPage);
    }

    /**
     * 根据id查询药品信息和对应的注意信息
     * @param id
     * @return
     */
    @GetMapping("/{id}")
    public R<DrugDto> get(@PathVariable Long id){

        DrugDto drugDto = drugService.getByIdWithAttention(id);

        return R.success(drugDto);
    }

    /**
     * 修改药品
     * @param drugDto
     * @return
     */
    @PutMapping
    public R<String> update(@RequestBody DrugDto drugDto){
        log.info(drugDto.toString());

        drugService.updateWithAttention(drugDto);
        //清理药品的缓存数据
        redisTemplate.delete("drug_" + drugDto.getCategoryId() + "_" + drugDto.getStatus());

        return R.success("修改药品成功");
    }

    /**
     * 根据条件查询对应的药品数据
     * @param drug
     * @return
     */
    @GetMapping("/list")
    public R<List<DrugDto>> list(Drug drug){
        List<DrugDto> drugDtoList = null;

        String key = "drug_" + drug.getCategoryId() + "_" + drug.getStatus();

        //从redis中获取缓存数据
        drugDtoList = (List<DrugDto>)redisTemplate.opsForValue().get(key);

        if (drugDtoList != null){
            //如果存在，直接返回，无需查询数据库
            return R.success(drugDtoList);
        }

        //构造查询条件
        LambdaQueryWrapper<Drug> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(drug.getCategoryId() != null ,Drug::getCategoryId,drug.getCategoryId());
        //添加条件，查询状态为1（起售状态）的药品
        queryWrapper.eq(Drug::getStatus,1);

        //添加排序条件
        queryWrapper.orderByAsc(Drug::getSort).orderByDesc(Drug::getUpdateTime);

        List<Drug> list = drugService.list(queryWrapper);

        drugDtoList = list.stream().map((item) -> {
            DrugDto drugDto = new DrugDto();

            BeanUtils.copyProperties(item,drugDto);

            Long categoryId = item.getCategoryId();//分类id
            //根据id查询分类对象
            Category category = categoryService.getById(categoryId);

            if(category != null){
                String categoryName = category.getName();
                drugDto.setCategoryName(categoryName);
            }

            //当前药品的id
            Long drugId = item.getId();
            LambdaQueryWrapper<DrugAttention> lambdaQueryWrapper = new LambdaQueryWrapper<>();
            lambdaQueryWrapper.eq(DrugAttention::getDrugId,drugId);
            //SQL:select * from drug_attention where drug_id = ?
            List<DrugAttention> drugAttentionList = drugAttentionService.list(lambdaQueryWrapper);
            drugDto.setAttentions(drugAttentionList);
            return drugDto;
        }).collect(Collectors.toList());

        //如果不存在，需要查询数据库，并且将查询到的数据储存到redis中
        redisTemplate.opsForValue().set(key, drugDtoList, 60, TimeUnit.MINUTES);

        return R.success(drugDtoList);
    }

    /**
     * 修改药品状态
     * @param status
     * @param ids
     * @return
     */
    @PostMapping("/status/{status}")
    R<String> status(@PathVariable Long status, Long[] ids){
        LambdaUpdateWrapper<Drug> updateWrapper = new LambdaUpdateWrapper<>();
        updateWrapper.in(Drug::getId, ids);
        updateWrapper.set(Drug::getStatus, status);

        drugService.update(updateWrapper);
        //清理药品的缓存数据

        return R.success("修改成功");
    }

    /**
     * 删除药品
     * @param ids
     * @return
     */
    @DeleteMapping
    R<String> delete(@RequestParam List<Long> ids){

        drugService.removeWithDrug(ids);

        return R.success("药品数据删除成功");
    }

}
