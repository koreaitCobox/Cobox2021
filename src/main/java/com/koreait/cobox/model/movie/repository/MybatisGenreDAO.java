package com.koreait.cobox.model.movie.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.model.domain.Genre;

@Repository
public class MybatisGenreDAO implements GenreDAO{
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
	public Genre select(int genre_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(Genre genre) throws DMLException{
	 int result = sqlSessionTemplate.insert("Genre.insert",genre);
		if(result==0) {
			throw new DMLException("장르 등록에 실패했습니다.");
		}
}

	@Override
	public void update(Genre genre)  throws DMLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int genre_id) throws DMLException{
		// TODO Auto-generated method stub
		
	}
	
}
