package com.itag.jiujiu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itag.jiujiu.common.BaseContext;
import com.itag.jiujiu.common.CustomException;
import com.itag.jiujiu.dto.CombinationDto;
import com.itag.jiujiu.entity.Combination;
import com.itag.jiujiu.entity.CombinationDrug;
import com.itag.jiujiu.mapper.CombinationMapper;
import com.itag.jiujiu.service.CombinationDrugService;
import com.itag.jiujiu.service.CombinationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class CombinationServiceImpl extends ServiceImpl<CombinationMapper, Combination> implements CombinationService {

    @Autowired
    private CombinationDrugService combinationDrugService;

    /**
     * 新增组合，同时需要保存组合和药品的关联关系
     * @param combinationDto
     */
    @Transactional
    public void saveWithDrug(CombinationDto combinationDto) {
        //保存组合的基本信息，操作combination，执行insert操作
        this.save(combinationDto);

        List<CombinationDrug> combinationDruges = combinationDto.getCombinationDruges();
        combinationDruges.stream().map((item) -> {
            item.setCombinationId(combinationDto.getId());
            return item;
        }).collect(Collectors.toList());

        //保存组合和药品的关联信息，操作combination_drug,执行insert操作
        combinationDrugService.saveBatch(combinationDruges);
    }

    /**
     * 删除组合，同时需要删除组合和药品的关联数据
     * @param ids
     */
    @Transactional
    public void removeWithDrug(List<Long> ids) {
        //select count(*) from combination where id in (1,2,3) and status = 1
        //查询组合状态，确定是否可用删除
        LambdaQueryWrapper<Combination> queryWrapper = new LambdaQueryWrapper();
        queryWrapper.in(Combination::getId,ids);
        queryWrapper.eq(Combination::getStatus,1);

        int count = this.count(queryWrapper);
        if(count > 0){
            //如果不能删除，抛出一个业务异常
            throw new CustomException("组合正在售卖中，不能删除");
        }

        //如果可以删除，先删除组合表中的数据---combination
        this.removeByIds(ids);

        //delete from combination_drug where combination_id in (1,2,3)
        LambdaQueryWrapper<CombinationDrug> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.in(CombinationDrug::getCombinationId,ids);
        //删除关系表中的数据----combination_drug
        combinationDrugService.remove(lambdaQueryWrapper);
    }

    /**
     * 根据id查询组合信息和对应的注意信息
     * @param id
     * @return
     */
    @Override
    public CombinationDto getByIdWithAttention(Long id) {

        Combination combination = this.getById(id);
        CombinationDto combinationDto = new CombinationDto();

        BeanUtils.copyProperties(combination, combinationDto);

        LambdaQueryWrapper<CombinationDrug> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(CombinationDrug::getCombinationId, combination.getId());

        List<CombinationDrug> list = combinationDrugService.list(queryWrapper);
        combinationDto.setCombinationDruges(list);

        return combinationDto;
    }

    /**
     * 修改组合
     * @param combinationDto
     */
    @Override
    public void updateWithAttention(CombinationDto combinationDto) {

        this.updateById(combinationDto);

        //删除组合对应的药品
        LambdaQueryWrapper<CombinationDrug> queryWrapperCombinationDrug = new LambdaQueryWrapper<>();
        queryWrapperCombinationDrug.eq(CombinationDrug::getCombinationId, combinationDto.getId());
        combinationDrugService.remove(queryWrapperCombinationDrug);

        //新增组合对应的药品
        List<CombinationDrug> combinationDruges = combinationDto.getCombinationDruges();
        combinationDruges.stream().map((item) -> {
            item.setCombinationId(combinationDto.getId());
            return item;
        }).collect(Collectors.toList());

        //保存组合和药品的关联信息，操作combination_drug,执行insert操作
        combinationDrugService.saveBatch(combinationDruges);
    }
}
