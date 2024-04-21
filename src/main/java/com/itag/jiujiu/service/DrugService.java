package com.itag.jiujiu.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.itag.jiujiu.dto.DrugDto;
import com.itag.jiujiu.entity.Drug;

import java.util.List;

public interface DrugService extends IService<Drug> {

    //新增药品，同时插入药品对应的注意数据，需要操作两张表：drug、drug_attention
    public void saveWithAttention(DrugDto drugDto);

    //根据id查询药品信息和对应的注意信息
    public DrugDto getByIdWithAttention(Long id);

    //更新药品信息，同时更新对应的注意信息
    public void updateWithAttention(DrugDto drugDto);

    //删除药品
    void removeWithDrug(List<Long> ids);
}
