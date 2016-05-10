package com.sara.base.to;
//basebean의 역활---> 수정,삭제,추가를 결정함 
public class BaseBean{
	protected String status;

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
}