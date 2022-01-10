package com.koreait.cobox.model.movie.repository;
import java.util.List;

import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.model.domain.Genre;
import com.koreait.cobox.model.domain.GenreList;


public interface GenreDAO {
	//CRUD
	
	public List selectAll();
	public List selectById(int movie_id); //fk movie_id에 소속된 데이터
	public Genre select(int genre_id);
	public void insert(GenreList genre);
	public void update(GenreList genre);
	public void delete(int genre_id);
	public List selectByGenre(String genre_name);
	
}
