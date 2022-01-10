package com.koreait.cobox.model.movie.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.model.common.FileManager;
import com.koreait.cobox.model.domain.Box;
import com.koreait.cobox.model.domain.Genre;
import com.koreait.cobox.model.domain.GenreList;
import com.koreait.cobox.model.domain.Movie;
import com.koreait.cobox.model.movie.repository.GenreDAO;
import com.koreait.cobox.model.movie.repository.MovieDAO;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class MovieServiceImpl implements MovieService{
	private static final Logger logger=LoggerFactory.getLogger(MovieServiceImpl.class);
	@Autowired
	private MovieDAO movieDAO;
	@Autowired
	private GenreDAO genreDAO;
	
	@Override
	public List selectAll() {
		return movieDAO.selectAll();
	}

	@Override
	public List<Movie> selectAll(HashMap<Object,Object> hashMap) {
		return movieDAO.selectAll(hashMap);
	}

	@Override
	public Movie selectById(int movie_id) {
		return movieDAO.selectById(movie_id);
	}

	@Override
	public void regist(FileManager fileManager,Movie movie) throws DMLException{
		
		String ext=fileManager.getExtend(movie.getRepImg().getOriginalFilename());
		movie.setPoster(ext);//확장자결정
		
		//db에 넣기 DAO에게 시키기
		movieDAO.insert(movie);
		//상품의 movie_id 를 이용해서 대표이미지명을 결정
		//대표이미지 업로드
		String basicImg=movie.getMovie_id()+"."+ext;
		fileManager.saveFile(fileManager.getSaveDir()+File.separator+basicImg,movie.getRepImg());
		
		
		
		//장르
		for(GenreList genre:movie.getGenreList()) {
			genre.setMovie_id(movie.getMovie_id());
			genreDAO.insert(genre);
		}
	}
	
	@Override
	public void update(FileManager fileManager,Movie movie) throws DMLException{
		
		String ext=fileManager.getExtend(movie.getRepImg().getOriginalFilename());
		movie.setPoster(ext);
		movieDAO.update(movie);
		
		String basicImg=movie.getMovie_id()+"."+ext;
		fileManager.saveFile(fileManager.getSaveDir()+File.separator+basicImg,movie.getRepImg());
		
		
		
		
	}

	@Override
	public void delete(int movie_id) throws DMLException{
		movieDAO.delete(movie_id);
		
	}

	@Override
	public Movie select(int movie_id) {
		
		return movieDAO.select(movie_id);
	}

	@Override
	public List selectByGenre(String genre_name) {
		
		return movieDAO.selectByGenre(genre_name);
	}

	@Override
	public List<?> getGenreList() {
		
		return movieDAO.getGenreList();
	}

	@Override
	public List<?> getBoxList() {
		
		return movieDAO.getBoxList();
	}

	@Override
	public Box getBoxPrice(int box_id) {

		return movieDAO.getBoxPrice(box_id);
	}

	@Override
	public int selectMovieCount(HashMap<Object, Object> hashmap) {
		
		return movieDAO.selectMovieCount(hashmap);
	}

	@Override
	public int deleteCheck(HashMap<Object, Object> hashMap) {
		
		return movieDAO.movieCheckDelete(hashMap);
	}


}
