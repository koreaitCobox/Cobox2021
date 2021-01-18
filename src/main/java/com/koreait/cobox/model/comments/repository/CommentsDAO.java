package com.koreait.cobox.model.comments.repository;

import java.util.List;

import com.koreait.cobox.model.domain.Comments;

public interface CommentsDAO {
	public List selectAll(int movie_id);
	public int insert(Comments comments);
	public int delete(int movie_id);
	
}
