package com.itag.jiujiu.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.itag.jiujiu.entity.Category;

public interface CategoryService extends IService<Category> {

    public void remove(Long id);

}
