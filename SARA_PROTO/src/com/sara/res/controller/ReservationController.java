package com.sara.res.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.sara.base.to.FacilityBean;
import com.sara.res.service.ReservationServiceFacade;
import com.sara.res.to.ReservationBean;

public class ReservationController extends MultiActionController{
	HashMap<String,Object> modelObject=new HashMap<String,Object>();
	ModelAndView modelAndView;
	public void setModelAndView(ModelAndView modelAndView) {
		this.modelAndView = modelAndView;
	}
	protected final Log logger = LogFactory.getLog(getClass());
	
	MessageSource messageSource;
	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}
	
	ReservationServiceFacade resServiceFacade;
	public void setResServiceFacade(ReservationServiceFacade resServiceFacade) {
		this.resServiceFacade = resServiceFacade;
	}
	
	//������ȸ 
	public ModelAndView findResList(HttpServletRequest request,
			HttpServletResponse response){
		ArrayList<ReservationBean> resList=new ArrayList<ReservationBean>();
		try{
			System.out.println("findResList");
			//int facilityNo=Integer.parseInt(request.getParameter("fcNo")); 
			//type string 
			String facilityNo=request.getParameter("fcNo");//��� ���� 
			//resList=resServiceFacade.searchResList();
			
			FacilityBean fcBean=new FacilityBean();
			fcBean.setFcNo(facilityNo);
			
			resList=resServiceFacade.findResList(fcBean);
			System.out.println(facilityNo+"findRestList �׽�Ʈ");
			
			modelObject.clear();
//			modelObject.put("page",pagenum);
//			modelObject.put("total",pagecount);
			modelObject.put("list",resList);
			modelObject.put("errorCode", 0); 		
			modelObject.put("errorMsg", "success");
			modelObject.put("ReservationBean",new ReservationBean());
		}catch(Exception e){
			modelObject.clear();
			modelObject.put("errorCode", -1);
			modelObject.put("errorMsg", "error");
		}
		
		modelAndView.clear();
		modelAndView.addAllObjects(modelObject);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	//���� �ϰ� ó�� 
	public ModelAndView batchResProcess(HttpServletRequest request,
			HttpServletResponse response){
		ArrayList<ReservationBean> resList=new ArrayList<ReservationBean>();
		try{
			
			//int facilityNo=Integer.parseInt(request.getParameter("fcNo")); 
			//type string 
			//String facilityNo=request.getParameter("fcNo");//��� ���� 
			//resList=resServiceFacade.searchResList();
			
			
			
			modelObject.clear();
//			modelObject.put("page",pagenum);
//			modelObject.put("total",pagecount);
//			modelObject.put("list",memberlist);
			modelObject.put("errorCode", 0); 		
			modelObject.put("errorMsg", "success");
			modelObject.put("MemberBean",new ReservationBean());
		}catch(Exception e){
			modelObject.clear();
			modelObject.put("errorCode", -1);
			modelObject.put("errorMsg", "error");
			
			
		}
		
		modelAndView.clear();
		modelAndView.addAllObjects(modelObject);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
}
