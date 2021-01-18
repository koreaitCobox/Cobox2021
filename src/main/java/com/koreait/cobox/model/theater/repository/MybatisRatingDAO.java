package com.koreait.cobox.model.theater.repository;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.cobox.model.domain.Rating;
import com.koreait.cobox.model.movie.service.MovieServiceImpl;
@Repository
public class MybatisRatingDAO implements RatingDAO{
	private static final Logger logger=LoggerFactory.getLogger(MovieServiceImpl.class);
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public Rating selectAllById(int rating_id) {
		
		return sqlSessionTemplate.selectOne("rating.selectAllById");
	}



}
