package com.sara.member.dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.sara.member.to.MemberBean;

public class MemberDAOImpl extends SqlMapClientDaoSupport implements MemberDAO {

	
	protected final Log logger = LogFactory.getLog(getClass());

	@Override @SuppressWarnings("unchecked") 
	public ArrayList<MemberBean> selectMemberBeanList(int sr, int er) {
		HashMap<String,Object> Obj=new HashMap<String,Object>();
		Obj.put("sr", sr);
		Obj.put("er", er);
		return (ArrayList<MemberBean>)getSqlMapClientTemplate().queryForList("Member.selectMemberBeanList",Obj);
		
	}

	@Override
	public int selectMemberCount() {
	
		int count=(int)getSqlMapClientTemplate().queryForObject("Member.selectMemberCount");
		return count;
	}
	@Override
	public void insertMember(MemberBean MemberBean) {
	
		getSqlMapClientTemplate().insert("Member.insertMember", MemberBean);
	}
	@Override
	public void modifyMember(MemberBean MemberBean) {
	
		getSqlMapClientTemplate().queryForObject("Member.modifyMember",MemberBean);
	}
	@Override
	public String getLastMemberno() { 
		
		String lastEmpno = "0000000";
		int seq = 0;
		Calendar calendar = Calendar.getInstance();
		String yy = String.format("%04d", calendar.get(Calendar.YEAR)); // 2014
		String mm = String.format("%02d", calendar.get(Calendar.MONTH) + 1);
		String yymm = yy.substring(2) + mm; // 1409
		
		lastEmpno=(String)getSqlMapClientTemplate().queryForObject("Emp.getLastEmpno",yymm);
		
		seq = Integer.parseInt(lastEmpno.substring(4, 7)) + 1;
		lastEmpno = yymm + String.format("%03d", seq);
		
		return lastEmpno;
	}
	@Override
	public void deleteMember(int memberNo) {
		
		getSqlMapClientTemplate().delete("Member.deleteMember", memberNo);
	}

	
	@Override
	public MemberBean selectMember(String mbId) {
		MemberBean member=(MemberBean)getSqlMapClientTemplate().queryForObject("Member.selectMember",mbId);
		//MemberBean member=new MemberBean();
		//member.setMemberNo(no);
		//member.setEmpRegno(empRegno);
		
//		System.out.println("empNo:"+emp.getEmpNo());
//		System.out.println("empRegno:"+emp.getEmpRegno());
		//getSqlMapClientTemplate().queryForObject("Member.", parameterObject)
		
		return member;
	}

	@Override
	public boolean checkAdmin(String mbId) {
		
		String admin=(String)getSqlMapClientTemplate().queryForObject("Member.checkAdmin",mbId);
		if(admin!=null){
			return true;
		}else{
			return false;
		}
	}


	
}
