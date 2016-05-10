package com.sara.base.dao;

import java.util.ArrayList;

import com.sara.base.to.CodeBean;


public interface CodeDAO {
	void insertCode(CodeBean codeBean);
	CodeBean selectCode(String code);
	 ArrayList<CodeBean> selectCodeList();
	 ArrayList<CodeBean> selectCodeBeanList(int sr, int er);
	 int selectCodeCount();
	 void deleteCode(String code);
	 void updateCode(CodeBean codeBean);
}
