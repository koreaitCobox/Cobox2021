package com.koreait.cobox.exception;
//CRUD 작업시 발생되는 예외
public class DMLException extends RuntimeException{

	
	public DMLException(String msg) {
		super(msg);
	}
	public DMLException(String msg,Throwable e) {
		super(msg,e);
	}
}
