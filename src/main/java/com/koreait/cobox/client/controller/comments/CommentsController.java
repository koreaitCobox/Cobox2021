package com.koreait.cobox.client.controller.comments;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.cobox.admin.controller.AdminMovieController;
import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.model.comments.repository.CommentsDAO;
import com.koreait.cobox.model.comments.repository.MybatisCommentsDAO;
import com.koreait.cobox.model.comments.service.CommentsService;
import com.koreait.cobox.model.domain.Comments;
import com.koreait.cobox.model.domain.Member;
import com.koreait.cobox.model.domain.Movie;
import com.koreait.cobox.model.movie.repository.MovieDAO;

@Controller
public class CommentsController {
	private static final Logger logger=LoggerFactory.getLogger(AdminMovieController.class);
	@Autowired
	private MovieDAO movieDAO;
	@Autowired
	private CommentsDAO commentsDAO;
	@Autowired
	private CommentsService commentsService;
	
	
	//댓글 insert
	
	@RequestMapping(value="/client/comments/json",method=RequestMethod.POST,produces="text/html;charset=utf8")
	@ResponseBody
	public String commentsRegist(HttpServletRequest request,Comments comments) {
		HttpSession session = request.getSession();
		Member member=(Member)session.getAttribute("member");
		
		String movie_id=request.getParameter("movie_id");
		String msg=request.getParameter("msg");
		
		logger.debug(movie_id);
		logger.debug(msg);

	//	comments.setMember_id(member.getMember_id());
		comments.setMovie_id(Integer.parseInt(movie_id));
		comments.setMsg(msg);
		
		int result = commentsDAO.insert(comments);
		
		logger.debug("result"+result);
		request.setAttribute("resutl", result);
		StringBuilder sb=new StringBuilder();
		sb.append("{");
		sb.append("\"result\":1,");
		sb.append("\"msg\":\"댓글등록성공\"");
		sb.append("}");
		
		return sb.toString();
	}
	//목록 가져오기
	@RequestMapping(value="/client/comments/list",method=RequestMethod.GET)
	@ResponseBody
	public List CommentsList(HttpServletRequest request,int movie_id) {
		//HttpSession session = request.getSession();
		//Member member=(Member)session.getAttribute("member");
		
		List<Comments>commentsList=commentsService.selectAll(movie_id);

				
		
		return commentsList;
	}
	
	
	
}
