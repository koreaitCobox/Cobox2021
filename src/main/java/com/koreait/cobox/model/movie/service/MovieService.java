package com.koreait.cobox.model.movie.service;

import java.util.List;

import com.koreait.cobox.common.FileManager;
import com.koreait.cobox.model.domain.Movie;

public interface MovieService {
	public List selectAll(); //모든 영화
	public Movie selectById(int movie_id); 
	public void regist(FileManager fileManager,Movie movie); 
	public void update(Movie movie);
	public void delete(int movie_id);
}
