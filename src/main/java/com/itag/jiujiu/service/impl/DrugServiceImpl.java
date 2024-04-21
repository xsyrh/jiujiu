package com.itag.jiujiu.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itag.jiujiu.common.CustomException;
import com.itag.jiujiu.dto.DrugDto;
import com.itag.jiujiu.entity.Drug;
import com.itag.jiujiu.mapper.DrugMapper;
import com.itag.jiujiu.entity.DrugAttention;
import com.itag.jiujiu.service.DrugAttentionService;
import com.itag.jiujiu.service.DrugService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class DrugServiceImpl extends ServiceImpl<DrugMapper, Drug> implements DrugService {

    @Autowired
    private DrugAttentionService drugAttentionService;

    /**
     * 新增药品，同时保存对应的注意数据
     * @param drugDto
     */
    @Transactional
    public void saveWithAttention(DrugDto drugDto) {
        //保存药品的基本信息到药品表drug
        this.save(drugDto);

        Long drugId = drugDto.getId();//药品id

        //药品注意
        List<DrugAttention> attentions = drugDto.getAttentions();
        attentions = attentions.stream().map((item) -> {
            item.setDrugId(drugId);
            return item;
        }).collect(Collectors.toList());

        //保存药品注意数据到药品注意表drug_attention
        drugAttentionService.saveBatch(attentions);

    }

    /**
     * 根据id查询药品信息和对应的注意信息
     * @param id
     * @return
     */
    public DrugDto getByIdWithAttention(Long id) {
        //查询药品基本信息，从drug表查询
        Drug drug = this.getById(id);

        DrugDto drugDto = new DrugDto();
        BeanUtils.copyProperties(drug,drugDto);

        //查询当前药品对应的注意信息，从drug_attention表查询
        LambdaQueryWrapper<DrugAttention> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(DrugAttention::getDrugId,drug.getId());
        List<DrugAttention> attentions = drugAttentionService.list(queryWrapper);
        drugDto.setAttentions(attentions);

        return drugDto;
    }

    //更新数据
    @Override
    @Transactional
    public void updateWithAttention(DrugDto drugDto) {
        //更新drug表基本信息
        this.updateById(drugDto);

        //清理当前药品对应注意数据---drug_attention表的delete操作
        LambdaQueryWrapper<DrugAttention> queryWrapper = new LambdaQueryWrapper();
        queryWrapper.eq(DrugAttention::getDrugId,drugDto.getId());

        drugAttentionService.remove(queryWrapper);

        //添加当前提交过来的注意数据---drug_attention表的insert操作
        List<DrugAttention> attentions = drugDto.getAttentions();

        attentions = attentions.stream().map((item) -> {
            item.setDrugId(drugDto.getId());
            return item;
        }).collect(Collectors.toList());

        drugAttentionService.saveBatch(attentions);
    }

    /**
     * 删除药品
     * @param ids
     */
    @Override
    public void removeWithDrug(List<Long> ids) {
        //判断商品的售卖状态
        LambdaQueryWrapper<Drug> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.in(Drug::getId, ids);
        queryWrapper.eq(Drug::getStatus, 1);

        int count = this.count(queryWrapper);
        if (count > 0){
            //如果不能删除，抛出一个业务异常
            throw new CustomException("药品正在售卖中，不能删除");
        }

        //如果没有查到售卖中的药品
        //删除药品数据
        this.removeByIds(ids);

        //再删除药品对应的注意数据
        LambdaQueryWrapper<DrugAttention> queryWrapperDrugAttention = new LambdaQueryWrapper<>();
        queryWrapperDrugAttention.in(DrugAttention::getDrugId, ids);
        drugAttentionService.remove(queryWrapperDrugAttention);

    }
}
