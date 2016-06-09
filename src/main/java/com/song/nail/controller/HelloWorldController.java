package com.song.nail.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonView;
import com.song.nail.entity.Account;
import com.song.nail.service.AccountService;

@Controller
public class HelloWorldController {
	@Autowired
	private AccountService accountService;
	
	@RequestMapping(value="/",method=RequestMethod.GET)
	public ModelAndView hello(){
		List<Account> accounts = accountService.getAccountList();
		ModelAndView mav = new ModelAndView();
        mav.setViewName("hello");
        mav.addObject("accounts", accounts);
        return mav;
	}
	
	@RequestMapping(value="/hello/xml/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Account helloById(@PathVariable int id){
		Account account =  accountService.getAccountById(id);
		return account;
	}
	
	@ResponseBody
	@RequestMapping(value="/hello/json/{id}",method=RequestMethod.GET)
    public Account helloByIdJson(@PathVariable int id) {
		Account account =  accountService.getAccountById(id);
		return account;
    }
	
	@ResponseBody
	@RequestMapping(value="/hello/json",method=RequestMethod.GET)
    public List<Account> helloJson() {
		List<Account> accounts = accountService.getAccountList();
		return accounts;
    }
	
	public void setAccountService(AccountService accountService) {
		this.accountService = accountService;
	}
	
}
