package com.koreait.cobox.exception;

public class MemberDeleteException extends RuntimeException{
	
	public MemberDeleteException(String msg) {
		super(msg);
	}
	public MemberDeleteException(String msg, Throwable e) {
		super(msg, e);
	}
}