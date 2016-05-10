package com.sara.base.dao;

import java.util.ArrayList;

import com.sara.base.to.MenuBean;

public interface MenuDAO {
	ArrayList<MenuBean> selectMenuList();
}
