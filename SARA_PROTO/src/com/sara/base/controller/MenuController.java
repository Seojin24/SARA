package com.sara.base.controller;

//import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.sara.base.service.BaseServiceFacade;
import com.sara.base.to.MenuBean;

public class MenuController extends MultiActionController {
	protected final Log logger = LogFactory.getLog(getClass());
	BaseServiceFacade baseServiceFacade;
	ModelAndView modelAndView;
	MessageSource messageSource;
	HashMap<String, Object> modelObject = new HashMap<String, Object>();

	public void setBaseServiceFacade(BaseServiceFacade baseServiceFacade) {
		this.baseServiceFacade = baseServiceFacade;
	}

	public void setModelAndView(ModelAndView modelAndView) {
		this.modelAndView = modelAndView;
	}
	
	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}

	public ModelAndView getMenuList(HttpServletRequest request,
			HttpServletResponse response) {
	//	if (logger.isDebugEnabled())logger.debug("����");
		ArrayList<MenuBean> menuList = baseServiceFacade.selectMenuList();

		// JSONObject �ѱ����ڵ� ó��
		response.setContentType("text/json; charset=UTF-8");
		try {

			modelObject.put("menuList", menuList);
			modelObject.put("errorCode", 0); // ����ó�� 0�� ����
			modelObject.put("errorMsg", "success");

			if (logger.isDebugEnabled())
				logger.debug("����");
			
		} catch (Exception e) {
			modelObject.clear();
			modelObject.put("errorCode", -1); // �����޽��� �ڵ� -1
			modelObject.put("errorMsg", "�޴�����Ʈ ��� ����!");
			
		}
		modelAndView.clear();
		modelAndView.addAllObjects(modelObject);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
}
