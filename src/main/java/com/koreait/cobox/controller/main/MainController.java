package com.koreait.cobox.controller.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.cobox.model.domain.Movie;
import com.koreait.cobox.model.movie.repository.MovieDAO;
import com.koreait.cobox.model.movie.service.MovieService;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Controller
public class MainController {	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	@Autowired
	private MovieService movieService;
	@Autowired
	private MovieDAO movieDAO;
	
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String main() {
		
		return "main";
	}
	
	
	
	@RequestMapping(value = "/client/movie/reservation", method = RequestMethod.GET)
	public String reservation() {
		
		return "client/movie/reservation";
	}
	
	@RequestMapping(value = "/client/movie/reservation2", method = RequestMethod.GET)
	public String reservation2() {
		
		return "client/movie/reservation2";
	}
	@RequestMapping(value = "/client/movie/reservation3", method = RequestMethod.GET)
	public String reservation3() {
		
		return "client/movie/reservation3";
	}
	//영화목록
	
	@RequestMapping(value = "/client/movie/list", method = RequestMethod.GET)
	public ModelAndView list() {
		 ModelAndView mav=new ModelAndView("client/movie/movielist");
		  List movieList = movieService.selectAll();
		  mav.addObject("movieList",movieList);
		 return mav;
	}
	
	
	//영화 상세정보
	
	@RequestMapping(value = "/client/movie/detail", method = RequestMethod.GET)
	public ModelAndView detail(int movie_id) {
		logger.debug("movie_id"+movie_id);
		Movie movie=movieDAO.selectById(movie_id);
		
		ModelAndView mav=new ModelAndView();
		mav.addObject("movie",movie);
		mav.setViewName("client/movie/moviedetail");
		
		return mav;
	}
	
	@RequestMapping(value="/client/movie/detail1",method=RequestMethod.POST)
	public String edit(Movie movie) {
		movieDAO.update(movie);
		return "redirect:/client/detail?movie_id="+movie.getMovie_id();
	}
	
	
	@RequestMapping(value = "/client/movie/snack", method = RequestMethod.GET)
	public String snack() {
		
		return "client/movie/snack";
	}
	
	@RequestMapping(value = "/client/movie/notice", method = RequestMethod.GET)
	public String notice() {
		
		return "client/movie/notice";
	}
	@RequestMapping(value = "/client/movie/noticedetail", method = RequestMethod.GET)
	public String noticedetail() {
		
		return "client/movie/noticedetail";
	}
}
