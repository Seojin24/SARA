package com.sara.base.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.sara.base.to.CodeBean;


public class CodeDAOImpl extends SqlMapClientDaoSupport implements CodeDAO {
	
	protected final Log logger = LogFactory.getLog(getClass());

	public void insertCode(CodeBean codeBean) {
	
		getSqlMapClientTemplate().insert("Code.insertCode",codeBean);
	}

	
	public CodeBean selectCode(String code) {
	
		return (CodeBean)getSqlMapClientTemplate().queryForObject("Code.selectCode",code);
	}

	@SuppressWarnings("unchecked")
	public ArrayList<CodeBean> selectCodeList() {
	
		return (ArrayList<CodeBean>)getSqlMapClientTemplate().queryForList("Code.selectCodeList");
	}

	@SuppressWarnings("unchecked")
	public ArrayList<CodeBean> selectCodeBeanList(int sr, int er) {
	
		HashMap<String,Object> Obj=new HashMap<String,Object>();
		Obj.put("sr", sr);
		Obj.put("er", er); 
		return (ArrayList<CodeBean>)getSqlMapClientTemplate().queryForList("Code.selectCodeBeanList",Obj);
	}


	public int selectCodeCount() {
	
		return (int)getSqlMapClientTemplate().queryForObject("Code.selectCodeCount");
	}

	
	public void deleteCode(String code) {
	
		getSqlMapClientTemplate().delete("Code.deleteCode",code);
	}

	
	public void updateCode(CodeBean codeBean) {
		
		getSqlMapClientTemplate().update("Code.updateCode",codeBean);
	}
	
}
