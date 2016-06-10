package com.sara.base.dao;

import java.util.ArrayList;

import com.sara.base.to.DeptBean;



public interface DeptDAO {
	public String selectDeptName(String deptNo);
	public ArrayList<DeptBean> selectDeptList(int sr, int er);
	public int selectDeptCount();

}
