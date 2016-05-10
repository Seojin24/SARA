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
import com.sara.base.to.CodeBean;
import com.sara.common.to.ListForm;


//public class CodeController implements Controller{
public class CodeController extends MultiActionController{
	
	ModelAndView modelAndView;
	public void setModelAndView(ModelAndView modelAndView) {
		this.modelAndView = modelAndView;
	}
	
	MessageSource messageSource;

	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}
	
	
	BaseServiceFacade baseServiceFacade;
	
	public void setBaseServiceFacade(BaseServiceFacade baseServiceFacade) {
		this.baseServiceFacade = baseServiceFacade;
	}
	
	protected final Log logger = LogFactory.getLog(getClass());

	
	//getCodeInfoList 
	public ModelAndView getCodeInfoList(HttpServletRequest request,
			HttpServletResponse response) {
		String code=request.getParameter("code");
		// --->code=position 
		HashMap<String,Object> modelObject=new HashMap<String,Object>();
		response.setContentType("text/json; charset=UTF-8");
		try{
			int pagenum=Integer.parseInt(request.getParameter("page"));
			int rowsize=Integer.parseInt(request.getParameter("rows"));
		    if(pagenum==0){pagenum=5;}
		    if(rowsize==0){rowsize=5;}
		
			ListForm listForm=new ListForm();
			listForm.setRowsize(rowsize);
			listForm.setPagenum(pagenum);
		//	ArrayList<CodeBean> codelist = baseServiceFacade.searchCode(listForm,code);
			
			int pagecount=listForm.getPagecount();
			modelObject.clear();
			modelObject.put("page",pagenum);
			modelObject.put("total",pagecount);
			//modelObject.put("list",codelist);
			modelObject.put("errorCode", 0); 		
			modelObject.put("errorMsg", "success");
			
		}catch(Exception e){
			modelObject.clear();
			modelObject.put("errorCode",-1);
			modelObject.put("errorMsg","error");
		}
	
		modelAndView.clear();
		modelAndView.addAllObjects(modelObject);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}

	public ModelAndView batchCode(HttpServletRequest request,
			HttpServletResponse response) {
//		HashMap<String,Object> modelObject=new HashMap<String,Object>();
//		ArrayList<CodeBean> codeInfoList=new ArrayList<CodeBean>();
//		try{
//			request.setCharacterEncoding("euc-kr");
//			System.out.println(request.getParameter("list"));
//			JSONObject jsonObject=JSONObject.fromObject(request.getParameter("list"));
//			JSONObject jsonObjectCodeBean= jsonObject.getJSONObject("codeBean");
//			CategoryCodeBean codeBean=(CategoryCodeBean)JSONObject.toBean(jsonObjectCodeBean,CategoryCodeBean.class);
//			
//			JSONArray codeInfoArray = jsonObjectCodeBean.getJSONArray("codeInfoBeanList");
//			for(int index=0; index<codeInfoArray.size(); index++){
//				CodeInfoBean codenBean=(CodeInfoBean )JSONObject.toBean(codeInfoArray.getJSONObject(index),CodeInfoBean.class);
//				codeInfoList.add(codenBean);
//			}
//			codeBean.setCodeInfoBeanList(codeInfoList);
//			baseServiceFacade.batchCode(codeBean);
//			modelObject.clear(); 
//			modelObject.put("errorCode", 0); 		
//			modelObject.put("errorMsg", "success");
//		}catch(Exception e){
//			modelObject.clear(); 
//			modelObject.put("errorCode",-1);
//			modelObject.put("errorMsg","肄붾뱶 �씪愿꾩쿂由� �삤瑜섏엯�땲�떎.");
//		}
//		
//		modelAndView.clear();
//		modelAndView.addAllObjects(modelObject);
//		modelAndView.setViewName("jsonView");
//		
		return modelAndView; 
	}

	
	public ModelAndView getCategoryCodeList(HttpServletRequest request,
			HttpServletResponse response) {
		HashMap<String,Object> modelObject=new HashMap<String,Object>();
		response.setContentType("text/json; charset=UTF-8");
		try{
			int pagenum=Integer.parseInt(request.getParameter("page"));
			int rowsize=Integer.parseInt(request.getParameter("rows"));
		    if(pagenum==0){pagenum=5;}
		    if(rowsize==0){rowsize=5;}
		
			ListForm listForm=new ListForm();
			listForm.setRowsize(rowsize);
			listForm.setPagenum(pagenum);
	
//			ArrayList<CategoryCodeBean> codelist = baseServiceFacade.searchCategoryCodeList(listForm);
//			//CategoryCodeBean 
//			int pagecount=listForm.getPagecount();
//			modelObject.clear(); 
//			modelObject.put("page",pagenum);
//			modelObject.put("total",pagecount);
//			modelObject.put("list",codelist);
//			modelObject.put("errorCode", 0); 		//�꽦怨듭떆 error Code =0 
//			modelObject.put("errorMsg", "success");
//			modelObject.put("CategoryCodeBean",new CategoryCodeBean());
//		
//			modelObject.put("CodeInfoBean",new CodeInfoBean());
		}catch(Exception e){
			modelObject.clear();
			modelObject.put("errorCode",-1);
			modelObject.put("errorMsg",e.getMessage());
		}
	
		modelAndView.clear(); 
		modelAndView.addAllObjects(modelObject);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}

	
}
