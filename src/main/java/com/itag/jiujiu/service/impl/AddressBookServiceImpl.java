package com.itag.jiujiu.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.itag.jiujiu.entity.AddressBook;
import com.itag.jiujiu.mapper.AddressBookMapper;
import com.itag.jiujiu.service.AddressBookService;
import org.springframework.stereotype.Service;

@Service
public class AddressBookServiceImpl extends ServiceImpl<AddressBookMapper, AddressBook> implements AddressBookService {

}
