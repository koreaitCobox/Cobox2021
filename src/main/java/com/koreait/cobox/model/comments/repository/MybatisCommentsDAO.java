package com.koreait.cobox.model.comments.repository;

import java.util.List;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.cobox.exception.CommentsRegistException;
import com.koreait.cobox.model.domain.Comments;
@Repository
public class MybatisCommentsDAO implements CommentsDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	@Override
	public List selectAll(int movie_id) {
		return sqlSessionTemplate.selectList("Comments.selectAll",movie_id);
	}

	@Override
	public int insert(Comments comments) throws CommentsRegistException{
		int result= sqlSessionTemplate.insert("Comments.insert",comments);
		if(result==0) {
			throw new CommentsRegistException("댓글 후기등록 실패");
		}
	return result;
	}

	@Override
	public int delete(int movie_id) {
		return sqlSessionTemplate.delete("Comments.delete",movie_id);
		
		
	}

	@Override
	public int deleteComment(int comments_id) {

		return sqlSessionTemplate.delete("Comments.deleteComment", comments_id);
	}

}
