package com.koreait.cobox.exception;

public class MemberEditException extends RuntimeException{
	
	public MemberEditException(String msg) {
		super(msg);
	}
	public MemberEditException(String msg, Throwable e) {
		super(msg, e);
	}
}