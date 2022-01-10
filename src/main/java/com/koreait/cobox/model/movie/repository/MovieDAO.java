package com.koreait.cobox.model.movie.repository;

import java.util.HashMap;
import java.util.List;

import com.koreait.cobox.model.common.FileManager;
import com.koreait.cobox.model.domain.Box;
import com.koreait.cobox.model.domain.Genre;
import com.koreait.cobox.model.domain.Movie;

public interface MovieDAO {
	public List selectAll();
	public List<Movie> selectAll(HashMap<Object,Object> hashMap); //모든 영화
	public Movie selectById(int movie_id); //디테일
	public Movie select(int movie_id);
	public List selectByGenre(String genre_name);
	public void insert(Movie movie); 
	public void update(Movie movie);
	public void delete(int movie_id);
	public List<?> getGenreList();
	public List<?> getBoxList();
	public Box getBoxPrice(int box_id);
	public int selectMovieCount(HashMap<Object,Object>hashMap);
	public int movieCheckDelete(HashMap<Object,Object>hashMap);
}
