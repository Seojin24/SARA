package com.sara.member.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.context.MessageSource;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.multiaction.MultiActionController;

import com.sara.common.to.ListForm;
import com.sara.member.exception.MemberNonExistentException;
import com.sara.member.exception.MemberPwMismatchException;
import com.sara.member.service.MemberServiceFacade;
import com.sara.member.to.MemberBean;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class MemberController extends MultiActionController {
	
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
	
	MemberServiceFacade memberServiceFacade;
	public void setMemberServiceFacade(MemberServiceFacade memberServiceFacade) {
		this.memberServiceFacade = memberServiceFacade;
	}
	
	public ModelAndView findMemberList(HttpServletRequest request,
			HttpServletResponse response) {
		ArrayList<MemberBean> memberlist=new ArrayList<MemberBean>();
		response.setContentType("text/json; charset=UTF-8");
		try{
			int pagenum=Integer.parseInt(request.getParameter("page"));
			int rowsize=Integer.parseInt(request.getParameter("rows"));
			System.out.println(pagenum+","+rowsize+"====rowsize");
		    if(pagenum==0){pagenum=5;}
		    if(rowsize==0){rowsize=5;}
		   
			ListForm listForm=new ListForm();
			listForm.setRowsize(rowsize);
			listForm.setPagenum(pagenum);
			
			memberlist=memberServiceFacade.findMemberList(listForm);
			int pagecount=listForm.getPagecount();
//			System.out.println("list:"+memberlist);
//			System.out.println("dbcount:"+listForm.getDbcount());
//			System.out.println("pagecount:"+pagecount);
			
			modelObject.clear();
			modelObject.put("page",pagenum);
			modelObject.put("total",pagecount);
			modelObject.put("list",memberlist);
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
	
	


	
	public  ModelAndView batchMemberProcess(HttpServletRequest request,
			HttpServletResponse response) {
	//	if (logger.isDebugEnabled()) {logger.debug("memberController-batchmemberList-Start");}
		ArrayList<MemberBean> memberList=new ArrayList<MemberBean>();
		try{
			JSONObject jsonObject=JSONObject.fromObject(request.getParameter("list"));
			JSONArray jsonMemberBeanList=jsonObject.getJSONArray("MemberBeanList");
			
			for(int index=0; index<jsonMemberBeanList.size(); index++){
				MemberBean MemberBean=(MemberBean)JSONObject.toBean(jsonMemberBeanList.getJSONObject(index),MemberBean.class);
				//JSONArray 
				memberList.add(MemberBean);
			}
			memberServiceFacade.batchMemberList(memberList);
			
			modelObject.clear();
			modelObject.put("errorCode", 0);
			modelObject.put("errorMsg", "Success!");
			//System.out.println("memberController-batchmemberList-");
		}catch(Exception e){
			modelObject.clear();
			modelObject.put("errorCode", -1);
			modelObject.put("errorMsg", "error");
		}
		modelAndView.clear();
		modelAndView.addAllObjects(modelObject);
		modelAndView.setViewName("jsonView");
		//if (logger.isDebugEnabled()) {logger.debug("memberController-batchmemberList-End");}
		return modelAndView;
	}

	public ModelAndView setMemberno(HttpServletRequest request,
			HttpServletResponse response) {
		//if (logger.isDebugEnabled()) {logger.debug("memberController-setmemberno-Start");}
		try{
			int memberno = memberServiceFacade.getLastMemberno();
		
			modelObject.clear();
			modelObject.put("lastmemberno", memberno);
			modelObject.put("membertyMemberBean",new MemberBean());  	
			modelObject.put("errorCode", 0);
			modelObject.put("errorMsg", "Success!");
		}catch(Exception e){
			modelObject.clear();
			modelObject.put("errorCode", -1);
			modelObject.put("errorMsg", "error");
		}
	
		modelAndView.clear();
		modelAndView.addAllObjects(modelObject);
		modelAndView.setViewName("jsonView");
		//if (logger.isDebugEnabled()) {logger.debug("memberController-setmemberno-End");}

		return modelAndView;
	}

	


	
	public ModelAndView login(HttpServletRequest request, HttpServletResponse response){
		//String viewname=null;
	//	if (logger.isDebugEnabled()){logger.debug("memberController-login-Start");}

		ModelAndView modelAndView=new ModelAndView();
		try {
//			request.setCharacterEncoding("EUC-KR");
			String id=request.getParameter("mbId");
			String pw=request.getParameter("mbPw");
			//System.out.println("memberController login:"+memberregno);
			
//			response.setContentType("text/json; charset=UTF-8");
			
			MemberBean log=memberServiceFacade.login(id, pw, request);
			
			if(log!=null){
				//viewname="/welcome";
				request.getSession().setAttribute("mbId", id);
				
				//request.getSession().setAttribute("mbIsAdmin", "Y");
			//	request.getSession().setAttribute("mbName", );
		
				//modelAndView=new ModelAndView(viewname,null);
				modelAndView.setViewName("../jsp/welcome");
			}
		} catch (MemberNonExistentException e1) {
			//viewname="member/loginForm";
			modelObject.put("msg",e1.getMessage());
			modelAndView.setViewName("../jsp/member/loginForm");
			modelAndView.addAllObjects(modelObject);
		} catch (MemberPwMismatchException e2) {
			//viewname="member/loginForm";
			modelObject.put("msg",e2.getMessage());
			//modelAndView=new ModelAndView(viewname,modelObject);
			modelAndView.setViewName("../jsp/member/loginForm");
			modelAndView.addAllObjects(modelObject);
		}catch(Exception e3){
			modelObject.clear();
			modelObject.put("errorCode", -1);
			modelObject.put("errorMsg", "error");
			e3.printStackTrace();
			modelAndView.setViewName("../jsp/error");
			modelAndView.addAllObjects(modelObject);
		}
		//if (logger.isDebugEnabled()){logger.debug("memberController-login-End");}
		return modelAndView;
	}
	
	public ModelAndView logout(HttpServletRequest request,HttpServletResponse response){
		//if (logger.isDebugEnabled()){logger.debug("memberController-logout-Start");}

		memberServiceFacade.logout(request);
		//modelAndView.setViewName("../jsp/welcome");
		modelAndView.setViewName("../jsp/member/loginForm");
		//if (logger.isDebugEnabled()){logger.debug("memberController-logout-End");}

		return modelAndView;
	}

}
