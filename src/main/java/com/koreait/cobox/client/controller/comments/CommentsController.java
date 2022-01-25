package com.koreait.cobox.client.controller.comments;
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
	@RequestMapping(value="/client/comments/json",method=RequestMethod.POST,produces = "application/json")
	@ResponseBody
	public List commentsRegist(@RequestParam(value="msg",required = false, defaultValue="")String msg,
			@RequestParam(value="movie_id",required = false, defaultValue="")int movie_id,
			HttpServletRequest request,Comments comments) {
		
		
			logger.debug("movie_id : "+movie_id);
			logger.debug("msg : " + msg);
			
			comments.setMovie_id(movie_id);
			comments.setMsg(msg);
			comments.setMember_id(1);
			
			int result = commentsDAO.insert(comments); // 댓글 인서트
			List<Comments>commentsList=commentsService.selectAll(movie_id); // 댓글목록 가져오기
			
			
			return commentsList;
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
	
	
	  /**
	 * @Method : CommentsDelete
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 12.
	 * @Description : 댓글 삭제
	 * @param comments_id
	 * @param request
	 * @param response
	 * @param model
	 * @param session
	 * @return
	 */
	
	@RequestMapping(value="/client/comments/delete",method=RequestMethod.POST)
	public @ResponseBody List CommentsDelete(HttpServletRequest request, HttpServletResponse response,
			@RequestParam(value ="checkedSeqs", defaultValue="") int checkedSeqs,
			@RequestParam(value ="movie_id", defaultValue="") int movie_id,ModelMap model, HttpSession session
			) {
	
		int result = 0; 
		if(checkedSeqs>0) {
			result = commentsService.deleteComment(checkedSeqs); // 댓글 삭제
		}
		
		
		List<Comments>commentsList=commentsService.selectAll(movie_id); //댓글 가져오기
		
		return commentsList;
	}
	
	
	
	
	
	
}
