package com.koreait.cobox.model.movie.service;

import java.util.List;

import com.koreait.cobox.model.common.FileManager;
import com.koreait.cobox.model.domain.Movie;

public interface MovieService {
	public List selectAll(); //모든 영화
	public Movie selectById(int movie_id); 
	public Movie select(int movie_id);
	public List selectByGenre(String genre_name);
	public void regist(FileManager fileManager,Movie movie); 
	public void update(FileManager fileManager,Movie movie);
	public void delete(int movie_id);
}
