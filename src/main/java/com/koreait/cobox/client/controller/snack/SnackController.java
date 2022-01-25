package com.koreait.cobox.client.controller.snack;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
	
	/**
	 * 
	 * @MethodName : getSnackAll
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 07.
	 * @Description : 스낵 리스트 가져오기
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/client/snack/snackList", method=RequestMethod.POST)
	public @ResponseBody HashMap<Object,Object> getSnackAll(HttpServletRequest request, ModelMap model,HttpSession session){
		
		HashMap<Object,Object> resultMap = new HashMap<Object,Object>();
		List<Snack> snackAllList = snackService.selectAll();
	    resultMap.put("snackList", snackAllList);
	    model.addAttribute("snackList",snackAllList);
		
	    return resultMap;
	}
	
	/**
	 * 
	 * @MethodName : getSnackAll
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 07.
	 * @Description : 품절 여부 
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/admin/snack/soldout",method=RequestMethod.POST)
	public @ResponseBody String updateSnackused(@RequestParam(value = "snack_id", required = false, defaultValue = "") int snack_id,
			@RequestParam(value = "used_fl", required = false, defaultValue = "") String used_fl,
			HttpServletRequest request, HttpServletResponse response, ModelMap model, HttpSession session
			){
		
		HashMap<Object,Object> params = new HashMap<Object,Object>();
		
			params.put("snack_id", snack_id);
			params.put("used_fl", used_fl);
			
			int result = 0;
			
			try {
				result = snackService.updateSnackused(params);
				System.out.println(result);
				if(result > 0 ) {
					return "true";
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		return "false";
	}
	
	
	/**
	 * 
	 * @MethodName : insertSnackStat
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 07.
	 * @Description : 스낵 통계 insert
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/client/snack/insertSnackStat",method=RequestMethod.POST)
	public @ResponseBody int insertSnackStat(@RequestParam(value = "snack_id", required = false, defaultValue = "") int snack_id,
			@RequestParam(value = "sales_amount", required = false, defaultValue = "") int sales_amount,
			HttpServletRequest request, HttpServletResponse response, ModelMap model, HttpSession session
			){
			System.out.println("snack_id : " + snack_id);
			System.out.println("sales_amount : " + sales_amount);
			
			HashMap<Object,Object> params = new HashMap<Object,Object>();
			params.put("snack_id", snack_id);
			params.put("sales_amount", sales_amount);
			int result = 0;
			result = snackService.insertSnackStat(params);
			
			return result;
	}
	
	
	/**
	 * 
	 * @MethodName : updateSnackCnt
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 07.
	 * @Description : 스낵 판매량 update
	 * @param request
	 * @param model
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/client/snack/updateSnackCnt",method=RequestMethod.POST)
	public @ResponseBody int updateSnackCnt(@RequestParam(value = "snack_id", required = false, defaultValue = "") int snack_id,
			@RequestParam(value = "sales_amount", required = false, defaultValue = "") int sales_amount,
			HttpServletRequest request, HttpServletResponse response, ModelMap model, HttpSession session){
	
			HashMap<Object,Object> params = new HashMap<Object,Object>();
			params.put("snack_id", snack_id);
			params.put("sales_amount", sales_amount);
		
			int result = 0;
			result = snackService.updateSnackCnt(params);
			
			return result ;
		

	}
	
	
}
