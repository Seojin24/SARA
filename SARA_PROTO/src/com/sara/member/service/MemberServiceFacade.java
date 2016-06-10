package com.sara.member.service;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.sara.common.to.ListForm;
import com.sara.member.exception.MemberNonExistentException;
import com.sara.member.exception.MemberPwMismatchException;
import com.sara.member.to.MemberBean;

public interface MemberServiceFacade {
	
	ArrayList<MemberBean> findMemberList(ListForm listForm);
	int getRowCount();
	
	int getLastMemberno();//어디서 사용???? ->회원을 추가할 때 사용 
	void batchMemberList(ArrayList<MemberBean> memberList); // 어디서 사용??한꺼번에 emp를 처리할 때 
	
	MemberBean login(String mbId,String mbPw,HttpServletRequest req) throws MemberNonExistentException, MemberPwMismatchException;
	//업무 예외는 throw해서 -> controller->view까지 나타나게 해야 한다. 
	void logout(HttpServletRequest req);
	

}
