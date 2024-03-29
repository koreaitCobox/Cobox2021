package com.koreait.cobox.model.comments.service;

import java.util.List;

import com.koreait.cobox.model.domain.Comments;

public interface CommentsService {
	public List selectAll(int movie_id);
	public int insert(Comments comments);
	public int delete(int comments_id);
	public int deleteComment(int comments_id);

}
