package com.koreait.cobox.exception;

public class MovieRegistException extends RuntimeException{
	public MovieRegistException(String msg) {
		super(msg);
	}
	public MovieRegistException(String msg,Throwable e) {
		super(msg,e);
	}
}
