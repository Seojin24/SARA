package com.sara.reservation.to;

import java.sql.Date;


public class ReservationBean {
	private String rsNo,
	rsPeopleNum,rsOTP,
	rsIsApproved,rsIsUse,fcNo,fcType,
	rs1,rs2,rs3,rs4,rs5,rsMb1,rsMb2;
	private int mbNo;
	private Date rsStartTime,rsEndTime;
	private int rsTimeInterval; // 타입, ㅜ 뭔지 모르겠
	public String getRsNo() {
		return rsNo;
	}
	public void setRsNo(String rsNo) {
		this.rsNo = rsNo;
	}
	public String getRsPeopleNum() {
		return rsPeopleNum;
	}
	public void setRsPeopleNum(String rsPeopleNum) {
		this.rsPeopleNum = rsPeopleNum;
	}
	public String getRsOTP() {
		return rsOTP;
	}
	public void setRsOTP(String rsOTP) {
		this.rsOTP = rsOTP;
	}
	public String getRsIsApproved() {
		return rsIsApproved;
	}
	public void setRsIsApproved(String rsIsApproved) {
		this.rsIsApproved = rsIsApproved;
	}
	public String getRsIsUse() {
		return rsIsUse;
	}
	public void setRsIsUse(String rsIsUse) {
		this.rsIsUse = rsIsUse;
	}
	public String getFcNo() {
		return fcNo;
	}
	public void setFcNo(String fcNo) {
		this.fcNo = fcNo;
	}
	public String getFcType() {
		return fcType;
	}
	public void setFcType(String fcType) {
		this.fcType = fcType;
	}
	public String getRs1() {
		return rs1;
	}
	public void setRs1(String rs1) {
		this.rs1 = rs1;
	}
	public String getRs2() {
		return rs2;
	}
	public void setRs2(String rs2) {
		this.rs2 = rs2;
	}
	public String getRs3() {
		return rs3;
	}
	public void setRs3(String rs3) {
		this.rs3 = rs3;
	}
	public String getRs4() {
		return rs4;
	}
	public void setRs4(String rs4) {
		this.rs4 = rs4;
	}
	public String getRs5() {
		return rs5;
	}
	public void setRs5(String rs5) {
		this.rs5 = rs5;
	}
	public String getRsMb1() {
		return rsMb1;
	}
	public void setRsMb1(String rsMb1) {
		this.rsMb1 = rsMb1;
	}
	public String getRsMb2() {
		return rsMb2;
	}
	public void setRsMb2(String rsMb2) {
		this.rsMb2 = rsMb2;
	}
	public int getMbNo() {
		return mbNo;
	}
	public void setMbNo(int mbNo) {
		this.mbNo = mbNo;
	}
	public Date getRsStartTime() {
		return rsStartTime;
	}
	public void setRsStartTime(Date rsStartTime) {
		this.rsStartTime = rsStartTime;
	}
	public Date getRsEndTime() {
		return rsEndTime;
	}
	public void setRsEndTime(Date rsEndTime) {
		this.rsEndTime = rsEndTime;
	}
	public int getRsTimeInterval() {
		return rsTimeInterval;
	}
	public void setRsTimeInterval(int rsTimeInterval) {
		this.rsTimeInterval = rsTimeInterval;
	}
	
	
	

}
