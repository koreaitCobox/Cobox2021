package com.koreait.cobox.exception;
//CRUD 작업시 발생되는 예외
public class EditFailException extends RuntimeException{

	
	public EditFailException(String msg) {
		super(msg);
	}
	public EditFailException(String msg,Throwable e) {
		super(msg,e);
	}
}
