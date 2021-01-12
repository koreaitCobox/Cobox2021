package com.koreait.cobox.controller.comments;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.koreait.cobox.controller.movie.MovieController;
import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.model.comments.repository.CommentsDAO;
import com.koreait.cobox.model.domain.Comments;
import com.koreait.cobox.model.domain.Movie;
import com.koreait.cobox.model.movie.repository.MovieDAO;
import com.koreait.cobox.model.movie.service.CommentsService;

@Controller
public class CommentsController {
	private static final Logger logger=LoggerFactory.getLogger(MovieController.class);
	@Autowired
	private MovieDAO movieDAO;
	
	@Autowired
	private CommentsDAO commentsDAO;
	@Autowired
	private CommentsService commentsService;
	@RequestMapping(value="/client/comments/regist",method=RequestMethod.POST)
	public String registComments(Comments comments,Movie movie) throws DMLException{
		logger.debug("댓글번호: "+ comments.getComments_id());
		//logger.debug("회원아이디: "+ comments.getComments_id());
		logger.debug("영화번호: "+ movie.getMovie_id());
		logger.debug("댓글내용: "+ comments.getMsg());
		logger.debug("작성시간: "+ comments.getCdate());
		
		
		commentsService.insert(comments);
		
		StringBuilder sb=new StringBuilder();
		   sb.append("{");
		   sb.append("\"result\":1,");
		   sb.append("\"msg\":\"댓글 등록성공\"");
		   sb.append("}");
		return sb.toString();
	}
}
