package com.sara.reservation.dao;

import java.util.ArrayList;

import com.sara.base.to.FacilityBean;
import com.sara.member.to.MemberBean;
import com.sara.reservation.to.ReservationBean;

public interface ReservationDAO {
	ArrayList<ReservationBean> selectResBeanList();//
	ArrayList<ReservationBean> selectResBeanList(MemberBean mbBean);//
	ArrayList<ReservationBean> selectResBeanList(FacilityBean fcBean);//
	
	int selectResCount();
	
	String getLastResNo(); //어디서 쓰지? --Memberno 자동 생성 
	void insertRes(ReservationBean resBean); //예약등록시 
	void deleteRes(int rsNo);//예약조회->예약삭제 
	void updateRes(ReservationBean resBean); // 예약정보수정 
	
	public ReservationBean selectRes(String rsNo);
	boolean checkApproved(String rsNo);

}
