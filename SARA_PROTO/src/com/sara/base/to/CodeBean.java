package com.sara.base.to;

import java.util.ArrayList;

public class CodeBean extends BaseBean {
	private String cdNo,cdName,cdDetail,cd1,cd2,cd3,cd4,cd5;
	public String getCdNo() {
		return cdNo;
	}
	public void setCdNo(String cdNo) {
		this.cdNo = cdNo;
	}
	public String getCdName() {
		return cdName;
	}
	public void setCdName(String cdName) {
		this.cdName = cdName;
	}
	public String getCdDetail() {
		return cdDetail;
	}
	public void setCdDetail(String cdDetail) {
		this.cdDetail = cdDetail;
	}
	public String getCd1() {
		return cd1;
	}
	public void setCd1(String cd1) {
		this.cd1 = cd1;
	}
	public String getCd2() {
		return cd2;
	}
	public void setCd2(String cd2) {
		this.cd2 = cd2;
	}
	public String getCd3() {
		return cd3;
	}
	public void setCd3(String cd3) {
		this.cd3 = cd3;
	}
	public String getCd4() {
		return cd4;
	}
	public void setCd4(String cd4) {
		this.cd4 = cd4;
	}
	public String getCd5() {
		return cd5;
	}
	public void setCd5(String cd5) {
		this.cd5 = cd5;
	}
	public ArrayList<CodeDetailBean> getCodeDeatilBeanList() {
		return codeDeatilBeanList;
	}
	public void setCodeDeatilBeanList(ArrayList<CodeDetailBean> codeDeatilBeanList) {
		this.codeDeatilBeanList = codeDeatilBeanList;
	}
	private ArrayList<CodeDetailBean> codeDeatilBeanList=new ArrayList<CodeDetailBean>();
	//1대 다 관계--> 다 부분을 arrayList로 변경 


}