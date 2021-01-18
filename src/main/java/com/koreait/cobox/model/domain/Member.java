package com.koreait.cobox.model.domain;

import lombok.Data;

@Data
public class Member {
	private int member_id;
	private String mid;
	private String password;
	private String name;
	private String birth;
	private String email_id;
	private String email_server;
	private String phone;
	private String point;
	
}