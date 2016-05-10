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
	
	String getLastResNo(); //��� ����? --Memberno �ڵ� ���� 
	void insertRes(ReservationBean resBean); //�����Ͻ� 
	void deleteRes(int rsNo);//������ȸ->������� 
	void updateRes(ReservationBean resBean); // ������������ 
	
	public ReservationBean selectRes(String rsNo);
	boolean checkApproved(String rsNo);

}
