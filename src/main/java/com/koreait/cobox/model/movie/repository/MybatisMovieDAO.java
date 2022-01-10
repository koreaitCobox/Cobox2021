package com.koreait.cobox.model.movie.repository;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.exception.MovieRegistException;
import com.koreait.cobox.model.domain.Box;
import com.koreait.cobox.model.domain.Movie;

@Repository
public class MybatisMovieDAO implements MovieDAO{
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	//main에 가져올 select 
	@Override
	public List selectAll() {
		return sqlSessionTemplate.selectList("Movie.selectAll1");
	}
	//조건부 select 
	@Override
	public List<Movie> selectAll(HashMap<Object,Object> hashMap) {
		return sqlSessionTemplate.selectList("Movie.selectAll",hashMap);
	}

	
	@Override
	public Movie selectById(int movie_id) {
		return sqlSessionTemplate.selectOne("Movie.selectById",movie_id);
		
	}

	@Override
	public void insert(Movie movie) throws MovieRegistException{
		int result=sqlSessionTemplate.insert("Movie.insert",movie);
		if(result==0) {
			throw new DMLException("영화테이블에 입력 실패");
		}
	}

	@Override
	public void update(Movie movie)  throws MovieRegistException{
		int result=sqlSessionTemplate.update("Movie.update",movie);
		if(result==0) {
			throw new DMLException("영화정보 수정 실패");
		}
		
	}

	@Override
	public void delete(int movie_id)  throws MovieRegistException{
		int result=sqlSessionTemplate.delete("Movie.delete",movie_id);	
		if(result==0) {
			throw new DMLException("영화정보 삭제 실패");
		}
	}

	@Override
	public Movie select(int movie_id) {
		return sqlSessionTemplate.selectOne("Movie.select",movie_id);
	}

	@Override
	public List selectByGenre(String genre_name) {
		return sqlSessionTemplate.selectList("Movie.selectByGenre",genre_name);
		
	}

	@Override
	public List<?> getGenreList() {
		
		return sqlSessionTemplate.selectList("Movie.getGenreList");
	}

	@Override
	public List<?> getBoxList() {
		
		return sqlSessionTemplate.selectList("Movie.getBoxList");
	}

	@Override
	public Box getBoxPrice(int box_id) {
		
		return sqlSessionTemplate.selectOne("Movie.getBoxPrice",box_id);
	}
	@Override
	public int selectMovieCount(HashMap<Object, Object> hashMap) {
		
		return sqlSessionTemplate.selectOne("Movie.selectMovieCount", hashMap);
	}
	@Override
	public int movieCheckDelete(HashMap<Object, Object> hashMap) {
		System.out.println(hashMap);
		
		return sqlSessionTemplate.delete("Movie.movieCheckDelete", hashMap);
	}

	
	

}
