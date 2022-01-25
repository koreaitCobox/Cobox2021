package com.koreait.cobox.client.controller.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.cobox.model.comments.service.CommentsService;
import com.koreait.cobox.model.common.PageMaker;
import com.koreait.cobox.model.common.Pager;
import com.koreait.cobox.model.domain.Box;
import com.koreait.cobox.model.domain.Comments;
import com.koreait.cobox.model.domain.Movie;
import com.koreait.cobox.model.domain.PSummary;
import com.koreait.cobox.model.domain.Schedule;
import com.koreait.cobox.model.domain.Snack;
import com.koreait.cobox.model.movie.repository.MovieDAO;
import com.koreait.cobox.model.movie.service.MovieService;
import com.koreait.cobox.model.movie.service.ScheduleService;
import com.koreait.cobox.model.movie.service.SnackService;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


@Controller
public class MainController {	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	@Autowired
	private ScheduleService scheduleService;
	@Autowired
	private MovieService movieService;
	@Autowired
	private SnackService snackService;
	@Autowired
	private MovieDAO movieDAO;
	@Autowired
	private Pager pager;
	@Autowired
	private CommentsService commentsService;
	
	
	/**
	 * @Method : main
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 사용자 메인
	 * @param request
	 * @param session
	 * @param model
	 * @return
	 */
	
	@RequestMapping(value="/")
	public ModelAndView main(HttpServletRequest request, ModelMap model, HttpSession session) {
		HashMap<Object,Object> params = new HashMap<Object,Object>();
	
		
		ModelAndView mav=new ModelAndView("/main");
		
		List movieList = movieService.selectAll();
		pager.init(request,movieList);
		mav.addObject("movieList",movieList);
		return mav;
		
	}
	
	/**
	 * @Method : getPayPage1
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 사용자 결제 페이지
	 * @param request
	 * @param session
	 * @param model
	 * @return
	 */
	@RequestMapping(value="/client/movie/payPage")
	public String getPayPage1(	@RequestParam(value="member_id", required=false, defaultValue = "") int member_id,
			HttpServletRequest request, ModelMap model,HttpSession session) {

			List<?>scheduleList = scheduleService.selectAllById(member_id);
			model.addAttribute("scheduleList",scheduleList);

			return "client/movie/payPage";
	}
	
	/**
	 * @Method : getPayPage
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : '결제하기' 버튼 클릭시 스케줄 insert
	 * @param member_id : 회원 일련번호
	 * @param box_id : 영화관 일련번호
	 * @param time_table_id : 영화 시간표
	 * @param movie_id : 영화 일련번호
	 * @param use_day : 사용일자
	 * @param total_price : 총 금액
	 * @param	 request
	 * @param response
	 * @param session
	 * @return
	 */
	
	@RequestMapping(value = "/client/movie/pay", method = RequestMethod.POST)
	public @ResponseBody int getPayPage(
			@RequestParam(value = "member_id", required = false, defaultValue = "") int member_id,
			@RequestParam(value = "box_id", required = false, defaultValue = "") int box_id,
			@RequestParam(value = "time_table_id", required = false, defaultValue = "") int time_table_id,
			@RequestParam(value = "movie_id", required = false, defaultValue = "") int movie_id,
			@RequestParam(value = "use_day", required = false, defaultValue = "") String use_day,
			@RequestParam(value = "total_price", required = false, defaultValue = "") int total_price,
			HttpServletRequest request, HttpServletResponse response, HttpSession session)
	{
		
		Schedule schedule = new Schedule();
		schedule.setBox_id(box_id);
		schedule.setMember_id(member_id);
		schedule.setTime_table_id(time_table_id);
		schedule.setMovie_id(movie_id);
		schedule.setTotal_price(total_price);
		schedule.setUse_day(use_day);
		
		int result = scheduleService.insert(schedule);
		
		return result;
	}
	

		/**
		 * @Method : insertPaySummary
		 * @Author : Suyeon Kim
		 * @Date : 2022. 01. 11.
		 * @Description : 최종결제 시 요약 테이블에 insert
		 * @param schedule_id : 스케줄 일련번호
		 * @param p_method_id : 스케줄 요약 일련번호
		 * @param total_price : 전체 가격
		 * @param request 
		 * @param response
		 * @param session
		 * @return
		 */
		@RequestMapping(value = "/client/movie/payfinal", method = RequestMethod.POST)
		public @ResponseBody void insertPaySummary(
				@RequestParam(value = "schedule_id", required = false, defaultValue = "") int schedule_id,
				@RequestParam(value = "p_method_id", required = false, defaultValue = "") int p_method_id,
				@RequestParam(value = "total_price", required = false, defaultValue = "") int total_price,
				HttpServletRequest request, HttpServletResponse response, HttpSession session)
		{
			PSummary psum = new PSummary();
			psum.setSchedule_id(schedule_id);
			psum.setP_method_id(p_method_id);
			psum.setTotal_price(total_price);

			scheduleService.insertP(psum);
				
		}
		
	
	/**
	 * @Method : list
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 페이지 init 시 영화목록 
	 * @param searchSelect : 검색 조건
	 * @param search : 검색어
	 * @param request 
	 * @param response
	 * @param session
	 * @return
	 */
	@RequestMapping(value = "/client/movie/list")
	public String list(@RequestParam(value="searchSelect", defaultValue="all") String searchSelect,
			@RequestParam(value = "search", required = false, defaultValue = "") String search,
	HttpServletRequest request, ModelMap model, HttpSession session) {
		
		System.out.println("searchSelect:" + searchSelect);
		System.out.println("search:" + search);
		try {
		
		HashMap<Object,Object> params = new HashMap<Object,Object>();
		 int pageSize=10; //디폴트 
		 int page =1;
		 
		 params.put("pageSize", pageSize);
		 params.put("page", page);
		 int tot=page * pageSize;
		 params.put("tot", tot);
		 params.put("searchSelect",searchSelect);
		 params.put("search",search);
		 
		 int totalCount = movieService.selectMovieCount(params);
		 int totalPage = totalCount / pageSize;
		 
		  if (totalCount > pageSize * totalPage) {
				totalPage++;
		  }

		 PageMaker pageMaker = new PageMaker(page, pageSize);
		 pageMaker.setTotalCount(totalCount);
		 
		 System.out.println(params);
		 
		 List<Movie> movieList = movieService.selectAll(params);
		 List<Snack> snackList = snackService.selectAll();
		 
		 model.addAttribute("pageMaker", pageMaker);
		 model.addAttribute("search",search);
		 model.addAttribute("searchSelect",searchSelect);
		 model.addAttribute("searchValues", params);
		 model.addAttribute("pageSize", pageSize);
		 model.addAttribute("page", page);
		 model.addAttribute("totalCount", totalCount);
		 model.addAttribute("movieList",movieList);
		 model.addAttribute("searchSelect",searchSelect);
		 model.addAttribute("searchValues",params);
		 model.addAttribute("snackList",snackList);
		
		} catch (NumberFormatException e) {
			// LOG.error(e.getMessage());
			
			e.printStackTrace();
		}
		
		
		 return "client/movie/movielist";
	}
	
	/**
	 * @Method : list
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 조건 검색 시 영화 목록
	 * @param selNum : 한 페이지 당 리스트 수
	 * @param pageSize : 한 페이지당 보이는 총 페이지 수  
	 * @param page : 현재 페이지
	 * @param request 
	 * @param response
	 * @param session
	 * @return
	 */
		@RequestMapping(value = "/client/movie/ajaxList", method=RequestMethod.POST)
		public @ResponseBody HashMap<Object,Object> list(@RequestParam(value="selNum",required=false, defaultValue = "10") String selNum,
				@RequestParam(value = "pageSize") int pageSize, @RequestParam(value = "page") int page,
				@RequestParam(value="searchSelect", defaultValue="all") String searchSelect,
				@RequestParam(value = "search", required = false, defaultValue = "") String search,
		HttpServletRequest request, ModelMap model, HttpSession session) {
			
			
			HashMap<Object,Object> params = new HashMap<Object,Object>();
			HashMap<Object,Object> resultMap = new HashMap<Object,Object>();
			
			
			 params.put("searchSelect", searchSelect);
			 params.put("search", search);
			 params.put("pageSize", pageSize);
			 params.put("page", page);
			 
			 
			 List<Movie> movieList = movieService.selectAll(params);
			 PageMaker pageMaker = new PageMaker(page,pageSize);
		
			 
			 resultMap.put("pageMaker",pageMaker);
			 resultMap.put("movieList",movieList);
			 resultMap.put("search",search);
			 resultMap.put("searchSelect",searchSelect);
			 resultMap.put("searchValues", params);
			 resultMap.put("page",page);
			 
			 
			
			 return resultMap;
		}


	
	/**
	 * @Method : detail
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 영화 목록 클릭 시 세부사항 
	 * @param movie_id : 영화 일련번호
	 * @param request 
	 * @param response
	 * @param session
	 * @return
	 */
	
	@RequestMapping(value = "/client/movie/detail", method = RequestMethod.GET)
	public ModelAndView detail(int movie_id, HttpServletRequest request) {
		
		logger.debug("movie_id"+movie_id);
		Movie movie=movieDAO.selectById(movie_id);
		
		List<Comments>commentsList = commentsService.selectAll(movie_id);
		ModelAndView mav=new ModelAndView();
			
		mav.addObject("movie",movie);
		mav.addObject("commentsList",commentsList);
		mav.setViewName("client/movie/moviedetail");
		return mav;
	}

/*	@RequestMapping(value="/client/movie/detail1",method=RequestMethod.POST)
	public String edit(Movie movie) {
		movieDAO.update(movie);
		
		return "redirect:/client/detail?movie_id="+movie.getMovie_id();
	}*/
	
	
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
	
	/**
	 * @Method : getBoxList
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 영화관 박스명 가져오기   
	 * @return
	 */
	@RequestMapping(value="/client/movie/getBoxList", method=RequestMethod.POST)
	public @ResponseBody HashMap<Object,Object> getBoxList(){
		
		HashMap<Object,Object> resultMap = new HashMap<Object,Object>();
		
		List<?>boxList=movieDAO.getBoxList();
		resultMap.put("boxList", boxList);
		
		return resultMap;
	}
	
	
	/**
	 * @Method : getBoxList
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 영화관 박스가격 가져오기 
	 * @param box_id 영화 일련번호 
	 * @return
	 */
	
	@RequestMapping(value="/client/movie/getBoxPrice", method=RequestMethod.POST)
	public @ResponseBody Box getBoxPrice(int box_id){
		
		logger.debug("box_id:" + box_id);
		Box box=movieDAO.getBoxPrice(box_id);
		
		return box;
	}
	
	/**
	 * @Method : getMovieById
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 11.
	 * @Description : 영화 한건 가져오기 
	 * @param box_id 영화 일련번호 
	 * @return
	 */
	@RequestMapping(value="/client/movie/getM", method=RequestMethod.POST)
	public @ResponseBody Movie getMovieById(@RequestParam(value = "movie_id") int movie_id){
		
		Movie movie=movieDAO.selectById(movie_id);
		return movie;
	}
	
	
	
}
