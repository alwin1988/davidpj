package com.shopsthai.david.flexservices;

import static org.hibernate.criterion.Example.create;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.springframework.flex.remoting.RemotingDestination;
import org.springframework.flex.remoting.RemotingInclude;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.shopsthai.david.hibernate.Cafolder;
import com.shopsthai.david.hibernate.CafolderHome;
import com.shopsthai.david.hibernate.HibernateUtil;

@Service
@Repository
@RemotingDestination	
public class CafolderService {

	private static final Log log = LogFactory.getLog(CafolderHome.class);

	Session session = HibernateUtil.getSessionFactory().openSession();
	
	
	
//	@Autowired
//	private final SessionFactory sessionFactory = HibernateUtil.getSessionFactory();
	
//	@Autowired
//	protected SessionFactory getSessionFactory() {
//		try {
//			return (SessionFactory) new InitialContext()
//					.lookup("SessionFactory");
//		} catch (Exception e) {
//			log.error("Could not locate SessionFactory in JNDI", e);
//			throw new IllegalStateException(
//					"Could not locate SessionFactory in JNDI");
//		}
//	}

	@RemotingInclude
	public void persist(Cafolder transientInstance) {
		log.debug("persisting Cafolder instance");
		try {
			Transaction transaction = null;
			transaction = session.beginTransaction();
				transientInstance.setIdx(null);
				session.save(transientInstance);
			transaction.commit();
			log.debug("persist successful");
		} catch (RuntimeException re) {
			log.error("persist failed", re);
			throw re;
		}
	}

	@RemotingInclude
	public void attachDirty(Cafolder instance) {
		log.debug("attaching dirty Cafolder instance");
		try {
			session.saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	@RemotingInclude
	public void attachClean(Cafolder instance) {
		log.debug("attaching clean Cafolder instance");
		try {
			session.lock(instance, LockMode.NONE);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	@RemotingInclude
	public void delete(Cafolder persistentInstance) {
		Transaction transaction = null;
		transaction = session.beginTransaction();
		Cafolder caf = (Cafolder) session.get(Cafolder.class, persistentInstance.getIdx());	
		session.delete(caf);
		transaction.commit();
	}
	
	@RemotingInclude
	public void merge(Cafolder clf) {
		Transaction transaction = null;
		transaction = session.beginTransaction();
		Cafolder caf = (Cafolder)session.get(Cafolder.class, clf.getIdx());
		caf.setName(clf.getName());
		caf.setDescription(clf.getDescription());
		caf.setLabel(clf.getLabel());
		transaction.commit();
	}

	@RemotingInclude
	public Cafolder findById(java.lang.Integer id) {
		log.debug("getting Cafolder instance with id: " + id);
		try {
			Cafolder instance = (Cafolder) session
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

	@RemotingInclude
	public List<Cafolder> findByExample(Cafolder instance) {
		log.debug("finding Cafolder instance by example");
		try {
			
			List<Cafolder> results = (List<Cafolder>) session
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
	
	@SuppressWarnings("unchecked")
	@RemotingInclude
	public List<Cafolder> getAllCafolder() {
		List<Cafolder> results = null;
		List<Cafolder> res = null;
		    results = (List<Cafolder>) session.createQuery("from Cafolder").list();
			res = (List<Cafolder>) xmltoArraycollection(results,0);
			return res;
	}
	
	
	private List<Cafolder>  xmltoArraycollection(List<Cafolder> xmlc,Integer pid) {
		List<Cafolder> result = new java.util.ArrayList<Cafolder>();
		for(Cafolder cafolder : xmlc ) {
			if(cafolder.getParentid().equals(0)) {
				cafolder.setChildren(floderbyparent(cafolder.getIdx(), xmlc ));
				result.add(cafolder);
			}
		}
		return   (List<Cafolder>) result;
}
	
	private List<Cafolder> floderbyparent(Integer idx,List<Cafolder> ac ) {
		List<Cafolder> result = new java.util.ArrayList<Cafolder>();
		for (Cafolder cafolder : ac) 
		{
			if( cafolder.getParentid().equals(idx)){
				cafolder.setChildren(floderbyparent(cafolder.getIdx(), ac));
				result.add(cafolder);
			}
		}
		return  (List<Cafolder>) result;
	}
	
	
}
