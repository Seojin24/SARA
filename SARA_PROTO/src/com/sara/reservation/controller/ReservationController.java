package com.sara.reservation.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.sara.member.to.MemberBean;
import com.sara.reservation.service.ReservationServiceFacade;
import com.sara.reservation.to.ReservationBean;

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
	
	public ModelAndView getResList(HttpServletRequest request,
			HttpServletResponse response){
		ArrayList<ReservationBean> resList=new ArrayList<ReservationBean>();
		try{
			
			//int facilityNo=Integer.parseInt(request.getParameter("fcNo")); 
			//type string 
			String facilityNo=request.getParameter("fcNo");//장소 정보 
			//resList=resServiceFacade.searchResList();
			
			
			
			modelObject.clear();
//			modelObject.put("page",pagenum);
//			modelObject.put("total",pagecount);
//			modelObject.put("list",memberlist);
			modelObject.put("errorCode", 0); 		
			modelObject.put("errorMsg", "success");
			modelObject.put("MemberBean",new MemberBean());
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
	
	public ModelAndView batchResList(HttpServletRequest request,
			HttpServletResponse response){
		ArrayList<ReservationBean> resList=new ArrayList<ReservationBean>();
		try{
			
			//int facilityNo=Integer.parseInt(request.getParameter("fcNo")); 
			//type string 
			String facilityNo=request.getParameter("fcNo");//장소 정보 
			//resList=resServiceFacade.searchResList();
			
			
			
			modelObject.clear();
//			modelObject.put("page",pagenum);
//			modelObject.put("total",pagecount);
//			modelObject.put("list",memberlist);
			modelObject.put("errorCode", 0); 		
			modelObject.put("errorMsg", "success");
			modelObject.put("MemberBean",new MemberBean());
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
