package com.koreait.cobox.exception;
//CRUD 작업시 발생되는 예외
public class DeleteFailException extends RuntimeException{

	
	public DeleteFailException(String msg) {
		super(msg);
	}
	public DeleteFailException(String msg,Throwable e) {
		super(msg,e);
	}
}
