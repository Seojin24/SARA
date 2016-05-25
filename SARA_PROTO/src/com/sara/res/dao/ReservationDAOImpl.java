package com.sara.reservation.dao;

import java.util.ArrayList;

import com.sara.base.to.FacilityBean;
import com.sara.member.to.MemberBean;
import com.sara.reservation.to.ReservationBean;

public class ReservationDAOImpl implements ReservationDAO {

	@Override
	public ArrayList<ReservationBean> selectResBeanList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<ReservationBean> selectResBeanList(MemberBean mbBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<ReservationBean> selectResBeanList(FacilityBean fcBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int selectResCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public String getLastResNo() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insertRes(ReservationBean resBean) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteRes(int rsNo) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void updateRes(ReservationBean resBean) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ReservationBean selectRes(String rsNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public boolean checkApproved(String rsNo) {
		// TODO Auto-generated method stub
		return false;
	}

}
