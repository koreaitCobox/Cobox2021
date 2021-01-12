package com.koreait.cobox.model.comments.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.cobox.model.domain.Comments;
@Repository
public class MybatisCommentsDAO implements CommentsDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	@Override
	public List selectAll(int movie_id) {
		return sqlSessionTemplate.selectList("comments.selectAll",movie_id);
	}

	@Override
	public int insert(Comments comments) {
		
		return 0;
	}

	@Override
	public int delete(int comments_id) {
		
		return 0;
	}

}
