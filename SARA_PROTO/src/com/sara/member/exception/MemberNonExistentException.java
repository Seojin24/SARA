package com.sara.member.exception;

@SuppressWarnings("serial")
public class MemberNonExistentException extends Exception {
	//�������� ���ܷ� ���ǵ� �͵��� checkedException�� ��ӹ޴´�. 
	public MemberNonExistentException(String args0){
		super(args0);
	}
}
