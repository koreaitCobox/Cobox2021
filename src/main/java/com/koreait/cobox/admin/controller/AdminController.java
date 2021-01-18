package com.koreait.cobox.admin.controller;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.koreait.cobox.model.common.FileManager;
import com.koreait.cobox.model.domain.MessageData;

@Controller
public class AdminController {
	@Autowired
	FileManager fileManager;
	@RequestMapping("/admin")
	public String adminMain() {
		
		return "admin/main";
	}

	
	
}
