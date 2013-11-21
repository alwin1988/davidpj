package com.shopsthai.david.hibernate;

// Generated Nov 14, 2013 10:42:18 PM by Hibernate Tools 3.4.0.CR1

import static org.hibernate.criterion.Example.create;

import java.util.List;

import javax.naming.InitialContext;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * Home object for domain model class Cafolder.
 * @see com.shopsthai.david.hibernate.Cafolder
 * @author Hibernate Tools
 */
public class CafolderHome {

	private static final Log log = LogFactory.getLog(CafolderHome.class);

	private final SessionFactory sessionFactory = getSessionFactory();
	
	@Autowired
	protected SessionFactory getSessionFactory() {
		try {
			return (SessionFactory) new InitialContext()
					.lookup("SessionFactory");
		} catch (Exception e) {
			log.error("Could not locate SessionFactory in JNDI", e);
			throw new IllegalStateException(
					"Could not locate SessionFactory in JNDI");
		}
	}

	public void persist(Cafolder transientInstance) {
		log.debug("persisting Cafolder instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(Cafolder instance) {
		log.debug("attaching dirty Cafolder instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Cafolder instance) {
		log.debug("attaching clean Cafolder instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(Cafolder persistentInstance) {
		log.debug("deleting Cafolder instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Cafolder merge(Cafolder detachedInstance) {
		log.debug("merging Cafolder instance");
		try {
			Cafolder result = (Cafolder) sessionFactory.getCurrentSession()
					.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public Cafolder findById(java.lang.Integer id) {
		log.debug("getting Cafolder instance with id: " + id);
		try {
			Cafolder instance = (Cafolder) sessionFactory.getCurrentSession()
					.get("com.shopsthai.david.hibernate.Cafolder", id);
			if (instance == null) {
				log.debug("get successful, no instance found");
			} else {
				log.debug("get successful, instance found");
			}
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List<Cafolder> findByExample(Cafolder instance) {
		log.debug("finding Cafolder instance by example");
		try {
			List<Cafolder> results = (List<Cafolder>) sessionFactory
					.getCurrentSession()
					.createCriteria("com.shopsthai.david.hibernate.Cafolder")
					.add(create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
	
	public List<Cafolder> getAllCafolder() {
		log.debug("finding Cafolder instance by example");
		try {
			List<Cafolder> results = (List<Cafolder>) sessionFactory
					.getCurrentSession()
					.createQuery("from Cafolder").list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
	
}
