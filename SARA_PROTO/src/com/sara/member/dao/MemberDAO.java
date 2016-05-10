package com.sara.member.dao;
import java.util.ArrayList;

import com.sara.member.to.MemberBean;

public interface MemberDAO {
	ArrayList<MemberBean> selectMemberBeanList(int sr,int er);//
	int selectMemberCount();
	
	String getLastMemberno(); //어디서 쓰지? --Memberno 자동 생성 
	void insertMember(MemberBean MemberBean); //사원등록시 
	
	void deleteMember(int MemberNo);//사원조회->사원삭제 
	void modifyMember(MemberBean MemberBean); // 사원정보수정 
	
	public MemberBean selectMember(String mbId);
	boolean checkAdmin(String Memberno);
}
