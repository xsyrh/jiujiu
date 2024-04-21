package com.itag.jiujiu.dto;

import com.itag.jiujiu.entity.Combination;
import com.itag.jiujiu.entity.CombinationDrug;
import lombok.Data;
import java.util.List;

@Data
public class CombinationDto extends Combination {

    //组合对应的药品数据
    private List<CombinationDrug> combinationDruges;

    private String categoryName;
}
