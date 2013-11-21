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
 * Home object for domain model class Tbfolder.
 * @see com.shopsthai.david.hibernate.Tbfolder
 * @author Hibernate Tools
 */
public class TbfolderHome {

	private static final Log log = LogFactory.getLog(TbfolderHome.class);

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

	public void persist(Tbfolder transientInstance) {
		log.debug("persisting Tbfolder instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(Tbfolder instance) {
		log.debug("attaching dirty Tbfolder instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Tbfolder instance) {
		log.debug("attaching clean Tbfolder instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(Tbfolder persistentInstance) {
		log.debug("deleting Tbfolder instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Tbfolder merge(Tbfolder detachedInstance) {
		log.debug("merging Tbfolder instance");
		try {
			Tbfolder result = (Tbfolder) sessionFactory.getCurrentSession()
					.merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public Tbfolder findById(java.math.BigDecimal id) {
		log.debug("getting Tbfolder instance with id: " + id);
		try {
			Tbfolder instance = (Tbfolder) sessionFactory.getCurrentSession()
					.get("com.shopsthai.david.hibernate.Tbfolder", id);
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

	public List<Tbfolder> findByExample(Tbfolder instance) {
		log.debug("finding Tbfolder instance by example");
		try {
			List<Tbfolder> results = (List<Tbfolder>) sessionFactory
					.getCurrentSession()
					.createCriteria("com.shopsthai.david.hibernate.Tbfolder")
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
