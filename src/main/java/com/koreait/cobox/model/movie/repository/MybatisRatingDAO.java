package com.koreait.cobox.model.movie.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.model.domain.Rating;
@Repository
public class MybatisRatingDAO implements RatingDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List selectById(int movie_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Rating select(int movie_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(Rating rating)  throws DMLException{
		int result=sqlSessionTemplate.insert("rating.insert",rating);
		if(result==0) {
			throw new DMLException("연령등록에 실패하였습니다.");
		}
	}

	@Override
	public void update(Rating rating) throws DMLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int rating_id) throws DMLException {
		// TODO Auto-generated method stub
		
	}
	
	

}
