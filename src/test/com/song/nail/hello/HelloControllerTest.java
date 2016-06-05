package com.song.nail.hello;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.song.nail.service.AccountService;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.*;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath*:/applicationContext-test.xml"}) 
public class HelloControllerTest {

	@Autowired
    private WebApplicationContext wac;

    private MockMvc mockMvc;
    
    @Autowired
    private AccountService accountService;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(this.wac).build();
    }
    
    //@Test
    public void getAccount() throws Exception {
        this.mockMvc.perform(get("/hello")).andDo(print())  
        .andExpect(view().name("hello"))  
        //.andExpect(MockMvcResultMatchers.model().attributeExists("accounts"))  
        ;
    }
    
    @Test
    public void testService(){
    	int a = accountService.getAccountList().size();
    	System.out.print(a);
    }

}
