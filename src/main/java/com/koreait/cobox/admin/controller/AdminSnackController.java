package com.koreait.cobox.admin.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
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

import com.koreait.cobox.model.common.FileManager;
import com.koreait.cobox.model.common.Pager;
import com.koreait.cobox.model.domain.Snack;
import com.koreait.cobox.model.movie.repository.SnackDAO;
import com.koreait.cobox.model.movie.service.SnackService;

@Controller
public class AdminSnackController {
		private static final Logger logger=LoggerFactory.getLogger(AdminSnackController.class);
		@Autowired
		private SnackDAO snackDAO;
		@Autowired
		private SnackService snackService;
		@Autowired
		private FileManager fileManager; 
		@Autowired
		private Pager pager;
		
		private ServletContext servletContext;
		
		
		/**
		 * @Method : snRegistForm
		 * @Author : Suyeon Kim
		 * @Date : 2022. 01. 12.
		 * @Description : 스낵 등록 페이지
		 * @return
		 */
		@RequestMapping("/admin/snack/registform")
		public String snRegistForm() {
			
			return "admin/snack/s_regist_form";
		}
		   
		/**
		 * @Method : registSnack
		 * @Author : Suyeon Kim
		 * @Date : 2022. 01. 12.
		 * @Description : 스낵 등록 
		 * @param snack
		 * @return
		 */
	   @RequestMapping(value="/admin/snack/regist",method=RequestMethod.POST, produces="text/html;charset=utf8")
	   public @ResponseBody String registSnack(Snack snack) {
		  logger.debug("스낵번호 :"+snack.getSnack_id());
		  logger.debug("스낵분류 :"+snack.getTopcategory_id());
		  logger.debug("스낵이름 :"+snack.getSnack_name());
		  logger.debug("스낵가격 :"+snack.getPrice());
		  logger.debug("스낵개수 :"+snack.getAmount());
		  logger.debug("스낵설명 :"+snack.getDetail());
		  
	  
		  snackService.regist(fileManager, snack); //영화등록 서비스에게 요청
		  
		   
		   StringBuilder sb=new StringBuilder();
		   sb.append("{");
		   sb.append("\"result\":1,");
		   sb.append("\"msg\":\"스낵 등록성공\"");
		   sb.append("}");
		
		   
		  return sb.toString();
	   }
	   
	   /**
		 * @Method : getSnackList
		 * @Author : Suyeon Kim
		 * @Date : 2022. 01. 12.
		 * @Description : 스낵 목록 가져오기 (전체)
		 * @param request
		 * @param session
		 * @return
		 */
	   @RequestMapping(value="/admin/snack/list",method=RequestMethod.GET)
	   public String getSnackList(HttpServletRequest request, ModelMap model,HttpSession session) {
		   
		   //파라미터 받아서 
		   
		   
		   List<Snack> snackList = snackService.selectAll();
		   pager.init(request,snackList);
		   
		   model.addAttribute("snackList",snackList);
		   
		   return "admin/snack/snack_list";
	   }
		  
	   /**
		 * @Method : getAjaxSnackList
		 * @Author : Suyeon Kim
		 * @Date : 2022. 01. 12.
		 * @Description : 스낵 분류에 맞는 리스트 가져오기
		 * @param topcategory_id
		 * @param request
		 * @param session
		 * @return
		 */
		   @RequestMapping(value="/admin/snack/ajaxList",method=RequestMethod.POST)
		   public @ResponseBody HashMap<Object,Object> getAjaxSnackList(@RequestParam(value="topcategory_id") int topcategory_id,
				   HttpServletRequest request, ModelMap model,HttpSession session) {
			   
			   HashMap<Object,Object> resultMap = new HashMap<Object,Object>();
			   
			   //파라미터 받아서

			   List<Snack> snackList = snackService.selectById(topcategory_id);
			   
			   pager.init(request,snackList);
			  resultMap.put("snackList", snackList);
			  model.addAttribute("snackList",snackList);
			  
			  
			   return resultMap;
		   }
		   
		   

		   /**
			 * @Method : getSnackCheckDelete
			 * @Author : Suyeon Kim
			 * @Date : 2022. 01. 12.
			 * @Description : 선택한 스낵 삭제
			 * @param checkedSeqs
			 * @param request
			 * @param response
			 * @param model
			 * @param session
			 * @return
			 */
		   @RequestMapping(value="/admin/snack/snackCheckDelete", method = RequestMethod.POST)
		  public @ResponseBody String getSnackCheckDelete(HttpServletRequest request, HttpServletResponse response,
				  @RequestParam(value="checkedSeqs",defaultValue="")String checkedSeqs,
				  ModelMap model,HttpSession session ) {
			   
				   HashMap<Object, Object> params = new HashMap<Object, Object>();
				   List<String>seqs = Arrays.asList(checkedSeqs.split(","));
				   params.put("seqs", seqs);
				   
				   int result = 0 ;
				   if(seqs.size() > 0) {
					   result = snackService.deleteCheck(params);
				   }
				   // 삭제 성공했다면 true 리턴 
				   if(result > 0) {
					   return "true";
				   }
				   // 삭제 실패시 false 리턴
				 return "false";
		   } 
		   
		   /**
			 * 
			 * @MethodName : selectSnackStat
			 * @Author : Suyeon Kim
			 * @Date : 2022. 01. 25.
			 * @Description : 스낵 판매 통계 
			 * @param request
			 * @param model
			 * @param session
			 * @return
			 */
			@RequestMapping(value="/admin/snack/selectSnackStat",method=RequestMethod.GET)
			public @ResponseBody HashMap<Object,Object> selectSnackStat(
					HttpServletRequest request, HttpServletResponse response, ModelMap model, HttpSession session){

				HashMap<Object,Object> resultMap = new HashMap<Object,Object>();
				List<?> snackStatList = snackService.selectSnackStat();
			    resultMap.put("snackStatList", snackStatList);
			   
			    return resultMap;

			}
		   
}
