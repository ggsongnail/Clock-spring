package com.song.nail.webservice;

import java.util.ArrayList;
import java.util.List;

import javax.jws.WebMethod;
import javax.jws.WebService;
import javax.jws.soap.SOAPBinding;
import javax.jws.soap.SOAPBinding.ParameterStyle;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import com.song.nail.entity.Account;
import com.song.nail.service.AccountService;

@WebService(serviceName="AccountService")
@SOAPBinding(parameterStyle=ParameterStyle.BARE)
public class AccountServiceEndpoint{

    @Autowired
    private AccountService accountService;

    @WebMethod
    public ArrayList<Account> getAccounts() {
        return (ArrayList<Account>) accountService.getAccountList();
    }

}