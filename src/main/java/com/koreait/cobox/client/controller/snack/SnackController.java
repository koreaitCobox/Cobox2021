package com.koreait.cobox.client.controller.snack;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.cobox.model.domain.Movie;
import com.koreait.cobox.model.domain.Snack;
import com.koreait.cobox.model.movie.service.SnackService;



@Controller
public class SnackController {
	private static final Logger logger=LoggerFactory.getLogger(SnackController.class);
	@Autowired
	private SnackService snackService;
	
	
	//영화 한건 가져오기
	@RequestMapping(value="/client/snack/snackList", method=RequestMethod.POST)
	public @ResponseBody HashMap<Object,Object> getSnackAll(HttpServletRequest request, ModelMap model,HttpSession session){
		
		HashMap<Object,Object> resultMap = new HashMap<Object,Object>();
		List<Snack> snackAllList = snackService.selectAll();
	    resultMap.put("snackList", snackAllList);
	    model.addAttribute("snackList",snackAllList);
		
	    return resultMap;
	}
	
	
}
