package com.sara.base.dao;


import java.util.ArrayList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.sara.base.to.MenuBean;

public class MenuDAOImpl extends SqlMapClientDaoSupport implements MenuDAO {
	protected final Log logger = LogFactory.getLog(getClass());

	// 메뉴리스트 가져오기
	@Override
	@SuppressWarnings("unchecked") 
	public ArrayList<MenuBean> selectMenuList() {

		return (ArrayList<MenuBean>)getSqlMapClientTemplate().queryForList("Menu.selectMenuList");
		
	}
}
