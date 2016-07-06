package com.song.nail.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.song.nail.dao.AccountDao;
import com.song.nail.entity.Account;
@Component
public class AccountService{
	@Autowired
	private AccountDao accountDao;

	public void setAccountDao(AccountDao accountDao) {
		this.accountDao = accountDao;
	}
	
	public List<Account> getAccountList(){
		return accountDao.getAccountList();
	}
	
	public Account getAccountById(int id){
		return accountDao.getAccountById(id);
	}
	
	public void saveAccount(Account account){
		accountDao.saveAccount(account);
	}

}
