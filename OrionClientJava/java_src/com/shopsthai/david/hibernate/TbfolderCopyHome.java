package com.shopsthai.david.hibernate;

// Generated Nov 14, 2013 10:42:18 PM by Hibernate Tools 3.4.0.CR1

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.SessionFactory;
import static org.hibernate.criterion.Example.create;

/**
 * Home object for domain model class TbfolderCopy.
 * @see com.shopsthai.david.hibernate.TbfolderCopy
 * @author Hibernate Tools
 */
public class TbfolderCopyHome {

	private static final Log log = LogFactory.getLog(TbfolderCopyHome.class);

	private final SessionFactory sessionFactory = getSessionFactory();

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

	public void persist(TbfolderCopy transientInstance) {
		log.debug("persisting TbfolderCopy instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(TbfolderCopy instance) {
		log.debug("attaching dirty TbfolderCopy instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(TbfolderCopy instance) {
		log.debug("attaching clean TbfolderCopy instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(TbfolderCopy persistentInstance) {
		log.debug("deleting TbfolderCopy instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public TbfolderCopy merge(TbfolderCopy detachedInstance) {
		log.debug("merging TbfolderCopy instance");
		try {
			TbfolderCopy result = (TbfolderCopy) sessionFactory
					.getCurrentSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public TbfolderCopy findById(java.math.BigDecimal id) {
		log.debug("getting TbfolderCopy instance with id: " + id);
		try {
			TbfolderCopy instance = (TbfolderCopy) sessionFactory
					.getCurrentSession().get(
							"com.shopsthai.david.hibernate.TbfolderCopy", id);
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

	public List<TbfolderCopy> findByExample(TbfolderCopy instance) {
		log.debug("finding TbfolderCopy instance by example");
		try {
			List<TbfolderCopy> results = (List<TbfolderCopy>) sessionFactory
					.getCurrentSession()
					.createCriteria(
							"com.shopsthai.david.hibernate.TbfolderCopy")
					.add(create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}
}
