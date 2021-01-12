package com.koreait.cobox.model.movie.repository;
import java.util.List;
import com.koreait.cobox.model.domain.Genre;


public interface GenreDAO {
	//CRUD
	
	public List selectAll();
	public List selectById(int movie_id);
	public Genre select(int genre_id);
	public void insert(Genre genre);
	public void update(Genre genre);
	public void delete(int genre_id);
}
