package com.sara.base.dao;

import java.util.ArrayList;

import com.sara.base.to.CodeDetailBean;

public interface CodeDetailDAO {
	ArrayList<CodeDetailBean> selectCodeDetailList(String codeno);
	void insertCodeDetail(CodeDetailBean CodeDetailBean);
	void updateCodeDetail(CodeDetailBean CodeDetailBean);
	int selectCodeDetailCount(String codeno);
	void deleteCodeDetailList(String codeno);
	void deleteCodeDetail(CodeDetailBean CodeDetailBean);
	String selectCodeName(String cate, String gradeno2);
}
