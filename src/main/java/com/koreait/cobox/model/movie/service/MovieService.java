package com.koreait.cobox.model.movie.service;

import java.util.HashMap;
import java.util.List;

import com.koreait.cobox.model.common.FileManager;
import com.koreait.cobox.model.domain.Box;
import com.koreait.cobox.model.domain.Genre;
import com.koreait.cobox.model.domain.Movie;

public interface MovieService {
	public List selectAll(); //main에 가져올 
	public List<Movie> selectAll(HashMap<Object,Object> hashMap); //모든 영화 movielist 에서 조건부 
	public Movie selectById(int movie_id); 
	public Movie select(int movie_id);
	public List selectByGenre(String genre_name);
	public void regist(FileManager fileManager,Movie movie); 
	public void update(FileManager fileManager,Movie movie);
	public void delete(int movie_id);
	public List<?> getGenreList();
	public List<?> getBoxList();
	public Box getBoxPrice(int box_id);
	public int selectMovieCount(HashMap<Object,Object>hashmap);
	int deleteCheck(HashMap<Object, Object> hashMap); // 셀렉박스 선택한 것만 삭제
}
