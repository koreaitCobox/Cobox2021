package com.koreait.cobox.client.controller.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.koreait.cobox.exception.DeleteFailException;
import com.koreait.cobox.exception.EditFailException;
import com.koreait.cobox.exception.MemberNotFoundException;
import com.koreait.cobox.exception.MemberRegistException;
import com.koreait.cobox.model.domain.Member;
import com.koreait.cobox.model.domain.MessageData;
import com.koreait.cobox.model.member.service.MemberService;

@Controller
public class MemberController {
	private static final Logger logger=LoggerFactory.getLogger(MemberController.class);

	@Autowired
	private MemberService memberService;
		
	/**
	 * @Method : getRegistForm
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 사용자 회원가입 페이지
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/client/member/join", method=RequestMethod.GET)
	public ModelAndView getRegistForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("client/member/join");
		return mav;
	}

	/**
	 * @Method : getRegistForm
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 사용자 회원 등록 
	 * @param member : 사용자 VO
	 * @return
	 */
	@RequestMapping(value="/client/member/regist", method=RequestMethod.POST, produces="text/html;charset=utf-8")
	@ResponseBody
	public String regist(Member member) {
		
		logger.debug("멤버 아이디 : "+member.getMid());
		logger.debug("비밀번호 :"+member.getPassword());
		logger.debug("이름 : "+member.getName());
		logger.debug("생년월일 :"+member.getBirth());
		logger.debug("이메일아이디 : "+member.getEmail_id());
		logger.debug("서버 : "+member.getEmail_server());
		logger.debug("전화번호 : "+member.getPhone());
		
		memberService.insert(member);

		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":1, ");
		sb.append(" \"msg\":\"회원가입 성공\"");
		sb.append("}");
		
		return sb.toString();
	} 
	
	/**
	 * @Method : getLoginForm
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 사용자 로그인 페이지 
	 * @param member : 사용자 VO
	 * @return
	 */
	@RequestMapping(value="/client/member/formtable", method=RequestMethod.GET)
	public String getLoginForm() {
		
		
		return "client/member/login";
	}
	
	/**
	 * @Method : login
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 사용자 로그인 
	 * @param member : 사용자 VO
	 * @param request  
	 * @return
	 */
	@RequestMapping(value="/client/member/login", method=RequestMethod.POST)
	public String login(Member member, HttpServletRequest request) {
		
		Member obj=memberService.select(member);
		if(obj == null) { // 가입되지 않은 정보로 로그인 하려고 하면 
			
			return "client/member/noinfo";
		
		}else {//가입된 정보가 있으면 
		 
			//1) 세션 가져오기
			HttpSession session=request.getSession();
			session.setAttribute("member", obj); 
			
			//2) 세션 유지시간 설정 1800 = 60 * 30 (30 분)
			session.setMaxInactiveInterval(1800); 
			
			return "redirect:/";
		}
	}
	
	
	/**
	 * @Method : getLogoutForm
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 사용자 로그아웃 페이지
	 * @param member : 사용자 VO
	 * @return
	 */
	@RequestMapping(value="/client/member/logoutform", method=RequestMethod.GET)
	public String getLogoutForm() {
	
		return "client/member/logout";
	}
	
	/**
	 * @Method : logout
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 사용자 로그아웃
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/client/member/logout")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate(); //세션 무효화
		//request.getSession(true); //새로운 세션 아이디 발급
		
		
		return "client/member/logout";
	}
	
	/**
	 * @Method : edit
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 사용자 정보 수정
	 * @param member : 사용자 VO
	 * @return
	 */
	@RequestMapping(value="/admin/member/edit", method=RequestMethod.POST)
	@ResponseBody
	public String edit(Member member) {
		
		memberService.update(member);
		
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("\"result\":1");
		sb.append("}");
		return sb.toString();
	}
	
	// �쉶�썝 �깉�눜(delete)
	@RequestMapping("/client/member/delete")
	public String Withdraw(HttpSession session, Member member, RedirectAttributes rttr) throws MemberNotFoundException {
	 
	 Member membervo = (Member)session.getAttribute("member");
	 
	 String oldPass = membervo.getPassword();
	 String newPass = member.getPassword();
	     
	 //�쉶�썝�깉�눜瑜� �쐞�빐 �엯�젰�븳 鍮꾨�踰덊샇�� 湲곗〈 鍮꾨�踰덊샇媛� �씪移섑븯�뒗吏� 鍮꾧탳�븯湲� �쐞�빐 equals �궗�슜.
	 //諛붾줈 �쐵以꾩뿉�꽌 湲곗〈 鍮꾨�踰덊샇�� �엯�젰�븳 鍮꾨�踰덊샇瑜� 鍮꾧탳�븯湲� �쐞�빐 蹂��닔瑜� �떎瑜닿쾶 �쟻�슜.
	 if(!(oldPass.equals(newPass))) {
	  rttr.addFlashAttribute("msg", false);
	  return "redirect:/";
	 }
	 
	 //�뜲�씠�꽣�뿉�꽌 怨좉컼�젙蹂� �궘�젣
	 memberService.delete(member);
	 
	 //�깉�눜�� �룞�떆�뿉 濡쒓렇�븘�썐�떆�궎湲�
	 session.invalidate();
	  
	 return "redirect:/";
	}
	
	//�삁�쇅 �빖�뱾�윭 2媛�吏� 泥섎━
	@ExceptionHandler(MemberRegistException.class)
	@ResponseBody
	public String handleException(MemberRegistException e) {
		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":0, ");
		sb.append(" \"msg\":\""+e.getMessage()+"\"");
		sb.append("}");
		
		return sb.toString();
	}
	
	@ExceptionHandler(EditFailException.class)
	@ResponseBody
	public String editException(EditFailException e) {
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("result:0");
		sb.append("}");		
		System.out.println("�닔�젙 �슂泥��떎�뙣"+sb);
		return sb.toString();
	}
	
	@ExceptionHandler(DeleteFailException.class)
	@ResponseBody
	public String deleteException(DeleteFailException e) {
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("result:0");
		sb.append("}");		
		System.out.println("�궘�젣�떎�뙣"+sb);
		return sb.toString();
	}

}
