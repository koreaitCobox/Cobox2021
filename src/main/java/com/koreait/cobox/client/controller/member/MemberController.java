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
		
	//회원가입폼 요청 
	@RequestMapping(value="/client/member/join", method=RequestMethod.GET)
	public ModelAndView getRegistForm(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView("client/member/join");
		return mav;
	}

	//회원가입폼 정보(insert)
	@RequestMapping(value="/client/member/regist", method=RequestMethod.POST, produces="text/html;charset=utf-8")
	@ResponseBody
	public String regist(Member member) {
		
		logger.debug("아이디 "+member.getMid());
		logger.debug("비밀번호 "+member.getPassword());
		logger.debug("이름 "+member.getName());
		logger.debug("생년월일"+member.getBirth());
		logger.debug("이메일id "+member.getEmail_id());
		logger.debug("이메일server "+member.getEmail_server());
		logger.debug("핸드폰번호 "+member.getPhone());
		
		memberService.insert(member);

		StringBuffer sb = new StringBuffer();
		sb.append("{");
		sb.append(" \"result\":1, ");
		sb.append(" \"msg\":\"회원가입 성공\"");
		sb.append("}");
		
		return sb.toString();
	} 
	
	//로그인 홈 요청 
	@RequestMapping(value="/client/member/formtable", method=RequestMethod.GET)
	public ModelAndView getLoginForm() {
		ModelAndView mav = new ModelAndView("client/member/login");
		
		return mav;
	}
	
	//로그인 요청 처리(select)
	@RequestMapping(value="/client/member/login", method=RequestMethod.POST)
	public String login(Member member, HttpServletRequest request) {
		//db에 존재여부 확인 
				Member obj=memberService.select(member);
				
				//존재 O : 세션에 회원정보 담아두기
				HttpSession session=request.getSession();
				session.setAttribute("member", obj); //현재 클라이언트 요청과 연계된 세션에 보관해 놓는다
				
				return "redirect:/";
	}
	
	//로그아웃 홈 요청 
	@RequestMapping(value="/client/member/logoutform", method=RequestMethod.GET)
	public ModelAndView getLogoutForm() {
		ModelAndView mav = new ModelAndView("client/member/logout");
		
		return mav;
	}
	
	//로그아웃 요청 처리 
	@RequestMapping("/client/member/logout")
	public ModelAndView logout(HttpServletRequest request) {
		
		request.getSession().invalidate(); //세션 무효화, 이시점부터 담겨진 데이터가 다 무효가 된다
		
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("로그아웃 되었습니다");
		messageData.setUrl("/");
		
		ModelAndView mav = new ModelAndView("/");
		
		mav.addObject("messageData", messageData);
		return mav;
	}
	
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
	
	// 회원 탈퇴(delete)
	@RequestMapping("/client/member/delete")
	public String Withdraw(HttpSession session, Member member, RedirectAttributes rttr) throws MemberNotFoundException {
	 
	 Member membervo = (Member)session.getAttribute("member");
	 
	 String oldPass = membervo.getPassword();
	 String newPass = member.getPassword();
	     
	 //회원탈퇴를 위해 입력한 비밀번호와 기존 비밀번호가 일치하는지 비교하기 위해 equals 사용.
	 //바로 윗줄에서 기존 비밀번호와 입력한 비밀번호를 비교하기 위해 변수를 다르게 적용.
	 if(!(oldPass.equals(newPass))) {
	  rttr.addFlashAttribute("msg", false);
	  return "redirect:/";
	 }
	 
	 //데이터에서 고객정보 삭제
	 memberService.delete(member);
	 
	 //탈퇴와 동시에 로그아웃시키기
	 session.invalidate();
	  
	 return "redirect:/";
	}
	
	//예외 핸들러 2가지 처리
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
		System.out.println("수정 요청실패"+sb);
		return sb.toString();
	}
	
	@ExceptionHandler(DeleteFailException.class)
	@ResponseBody
	public String deleteException(DeleteFailException e) {
		StringBuffer sb=new StringBuffer();
		sb.append("{");
		sb.append("result:0");
		sb.append("}");		
		System.out.println("삭제실패"+sb);
		return sb.toString();
	}

}
