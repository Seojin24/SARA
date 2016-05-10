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
	//	if (logger.isDebugEnabled())logger.debug("시작");
		ArrayList<MenuBean> menuList = baseServiceFacade.selectMenuList();

		// JSONObject 한글인코딩 처리
		response.setContentType("text/json; charset=UTF-8");
		try {

			modelObject.put("menuList", menuList);
			modelObject.put("errorCode", 0); // 에러처리 0은 성공
			modelObject.put("errorMsg", "success");

			if (logger.isDebugEnabled())
				logger.debug("종료");
			
		} catch (Exception e) {
			modelObject.clear();
			modelObject.put("errorCode", -1); // 에러메시지 코드 -1
			modelObject.put("errorMsg", "메뉴리스트 출력 실패!");
			
		}
		modelAndView.clear();
		modelAndView.addAllObjects(modelObject);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
}
