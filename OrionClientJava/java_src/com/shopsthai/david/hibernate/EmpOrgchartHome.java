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
 * Home object for domain model class EmpOrgchart.
 * @see com.shopsthai.david.hibernate.EmpOrgchart
 * @author Hibernate Tools
 */
public class EmpOrgchartHome {

	private static final Log log = LogFactory.getLog(EmpOrgchartHome.class);

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

	public void persist(EmpOrgchart transientInstance) {
		log.debug("persisting EmpOrgchart instance");
		try {
			sessionFactory.getCurrentSession().persist(transientInstance);
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	public void attachDirty(EmpOrgchart instance) {
		log.debug("attaching dirty EmpOrgchart instance");
		try {
			sessionFactory.getCurrentSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(EmpOrgchart instance) {
		log.debug("attaching clean EmpOrgchart instance");
		try {
			sessionFactory.getCurrentSession().lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void delete(EmpOrgchart persistentInstance) {
		log.debug("deleting EmpOrgchart instance");
		try {
			sessionFactory.getCurrentSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public EmpOrgchart merge(EmpOrgchart detachedInstance) {
		log.debug("merging EmpOrgchart instance");
		try {
			EmpOrgchart result = (EmpOrgchart) sessionFactory
					.getCurrentSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public EmpOrgchart findById(java.lang.String id) {
		log.debug("getting EmpOrgchart instance with id: " + id);
		try {
			EmpOrgchart instance = (EmpOrgchart) sessionFactory
					.getCurrentSession().get(
							"com.shopsthai.david.hibernate.EmpOrgchart", id);
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

	public List<EmpOrgchart> findByExample(EmpOrgchart instance) {
		log.debug("finding EmpOrgchart instance by example");
		try {
			List<EmpOrgchart> results = (List<EmpOrgchart>) sessionFactory
					.getCurrentSession()
					.createCriteria("com.shopsthai.david.hibernate.EmpOrgchart")
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
