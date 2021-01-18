package com.koreait.cobox.client.controller.movie;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.cobox.model.domain.Genre;
import com.koreait.cobox.model.domain.Movie;
import com.koreait.cobox.model.movie.repository.MovieDAO;
import com.koreait.cobox.model.movie.service.GenreService;
import com.koreait.cobox.model.movie.service.MovieService;

@Controller
public class GenreController {
	@Autowired
	private static final Logger logger = LoggerFactory.getLogger(GenreController.class);
	@Autowired
	private MovieService movieService;
	@Autowired
	private GenreService genreService;
	@Autowired
	private MovieDAO movieDAO;
	//장르_name에 맞는 movie_id 가져오기
	@RequestMapping(value="/client/movie/genremovie",method=RequestMethod.GET)
	@ResponseBody
	public List getGenreMovieList(String genre_name) {
		List<Genre>genreMovieList=genreService.selectByGenre(genre_name);
		logger.debug("genre_name은" + genre_name);
		
		return genreMovieList;
		
	}
	//genre_name에 맞는 movie_id에 대한 영화정보
	@RequestMapping(value="/client/movie/moviebygenre",method=RequestMethod.GET)
	public ModelAndView getMovieByGenre(int movie_id) {
		logger.debug("movie_id는"+movie_id);
		Movie movie=movieDAO.selectById(movie_id);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("movie",movie);
		mav.setViewName("client/movie/moviebygenre");
		
		return mav;
	}


}
