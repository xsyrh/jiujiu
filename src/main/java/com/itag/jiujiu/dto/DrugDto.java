package com.itag.jiujiu.dto;

import com.itag.jiujiu.entity.Drug;
import com.itag.jiujiu.entity.DrugAttention;
import lombok.Data;
import java.util.ArrayList;
import java.util.List;

@Data
public class DrugDto extends Drug {

    //药品对应的注意数据
    private List<DrugAttention> attentions = new ArrayList<>();
    //药品名称
    private String categoryName;
    //药品份数
    private Integer copies;
}
