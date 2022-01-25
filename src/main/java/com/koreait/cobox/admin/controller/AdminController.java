package com.koreait.cobox.admin.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.koreait.cobox.model.common.FileManager;
import com.koreait.cobox.model.domain.GenreList;
import com.koreait.cobox.model.domain.MessageData;
import com.koreait.cobox.model.domain.Movie;
import com.koreait.cobox.model.domain.Snack;

@Controller
public class AdminController {
	private static final Logger logger=LoggerFactory.getLogger(AdminController.class);
	@Autowired
	FileManager fileManager;
	
	
	/**
	 * @Method : adminMain
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 12.
	 * @Description : 관리자 로그인 페이지
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/admin")
	public String adminMain(HttpServletRequest request,HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		
		session.removeAttribute("sctoken");//session 에 있는 sctoken reset
		String sctoken = tokenMake();
		session.setAttribute("sctoken", sctoken); //새로 만든 토큰 set
		
		System.out.println(sctoken);
		return "admin/login";
	}

	/**
	 * 토근 생성
	 * @return String
	 */
	public String tokenMake() {
		
		 char [] initRandomChar = {'A', 'B', 'C', 'D', 'F', 'G', 'H', 'I', 'J',
				    'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
				   'N', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0',
				   '1', '2', '3', '4', '5', '6', '7', '8', '9'};
				   // 랜덤 함수를 이용하여 무작위 문자열 생성
				   StringBuffer sb = new StringBuffer();
				   for ( int n=0; n<6; n++) {
				   int index = (int) (initRandomChar.length * Math.random());
				   sb.append(initRandomChar[index]);
				  }
				 // 토큰 생성
				 String strToken = sb.toString();
				 
				return  strToken;
	}
	
}
