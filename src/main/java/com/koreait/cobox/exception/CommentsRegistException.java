package com.koreait.cobox.exception;

public class CommentsRegistException extends RuntimeException{
	public CommentsRegistException(String msg) {
		super(msg);
	}
	public CommentsRegistException(String msg,Throwable e) {
		super(msg,e);
	}
}
