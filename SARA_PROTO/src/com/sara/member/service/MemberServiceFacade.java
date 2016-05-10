package com.sara.member.service;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import com.sara.common.to.ListForm;
import com.sara.member.exception.MemberNonExistentException;
import com.sara.member.exception.MemberPwMismatchException;
import com.sara.member.to.MemberBean;

public interface MemberServiceFacade {
	
	ArrayList<MemberBean> searchMemberList(ListForm listForm);
	int getRowCount();
	
	String getLastMemberno();//��� ���???? ->ȸ���� �߰��� �� ��� 
	void batchMemberList(ArrayList<MemberBean> memberList); // ��� ���??�Ѳ����� emp�� ó���� �� 
	
	boolean login(String mbId,String mbPw,HttpServletRequest req) throws MemberNonExistentException, MemberPwMismatchException;
	//���� ���ܴ� throw�ؼ� -> controller->view���� ��Ÿ���� �ؾ� �Ѵ�. 
	void logout(HttpServletRequest req);
	

}