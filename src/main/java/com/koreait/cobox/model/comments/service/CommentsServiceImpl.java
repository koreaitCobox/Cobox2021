package com.koreait.cobox.model.comments.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.cobox.model.comments.repository.CommentsDAO;
import com.koreait.cobox.model.domain.Comments;
@Service
public class CommentsServiceImpl implements CommentsService {
	@Autowired
	private CommentsDAO commentsDAO;
	
	@Override
	public List selectAll(int movie_id) {
		return commentsDAO.selectAll(movie_id);
	}

	@Override
	public int insert(Comments comments) {
		return commentsDAO.insert(comments);
		 
	}

	@Override
	public int delete(int comments_id) {
		
		return 0;
	}

}
