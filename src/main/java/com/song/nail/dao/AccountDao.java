package com.song.nail.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.song.nail.entity.Account;

//@Repository(value = "accountDao")
@Component
public class AccountDao{
	private EntityManager em = null;
	
	@PersistenceContext
    public void setEntityManager(EntityManager em) {
        this.em = em;
    }

    @Transactional(readOnly = true)
    @SuppressWarnings("unchecked")
    public List<Account> getAccountList() {
        return em.createQuery("select a from Account a order by a.id").getResultList();
    }
    
	@Transactional(readOnly = false)
	public void saveAccount(Account account) {
		em.merge(account);
	}

}
