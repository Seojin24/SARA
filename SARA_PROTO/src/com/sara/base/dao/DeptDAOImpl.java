package com.sara.base.dao;

//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import java.sql.ResultSet;
//import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.sara.base.to.DeptBean;
import com.sara.common.exception.DataAccessException;

public class DeptDAOImpl extends SqlMapClientDaoSupport implements DeptDAO{

	
	protected final Log logger = LogFactory.getLog(getClass());


	@Override
	public String selectDeptName(String deptNo) throws DataAccessException{


		//���⼭ throw dataAccessException �� ������?
		return (String)getSqlMapClientTemplate().queryForObject("Dept.getDeptName", deptNo);
	}

	@Override
	@SuppressWarnings("unchecked") //�̺κ��� list-ArrayList���� ��ȯ üũ���ϰ� ��->���ʿ�???
	public ArrayList<DeptBean> selectDeptList(int sr, int er) throws DataAccessException{

		HashMap<String,Object> Obj=new HashMap<String,Object>();
		Obj.put("sr", sr);
		Obj.put("er", er);
		return (ArrayList<DeptBean>)getSqlMapClientTemplate().queryForList("Dept.selectDeptList", Obj);
	}

	@Override
	public int selectDeptCount() throws DataAccessException{
	
		return (int)getSqlMapClientTemplate().queryForObject("Dept.selectDeptCount");
	}


}
