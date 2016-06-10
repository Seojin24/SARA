package com.sara.res.service;

import java.util.ArrayList;

import com.sara.base.to.FacilityBean;
import com.sara.member.to.MemberBean;
import com.sara.res.to.ReservationBean;


public interface ReservationServiceFacade {

	ArrayList<ReservationBean> findResList(ReservationBean resBean);
	ArrayList<ReservationBean> findResList(MemberBean memBean);
	ArrayList<ReservationBean> findResList(FacilityBean facBean);
	
	
	void batchResList(ArrayList<ReservationBean> resList); // ÀÏ°ýÃ³¸®
	

}
