package com.sara.member.exception;

@SuppressWarnings("serial")
public class MemberNonExistentException extends Exception {
	//업무상의 예외로 정의될 것들은 checkedException을 상속받는다. 
	public MemberNonExistentException(String args0){
		super(args0);
	}
}
