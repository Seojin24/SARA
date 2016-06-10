package com.sara.res.dao;

import java.util.ArrayList;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.sara.base.to.FacilityBean;
import com.sara.member.to.MemberBean;
import com.sara.res.to.ReservationBean;

public class ReservationDAOImpl extends SqlMapClientDaoSupport implements ReservationDAO {

	@Override @SuppressWarnings("unchecked") 
	public ArrayList<ReservationBean> selectResBeanList(ReservationBean resBean) {
		// TODO Auto-generated method stub

		return (ArrayList<ReservationBean>)getSqlMapClientTemplate().queryForList("Reservation.selectRes",resBean);
	}

	@Override @SuppressWarnings("unchecked") 
	public ArrayList<ReservationBean> selectResBeanList(MemberBean mbBean) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override @SuppressWarnings("unchecked") 
	public ArrayList<ReservationBean> selectResBeanList(FacilityBean fcBean) {
		// TODO Auto-generated method stub
		System.out.println("ResDAOΩ√¿€");
		return (ArrayList<ReservationBean>)getSqlMapClientTemplate().queryForList("Reservation.selectRes",fcBean.getFcNo());
	}

	@Override @SuppressWarnings("unchecked") 
	public int selectResCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override @SuppressWarnings("unchecked") 
	public String getLastResNo() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override @SuppressWarnings("unchecked") 
	public void insertRes(ReservationBean resBean) {
		// TODO Auto-generated method stub
		
	}

	@Override @SuppressWarnings("unchecked") 
	public void deleteRes(int rsNo) {
		// TODO Auto-generated method stub
		
	}

	@Override @SuppressWarnings("unchecked") 
	public void updateRes(ReservationBean resBean) {
		// TODO Auto-generated method stub
		
	}

	@Override @SuppressWarnings("unchecked") 
	public ReservationBean selectRes(String rsNo) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override @SuppressWarnings("unchecked") 
	public boolean checkApproved(String rsNo) {
		// TODO Auto-generated method stub
		return false;
	}

}
