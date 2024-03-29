package com.shopsthai.david.hibernate;

// Generated Nov 14, 2013 10:42:18 PM by Hibernate Tools 3.4.0.CR1

import java.math.BigDecimal;

/**
 * Tbfolder generated by hbm2java
 */
public class Tbfolder implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5607640359574519575L;
	private BigDecimal idx;
	private BigDecimal parentid;
	private String name;
	private String description;
	private String isOpen;
	private Integer sequence;
	private int memberCount;

	public Tbfolder() {
	}

	public Tbfolder(BigDecimal idx, int memberCount) {
		this.idx = idx;
		this.memberCount = memberCount;
	}

	public Tbfolder(BigDecimal idx, BigDecimal parentid, String name,
			String description, String isOpen, Integer sequence, int memberCount) {
		this.idx = idx;
		this.parentid = parentid;
		this.name = name;
		this.description = description;
		this.isOpen = isOpen;
		this.sequence = sequence;
		this.memberCount = memberCount;
	}

	public BigDecimal getIdx() {
		return this.idx;
	}

	public void setIdx(BigDecimal idx) {
		this.idx = idx;
	}

	public BigDecimal getParentid() {
		return this.parentid;
	}

	public void setParentid(BigDecimal parentid) {
		this.parentid = parentid;
	}

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getIsOpen() {
		return this.isOpen;
	}

	public void setIsOpen(String isOpen) {
		this.isOpen = isOpen;
	}

	public Integer getSequence() {
		return this.sequence;
	}

	public void setSequence(Integer sequence) {
		this.sequence = sequence;
	}

	public int getMemberCount() {
		return this.memberCount;
	}

	public void setMemberCount(int memberCount) {
		this.memberCount = memberCount;
	}

}
