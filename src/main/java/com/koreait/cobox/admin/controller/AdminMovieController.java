package com.koreait.cobox.admin.controller;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletContextAware;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.exception.MovieRegistException;
import com.koreait.cobox.model.comments.service.CommentsService;
import com.koreait.cobox.model.common.FileManager;
import com.koreait.cobox.model.common.PageMaker;
import com.koreait.cobox.model.common.Pager;
import com.koreait.cobox.model.domain.Genre;
import com.koreait.cobox.model.domain.GenreList;
import com.koreait.cobox.model.domain.MessageData;
import com.koreait.cobox.model.domain.Movie;
import com.koreait.cobox.model.domain.Rating;
import com.koreait.cobox.model.domain.Snack;
import com.koreait.cobox.model.movie.repository.MovieDAO;
import com.koreait.cobox.model.movie.service.DumpService;
import com.koreait.cobox.model.movie.service.MovieService;
import com.koreait.cobox.model.movie.service.SnackService;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*관리자 모드에서 영화에 대한 요청 처리*/

@Controller
public class AdminMovieController implements ServletContextAware{
	private static final Logger logger=LoggerFactory.getLogger(AdminMovieController.class);
	@Autowired
	private MovieDAO movieDAO;
   @Autowired
   private MovieService movieService;
   @Autowired
   private DumpService dumpService;
   @Autowired
   private SnackService snackService;
   
   @Autowired
   private CommentsService commentsService;
   @Autowired
   private Pager pager; //페이징처리
   @Autowired
   private FileManager fileManager;
   
   //getRealpath()사용하기 위해
   private ServletContext servletContext;
   
   @Override
   public void setServletContext(ServletContext servletContext) {
	   this.servletContext = servletContext;
	   fileManager.setSaveDir(servletContext.getRealPath(fileManager.getSaveDir()));
	   
	   logger.debug(fileManager.getSaveDir());
   }
   
 
   //영화목록 가져오기
/*   @RequestMapping(value="/admin/movie/list",method=RequestMethod.GET)
   public ModelAndView getMovieList(HttpServletRequest request) {
      
      ModelAndView mav=new ModelAndView("admin/movie/movie_list");
		 
	  List movieList = movieService.selectAll();
      pager.init(request,movieList);
      
      mav.addObject("pager",pager);
	
	 return mav;
   }*/
   
   
   //영화목록 가져오기
   @RequestMapping(value="/admin/movie/list",method=RequestMethod.GET)
   public String getMovieList(@RequestParam(value="selNum", required= false, defaultValue = "10")String selNum, 
		   HttpServletRequest request, ModelMap model, HttpSession session) {
      System.out.println("selNum :" + selNum);
	  HashMap<Object,Object> params = new HashMap<Object, Object>();
	   
	   int pageSize = Integer.parseInt(selNum);
	   int page=1;
     
	   params.put("pageSize", pageSize);
	   params.put("page", page);
	   
	   
	   
	  List<Movie> movieList = movieService.selectAll();
      
      
      int totalCount = movieService.selectMovieCount(params);
      int totalPage = totalCount / pageSize;
      if(totalCount > pageSize * totalPage) {
    	  totalPage++;
      }

      PageMaker pageMaker = new PageMaker(page,pageSize);
      pageMaker.setTotalCount(totalCount);
      
      model.addAttribute("selNum",pageSize);
      model.addAttribute("totalCount", totalCount);
      model.addAttribute("pageSize", pageSize);
      model.addAttribute("page", page);
      model.addAttribute("totalPage", totalPage);
      model.addAttribute("pageMaker", pageMaker);
      
      model.addAttribute("movieList",movieList);
      
      
	 return "admin/movie/movie_list";
   }
   
   
   
   @RequestMapping(value="/admin/movie/ajaxMovieList", method= RequestMethod.POST)
   public @ResponseBody HashMap<Object,Object> ajaxMovieList(
		   @RequestParam(value = "pageSize") int pageSize, @RequestParam(value = "page") int page,
		   HttpServletRequest request, HttpServletResponse response, ModelMap model, HttpSession session){
	   
	   HashMap<Object, Object> resultMap = new HashMap<Object, Object>();
	   HashMap<Object,Object> params = new HashMap<Object,Object>();
	   System.out.println(pageSize);
	   System.out.println(page);
	   params.put("pageSize", pageSize);
	   params.put("page", page);
	   int tot = page * pageSize;
	   params.put("tot", tot); // mysql 에서  as C limit (1 * 10) 이 쿼리가 안먹힌다.. 그래서 곱한 수를 여기서 넘겨준다.
	   int totalCount = movieService.selectMovieCount(params);
	   int totalPage = totalCount / pageSize;
	   if (totalCount > pageSize * totalPage) {
			totalPage++;
		}
	   
	   PageMaker pageMaker = new PageMaker(page, pageSize);
	   pageMaker.setTotalCount(totalCount);
	   
	   List<Movie> movieList = movieService.selectAll(params);
	   
	    resultMap.put("pageMaker", pageMaker);
		resultMap.put("pageSize", pageSize);
		resultMap.put("page", page);
		resultMap.put("totalCount", totalCount);
		resultMap.put("movieList", movieList);

	   
	   
	   return resultMap;
   }
   
   //  regist_form 뿌려주기
   @RequestMapping(value="/admin/movie/registform")
   public String registForm() {
	
      return "admin/movie/regist_form";
   }
  //장르 가져와서 뿌려주기
   @RequestMapping(value="/admin/movie/genre", method=RequestMethod.POST)
   public @ResponseBody HashMap<Object,Object>genreList(){
	   
	   HashMap<Object,Object> resultMap = new HashMap<Object,Object>();
	   
	   List<?> genreList =(List<?>) movieDAO.getGenreList();
	   resultMap.put("genreList", genreList);
	   return resultMap; 
   } 
   
   //영화 상세
   @RequestMapping(value="/admin/movie/detail",method=RequestMethod.GET)
   public ModelAndView select(int movie_id) {
	   logger.debug("movie_id"+movie_id);
	   Movie movie=movieDAO.selectById(movie_id);
	   
	   ModelAndView mav=new ModelAndView();
	   mav.addObject("movie",movie);
	   mav.setViewName("admin/movie/detail");
	   
	   return mav;
   }
   
   
   //영화등록
   @RequestMapping(value="/admin/movie/regist",method=RequestMethod.POST, produces="text/html;charset=utf8")
   @ResponseBody
   public String registMovie(Movie movie) {
	  logger.debug("영화번호 :"+movie.getMovie_id());
	   logger.debug("영화제목 :"+movie.getMovie_name());
	   logger.debug("등급연령 :"+movie.getRating_id());
	   logger.debug("감독 :"+movie.getDirector());
	   logger.debug("배우 :"+movie.getActor());
	   logger.debug("개봉일 :"+movie.getPlaydate());
	   logger.debug("줄거리 :"+movie.getStory());
	   
	   
	   for(GenreList genre:movie.getGenreList()) {
		   logger.debug("장르 :" + genre.getGenre_list_name());
	   }
	  
	   movieService.regist(fileManager, movie); //영화등록 서비스에게 요청
	  
	   
	   StringBuilder sb=new StringBuilder();
	   sb.append("{");
	   sb.append("\"result\":1,");
	   sb.append("\"msg\":\"영화 등록성공\"");
	   sb.append("}");
	
	   
	  return sb.toString();
   }
   
   //영화수정
   @RequestMapping(value="/admin/movie/edit",method=RequestMethod.POST)
   public String edit(Movie movie) {
	   
	   movieService.update(fileManager,movie);
	   return "redirect:/admin/detail?movie_id="+movie.getMovie_id();
   }
   
   //영화삭제
   @RequestMapping(value="/admin/movie/delete",method=RequestMethod.POST)
   public String delete(int movie_id) {
	   
	   movieService.delete(movie_id);
	  // commentsService.delete(movie_id);
	   
	   return "redirect:/admin/movie/list";
   }

   
   //엑셀에 의한 상품 등록 요청 처리
   @RequestMapping(value="/admin/movie/excel/regist",method=RequestMethod.POST)
	@ResponseBody
	public MessageData registByExcel(HttpServletRequest request,MultipartFile dump) {
		String path=fileManager.getSaveDir()+File.separator+dump.getOriginalFilename();//저장할 파일명
		fileManager.saveFile(path, dump);
		
		MessageData messageData = new MessageData();
		messageData.setResultCode(1);
		messageData.setMsg("엑셀등록 성공");
		
		//엑셀 읽어서 데이터베이스에 넣기
		dumpService.regist(path);
		
		
		return messageData;
   }
	/**
	 * 
	 * @MethodName : CheckDelete
	 * @Author : Suyeon Kim
	 * @Date : 2022. 01. 07.
	 * @Description : 체크한 항목 삭제 / 한 목록 삭제 
	 * @param HttpServletRequest
	 * @param HttpServletResponse
	 * @param String
	 * @param ModelMap
	 * @param HttpSession
	 * @param checkedSeqs  
	 * @return
	 */
   @RequestMapping(value="/admin/movie/CheckDelete", method=RequestMethod.POST)
   public @ResponseBody String CheckDelete(	@RequestParam(value="checkedSeqs")String checkedSeqs,
		   ModelMap model, HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		    
	   	   HashMap<Object,Object> params = new HashMap<Object,Object>();
		  
	   	   List<String>seqs = Arrays.asList(checkedSeqs.split(",")); // 체크한 체크박스 movie_id를 list에 담기
	       params.put("seqs", seqs);

		   int result = 0;
		   if(seqs.size() > 0) {
			   result = movieService.deleteCheck(params);
		   }
		   
			if (result > 0) {
				return "true"; //삭제 완료 후 true 리턴
			}
	   
		   return "false"; //삭제 실패시 false 리턴 
   }
   
   
   
   //위의 메서드중 하나라도 예외가 발생하면 핸들러 동작
   @ExceptionHandler(MovieRegistException.class)
   @ResponseBody
   public String handleException(MovieRegistException e) {
	   StringBuilder sb=new StringBuilder();
	   sb.append("{");
	   sb.append("\"result\":0");
	   sb.append("\"msg\":\""+e.getMessage()+"\"");
	   sb.append("}");
	   return sb.toString();
   }
   
   
   

   
     
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
}