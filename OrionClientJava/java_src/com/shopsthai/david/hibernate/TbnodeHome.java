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
 * Home object for domain model class Tbnode.
 * @see com.shopsthai.david.hibernate.Tbnode
 * @author Hibernate Tools
 */
public class TbnodeHome {

	private static final Log log = LogFactory.getLog(TbnodeHome.class);

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

	public void persist(Tbnode transientInstance) {
		log.debug("persisting Tbnode instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(Tbnode instance) {
		log.debug("attaching dirty Tbnode instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(Tbnode instance) {
		log.debug("attaching clean Tbnode instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(Tbnode persistentInstance) {
		log.debug("deleting Tbnode instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public Tbnode merge(Tbnode detachedInstance) {
		log.debug("merging Tbnode instance");
		try {
			Tbnode result = (Tbnode) sessionFactory.getCurrentSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public Tbnode findById(int id) {
		log.debug("getting Tbnode instance with id: " + id);
		try {
			Tbnode instance = (Tbnode) sessionFactory.getCurrentSession().get(
					"com.shopsthai.david.hibernate.Tbnode", id);
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

	public List<Tbnode> findByExample(Tbnode instance) {
		log.debug("finding Tbnode instance by example");
		try {
			List<Tbnode> results = (List<Tbnode>) sessionFactory
					.getCurrentSession()
					.createCriteria("com.shopsthai.david.hibernate.Tbnode")
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
