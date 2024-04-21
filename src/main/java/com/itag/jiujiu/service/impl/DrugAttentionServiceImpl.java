package com.itag.jiujiu.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itag.jiujiu.mapper.DrugAttentionMapper;
import com.itag.jiujiu.service.DrugAttentionService;
import com.itag.jiujiu.entity.DrugAttention;
import org.springframework.stereotype.Service;

@Service
public class DrugAttentionServiceImpl extends ServiceImpl<DrugAttentionMapper,DrugAttention> implements DrugAttentionService {
}
