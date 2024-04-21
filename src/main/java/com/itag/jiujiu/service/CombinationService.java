package com.itag.jiujiu.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.itag.jiujiu.dto.CombinationDto;
import com.itag.jiujiu.entity.Combination;

import java.util.List;

public interface CombinationService extends IService<Combination> {
    /**
     * 新增注意，同时需要保存注意和药品的关联关系
     * @param combinationDto
     */
    public void saveWithDrug(CombinationDto combinationDto);

    /**
     * 删除注意，同时需要删除注意和药品的关联数据
     * @param ids
     */
    public void removeWithDrug(List<Long> ids);

    /**
     * 根据id查询组合信息和对应的注意信息
     * @param id
     * @return
     */
    CombinationDto getByIdWithAttention(Long id);

    /**
     * 修改组合
     * @param combinationDto
     */
    void updateWithAttention(CombinationDto combinationDto);
}
