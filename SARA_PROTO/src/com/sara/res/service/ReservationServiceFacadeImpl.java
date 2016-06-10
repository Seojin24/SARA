package com.sara.res.service;

import java.util.ArrayList;

import com.sara.base.to.FacilityBean;
import com.sara.member.to.MemberBean;
import com.sara.res.dao.ReservationDAO;
import com.sara.res.to.ReservationBean;

public class ReservationServiceFacadeImpl implements ReservationServiceFacade {
	
	public ReservationDAO resDAO;

	public void setResDAO(ReservationDAO resDAO) {
		this.resDAO = resDAO;
	}

	@Override
	public ArrayList<ReservationBean> findResList(ReservationBean resBean) {
		// TODO Auto-generated method stub
		ArrayList<ReservationBean> resBeanList=resDAO.selectResBeanList(resBean);
		
		
		return resBeanList;
	}

	@Override
	public void batchResList(ArrayList<ReservationBean> resList) {
		// TODO Auto-generated method stub

		String status = "";
		for (ReservationBean resBean : resList) {
			status = resBean.getStatus();
			if (status.equals("insert")) {
				//resDao.insertMember(memberBean);

			} else if (status.equals("update")) {
				//memberDao.updateMember(memberBean);
			} else if (status.equals("delete")) {
				//
			}
		}
		
		
	}

	@Override
	public ArrayList<ReservationBean> findResList(MemberBean memBean) {
		// TODO Auto-generated method stub
		
		ArrayList<ReservationBean> resBeanList=resDAO.selectResBeanList(memBean);
		return resBeanList;
	}

	@Override
	public ArrayList<ReservationBean> findResList(FacilityBean facBean) {
		// TODO Auto-generated method stub
		//System.out.println("findResList service facade Ω√¿€");
		ArrayList<ReservationBean> resBeanList=resDAO.selectResBeanList(facBean);
		return resBeanList;
	}

}
