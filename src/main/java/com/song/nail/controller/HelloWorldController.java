package com.song.nail.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.song.nail.entity.Account;
import com.song.nail.service.AccountService;

@Controller
@RequestMapping(value="/hello")
public class HelloWorldController {
	@Autowired
	private AccountService accountService;
	
	@RequestMapping(method=RequestMethod.GET)
	public String hello(Model model){
		List<Account> accounts = accountService.getAccountList();
		model.addAttribute("accounts", accounts);
		return "hello";
	}

	public void setAccountService(AccountService accountService) {
		this.accountService = accountService;
	}
	
}
