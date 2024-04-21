package com.itag.jiujiu.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itag.jiujiu.entity.User;
import com.itag.jiujiu.mapper.UserMapper;
import com.itag.jiujiu.service.UserService;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
}
