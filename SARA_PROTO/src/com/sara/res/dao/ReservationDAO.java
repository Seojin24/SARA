package com.sara.res.dao;

import java.util.ArrayList;

import com.sara.base.to.FacilityBean;
import com.sara.member.to.MemberBean;
import com.sara.res.to.ReservationBean;

public interface ReservationDAO {
	ArrayList<ReservationBean> selectResBeanList(ReservationBean resBean);
	// ��� ���� ��Ȳ ��ȸ 
	ArrayList<ReservationBean> selectResBeanList(MemberBean mbBean);
	//member �� ���� ���� Ȯ�ν� ��� 
	ArrayList<ReservationBean> selectResBeanList(FacilityBean fcBean);
	//�ü��� �ش��ϴ� ���� ���� ��ȸ�� ��� 
	
	int selectResCount();
	
	String getLastResNo(); //��� ����? --Memberno �ڵ� ���� 
	void insertRes(ReservationBean resBean); //�����Ͻ� 
	void deleteRes(int rsNo);//������ȸ->������� 
	void updateRes(ReservationBean resBean); // ������������ 
	
	public ReservationBean selectRes(String rsNo);
	boolean checkApproved(String rsNo);

}
