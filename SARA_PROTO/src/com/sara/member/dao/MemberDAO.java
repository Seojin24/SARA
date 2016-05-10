package com.sara.member.dao;
import java.util.ArrayList;

import com.sara.member.to.MemberBean;

public interface MemberDAO {
	ArrayList<MemberBean> selectMemberBeanList(int sr,int er);//
	int selectMemberCount();
	
	String getLastMemberno(); //��� ����? --Memberno �ڵ� ���� 
	void insertMember(MemberBean MemberBean); //�����Ͻ� 
	
	void deleteMember(int MemberNo);//�����ȸ->������� 
	void modifyMember(MemberBean MemberBean); // ����������� 
	
	public MemberBean selectMember(String mbId);
	boolean checkAdmin(String Memberno);
}
