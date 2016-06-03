package com.song.nail.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.song.nail.entity.Account;
import com.song.nail.service.AccountService;

@Controller
public class HelloWorldController {
	@Autowired
	private AccountService accountService;
	
	@RequestMapping(value="/hello",method=RequestMethod.GET)
	public ModelAndView hello(){
		List<Account> accounts = accountService.getAccountList();
		ModelAndView mav = new ModelAndView();
        mav.setViewName("hello");
        mav.addObject("accounts", accounts);
        return mav;
	}

	public void setAccountService(AccountService accountService) {
		this.accountService = accountService;
	}
	
}
