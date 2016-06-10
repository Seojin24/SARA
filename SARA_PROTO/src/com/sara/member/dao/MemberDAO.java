package com.sara.member.dao;
import java.util.ArrayList;

import com.sara.member.to.MemberBean;

public interface MemberDAO {
	ArrayList<MemberBean> selectMemberBeanList(int sr,int er);//
	int selectMemberCount();
	
	int selectLastMemberno(); //��� ����? --Memberno �ڵ� ���� 
	void insertMember(MemberBean MemberBean); //�����Ͻ� 
	
	void deleteMember(int MemberNo);//�����ȸ->������� 
	void updateMember(MemberBean MemberBean); // ����������� 
	
	public MemberBean selectMember(String mbId);
	boolean checkAdmin(String Memberno);
}
