package com.itag.jiujiu;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@Slf4j
@SpringBootApplication
@ServletComponentScan
@EnableTransactionManagement
public class JiujiuApplication {
    public static void main(String[] args) {
        SpringApplication.run(JiujiuApplication.class,args);
        log.info("项目启动成功...");
        log.info("后端访问地址：http://localhost:8080/backend/page/login/login.html");
        log.info("前端访问地址：http://localhost:8080/front/page/login.html");
    }
}
