package com.koreait.cobox.model.movie.service;

import java.io.InputStream;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.cobox.model.common.FileManager;
import com.koreait.cobox.model.domain.Genre;
import com.koreait.cobox.model.domain.Movie;
import com.koreait.cobox.model.excel.MovieConverter;
import com.koreait.cobox.model.movie.repository.GenreDAO;
import com.koreait.cobox.model.movie.repository.MovieDAO;

@Service
public class DumpServiceImpl implements DumpService{
	private static final Logger logger=LoggerFactory.getLogger(DumpService.class);
	@Autowired
	private MovieConverter movieConverter;
	@Autowired
	private MovieDAO movieDAO;
	@Autowired
	private GenreDAO genreDAO;
	@Override
	public void regist(String path) {
		List<Movie>movieList = movieConverter.convertFormFile(path);
		logger.debug("엑셀파일을 분석해 나온 결과 리스트"+movieList.size());
		
		for(int i=0;i<movieList.size();i++) {
			Movie movie=movieList.get(i);
			movieDAO.insert(movie);
			
			
			//장르 넣기
			for(Genre genre : movie.getGenreList()) {
				genre.setMovie_id(movie.getMovie_id());
				genreDAO.insert(genre);
			}
			
			movie.setPoster(movie.getMovie_id()+"."+FileManager.getExtend(movie.getPoster()));
			movieDAO.update(movie);
			
		}
	}

}
