package com.sara.base.controller;
//import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

//import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.sara.base.service.BaseServiceFacade;
import com.sara.base.to.DeptBean;
import com.sara.common.to.ListForm;

/**
 * DeptController
 *
 * @Description 공통학부관리 컨트롤러
 * @Author      김다솜
 * Created on 2016. 05. 23.
 */

public class DeptController extends MultiActionController {
	//BaseServiceFacade baseServiceFacade=BaseServiceFacadeImpl.getInstance();
	BaseServiceFacade baseServiceFacade;
	MessageSource messageSource; 
	HashMap<String,Object> modelObject=new HashMap<String,Object>();
	ModelAndView modelAndView;
	
	public void setBaseServiceFacade(BaseServiceFacade baseServiceFacade) {
		this.baseServiceFacade = baseServiceFacade;
	}

	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}

	public void setModelAndView(ModelAndView modelAndView) {
		this.modelAndView = modelAndView;
	}
	
	protected final Log logger = LogFactory.getLog(getClass());

	
	
	public ModelAndView findDeptList(HttpServletRequest request,
			HttpServletResponse response) {
		//if (logger.isDebugEnabled()) {logger.debug("DeptController-getDeptList-Start");}
		response.setContentType("text/json; charset=UTF-8");
		try{
			int pagenum=Integer.parseInt(request.getParameter("page"));
			int rowsize=Integer.parseInt(request.getParameter("rows"));
		    if(pagenum==0){pagenum=5;}
		    if(rowsize==0){rowsize=5;}
	
			ListForm listForm=new ListForm();
			listForm.setRowsize(rowsize);
			listForm.setPagenum(pagenum);
		//	ArrayList<DeptBean> deptlist = baseServiceFacade.findDeptList(listForm);
			
			int pagecount=listForm.getPagecount();
			modelObject.clear();
			modelObject.put("page",pagenum);
			modelObject.put("total",pagecount);
			//modelObject.put("list",deptlist);
			modelObject.put("deptBean",new DeptBean());  	//빈객체를 생성해서 날려줌..
			modelObject.put("errorCode", 0); 		//에러처리시 사용 0은 성공
			modelObject.put("errorMsg", "success");
			//if (logger.isDebugEnabled()) {logger.debug("끝");}
		}catch(Exception e){
			e.printStackTrace();
			modelObject.clear(); 
			modelObject.put("errorCode",-1);
			modelObject.put("errorMsg","부서리스트 조회 오류입니다.");
		}
	
		modelAndView.clear();
		modelAndView.addAllObjects(modelObject);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	

}
