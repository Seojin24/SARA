package com.sara.base.service;

import java.util.ArrayList;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;

import com.sara.base.dao.CodeDAO;
import com.sara.base.dao.CodeDetailDAO;
import com.sara.base.dao.DeptDAO;
import com.sara.base.dao.MenuDAO;
import com.sara.base.to.MenuBean;

public class BaseServiceFacadeImpl implements BaseServiceFacade {
	
	public CodeDAO codeDao;
	public CodeDAO getCodeDao() {
		return codeDao;
	}


	public void setCodeDao(CodeDAO codeDao) {
		this.codeDao = codeDao;
	}


	public CodeDetailDAO getCodeDetailDao() {
		return codeDetailDao;
	}


	public void setCodeDetailDao(CodeDetailDAO codeDetailDao) {
		this.codeDetailDao = codeDetailDao;
	}


	public DeptDAO getDeptDao() {
		return deptDao;
	}


	public void setDeptDao(DeptDAO deptDao) {
		this.deptDao = deptDao;
	}


	public MenuDAO getMenuDao() {
		return menuDao;
	}


	public void setMenuDao(MenuDAO menuDao) {
		this.menuDao = menuDao;
	}


	public MessageSource getMessageSource() {
		return messageSource;
	}


	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}


	public Log getLogger() {
		return logger;
	}


	public CodeDetailDAO codeDetailDao;
	public DeptDAO deptDao;
	public MenuDAO menuDao;
	MessageSource messageSource;

	protected final Log logger = LogFactory.getLog(getClass());
	
	
	@Override
	public ArrayList<MenuBean> findMenuList() {
		ArrayList<MenuBean> menuList = menuDao.selectMenuList();

		return menuList;
	}

//	@Override
//	public ArrayList<CategoryCodeBean> searchCategoryCodeList(ListForm listForm) {
//		int dbcount = categorycodedao.selectCodeCount();
//		listForm.setDbcount(dbcount);
//		int sr = listForm.getStartrow();
//		int er = listForm.getEndrow();
//
//		ArrayList<CategoryCodeBean> codeBeanList;
//		String CategoryCode;
//		codeBeanList = categorycodedao.selectCodeBeanList(sr, er);
//
//		for (CategoryCodeBean codeBean : codeBeanList) {
//			CategoryCode = codeBean.getCategoryCode();
//			codeBean.setCodeInfoBeanList(codeinfodao.selectCodeInfoList(CategoryCode));
//		}
//		return codeBeanList;
//	}
//
//	@Override
//	public ArrayList<CodeInfoBean> searchCodeInfo(ListForm listForm, String code) {
//		int dbcount = codeinfodao.selectCodeInfoCount(code);
//		listForm.setDbcount(dbcount);
//
//		ArrayList<CodeInfoBean> codeInfoList = codeinfodao.selectCodeInfoList(code);
//		return codeInfoList;
//	}
//
//
//	@Override
//	public void batchCode(CategoryCodeBean codeBean) {
//		String status = "";
//		ArrayList<CodeInfoBean> codeInfoList = codeBean.getCodeInfoBeanList();
//		for (CodeInfoBean detailBean : codeInfoList) {
//			status = detailBean.getStatus();
//			if (status.equals("insert"))
//				codeinfodao.insertCodeInfo(detailBean);
//			else if (status.equals("update"))
//				codeinfodao.updateCodeInfo(detailBean);
//			else if (status.equals("delete"))
//				codeinfodao.deleteCodeInfo(detailBean);
//		}
//
//	}
//
//	@Override
//	public ArrayList<DeptBean> findDeptList(ListForm listForm) {
//		int dbcount = deptdao.selectDeptCount();
//		listForm.setDbcount(dbcount);
//		int sr = listForm.getStartrow();
//		int er = listForm.getEndrow();
//
//		ArrayList<DeptBean> deptList = deptdao.selectDeptList(sr, er);
//		
//		return deptList;
//	}
//
//	@Override
//	public void batchDept(ArrayList<DeptBean> deptList) {
//		String status;
//		CodeInfoBean codeInfoBean = new CodeInfoBean();
//		for (DeptBean deptBean : deptList) {
//			codeInfoBean.setCategoryCode("DEPT");
//			codeInfoBean.setDetailCode(deptBean.getDeptCode());
//			codeInfoBean.setDetailName(deptBean.getDeptName());
//			codeInfoBean.setUseWhether(deptBean.getUseWhether());
//			status = deptBean.getStatus();
//			if (status.equals("insert")) {
//				deptdao.insertDept(deptBean);
//				codeinfodao.insertCodeInfo(codeInfoBean);
//			} else if (status.equals("update")) {
//				deptdao.updateDept(deptBean);
//				codeinfodao.updateCodeInfo(codeInfoBean);
//			} else if (status.equals("delete")) {
//				deptdao.deleteDept(deptBean);
//				codeinfodao.deleteCodeInfo(codeInfoBean);
//			}
//		}
//	}

}
