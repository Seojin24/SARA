package com.sara.member.service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;

import com.sara.base.dao.CodeDAO;
import com.sara.base.dao.DeptDAO;
import com.sara.common.to.ListForm;
import com.sara.member.dao.MemberDAO;
import com.sara.member.exception.MemberNonExistentException;
import com.sara.member.exception.MemberPwMismatchException;
import com.sara.member.to.MemberBean;

public class MemberServiceFacadeImpl implements MemberServiceFacade {

	public DeptDAO deptDao;
	public CodeDAO codeDao;
	MessageSource messageSource;
	
	protected final Log logger = LogFactory.getLog(getClass());
	public MemberDAO memberDao;
	public MemberDAO getMemberDao() {
		return memberDao;
	}

	public void setMemberDao(MemberDAO memberDao) {
		this.memberDao = memberDao;
	}

	public DeptDAO getDeptDao() {
		return deptDao;
	}

	public void setDeptDao(DeptDAO deptDao) {
		this.deptDao = deptDao;
	}

	public CodeDAO getCodeDao() {
		return codeDao;
	}

	public void setCodeDao(CodeDAO codeDao) {
		this.codeDao = codeDao;
	}

	public MessageSource getMessageSource() {
		return messageSource;
	}

	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}

	public Log getLogger() {
		return logger;
	}







	

	@Override
	public ArrayList<MemberBean> searchMemberList(ListForm listForm) {
		
			int dbcount = memberDao.selectMemberCount();
			listForm.setDbcount(dbcount);
			int sr = listForm.getStartrow();
			int er = listForm.getEndrow();
			//System.out.println(sr + "," + er + "==============");
			ArrayList<MemberBean> memberBeanList = memberDao.selectMemberBeanList(sr, er);
		
			return memberBeanList;
	}

	public int getRowCount() {
			int count = memberDao.selectMemberCount();
			return count;
	}

	public String getLastMemberno() {
			String empno = memberDao.getLastMemberno();

			return empno;
	}

	@Override
	public void batchMemberList(ArrayList<MemberBean> memberList) {
		// 일괄처리를 위한 메서드
		
		String status = "";
			for (MemberBean memberBean : memberList) {
				status = memberBean.getStatus();
				if (status.equals("insert")) {
					
					memberDao.insertMember(memberBean);

				} else if (status.equals("update")) {
					memberDao.modifyMember(memberBean);
				} else if (status.equals("delete")) {
					int memberNo = memberBean.getMbNo();
				
					memberDao.deleteMember(memberNo);
				}
			}
			
	}

	public boolean login(String mbId, String mbPw, HttpServletRequest req)
			throws MemberNonExistentException, MemberPwMismatchException {
	
			MemberBean member = memberDao.selectMember(mbId);
			if (member == null) {
				throw new MemberNonExistentException("존재하지 않는 회원입니다.");
			} else {
				
				if (member.getMbPw().equals(mbPw)) {
					if (memberDao.checkAdmin(mbId)) {
						//req.getSession().setAttribute("menu", "ADMIN");
						// 관리자 권한 부여
					}
				} else {
					throw new MemberPwMismatchException("비밀번호가 일치하지 않습니다.");
				}
			}
			return true;
	}


	


	@Override
	public void logout(HttpServletRequest req) {
		// TODO Auto-generated method stub
		req.getSession().invalidate();
		
	}

	
}
