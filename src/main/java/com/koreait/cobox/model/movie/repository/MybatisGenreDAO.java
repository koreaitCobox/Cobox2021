package com.koreait.cobox.model.movie.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.model.domain.Genre;
import com.koreait.cobox.model.domain.GenreList;

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
		
		return null;
	}

	@Override
	public Genre select(int genre_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(GenreList genre) throws DMLException{
	 int result = sqlSessionTemplate.insert("Genre.insert",genre);
		if(result==0) {
			throw new DMLException("장르 등록에 실패했습니다.");
		}
}

	@Override
	public void update(GenreList genre)  throws DMLException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int genre_id) throws DMLException{
		int result=sqlSessionTemplate.delete("Genre.delete",genre_id);
		if(result==0) {
			throw new DMLException("장르 삭제에 삭제했습니다");
		}
	}

	@Override
	public List selectByGenre(String genre_list_name) {
		return sqlSessionTemplate.selectList("Genre.selectByGenre",genre_list_name);
		
	}


	
}
