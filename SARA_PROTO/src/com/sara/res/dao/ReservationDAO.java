package com.sara.res.dao;

import java.util.ArrayList;

import com.sara.base.to.FacilityBean;
import com.sara.member.to.MemberBean;
import com.sara.res.to.ReservationBean;

public interface ReservationDAO {
	ArrayList<ReservationBean> selectResBeanList(ReservationBean resBean);
	// 모든 예약 현황 조회 
	ArrayList<ReservationBean> selectResBeanList(MemberBean mbBean);
	//member 의 예약 내역 확인시 사용 
	ArrayList<ReservationBean> selectResBeanList(FacilityBean fcBean);
	//시설에 해당하는 예약 내역 조회시 사용 
	
	int selectResCount();
	
	String getLastResNo(); //어디서 쓰지? --Memberno 자동 생성 
	void insertRes(ReservationBean resBean); //예약등록시 
	void deleteRes(int rsNo);//예약조회->예약삭제 
	void updateRes(ReservationBean resBean); // 예약정보수정 
	
	public ReservationBean selectRes(String rsNo);
	boolean checkApproved(String rsNo);

}
