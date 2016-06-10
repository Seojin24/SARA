package com.sara.base.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.sara.base.to.CodeDetailBean;

public class CodeDetailDAOImpl extends SqlMapClientDaoSupport implements CodeDetailDAO {

	protected final Log logger = LogFactory.getLog(getClass());

	@Override
	public void insertCodeDetail(CodeDetailBean CodeDetailBean) {
		
		getSqlMapClientTemplate().insert("CodeDetail.insertCodeDetail", CodeDetailBean);
	}

	@Override
	public int selectCodeDetailCount(String codeno) {
		
		return (int) getSqlMapClientTemplate().queryForObject("CodeDetail.selectCodeDetailCount", codeno);
	}

	@Override
	public void deleteCodeDetail(CodeDetailBean CodeDetailBean) {
		
		HashMap<String, Object> Obj = new HashMap<String, Object>();
//		Obj.put("Code", CodeDetailBean.getCode());
//		Obj.put("detailCode", CodeDetailBean.getDetailCode());

		getSqlMapClientTemplate().delete("CodeDetail.deleteCodeDetail", Obj);
	}

	@Override
	public void updateCodeDetail(CodeDetailBean CodeDetailBean) {
		
		getSqlMapClientTemplate().update("CodeDetail.updateCodeDetail", CodeDetailBean);
	}

	@Override
	public void deleteCodeDetailList(String codeno) {
		
		getSqlMapClientTemplate().delete("CodeDetail.deleteCodeDetailList", codeno);
	}

	
	@Override
	@SuppressWarnings("unchecked")
	public ArrayList<CodeDetailBean> selectCodeDetailList(String codeno) {
		
		return (ArrayList<CodeDetailBean>)getSqlMapClientTemplate().queryForList("CodeDetail.selectCodeDetailList",codeno);
	}

	@Override
	public String selectCodeName(String cate, String gradeno) {
		HashMap<String,Object> Obj=new HashMap<String,Object>();
		Obj.put("categoryCode", cate);
		Obj.put("detailCode", gradeno);
		return (String)getSqlMapClientTemplate().queryForObject("CodeDetail.getCodeName",Obj);
	}

}
