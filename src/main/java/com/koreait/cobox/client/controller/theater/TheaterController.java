package com.koreait.cobox.client.controller.theater;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.koreait.cobox.model.domain.Theater;
import com.koreait.cobox.theater.service.TheaterService;



@Controller
public class TheaterController {
private static final Logger logger=LoggerFactory.getLogger(TheaterController.class);
	@Autowired	
	private TheaterService theaterService;

	@RequestMapping(value="/client/movie/theater",method=RequestMethod.GET)
	@ResponseBody
	public List getTheaterList(int location_id) {
		List<Theater>theaterList = theaterService.selectAllById(location_id);
		return theaterList; 
	}
	
//	@RequestMapping(value="/client/movie/theater",method=RequestMethod.GET, produces="test/html;charset=utf8")
//	@ResponseBody
//	public List getTheater(int location_id) {
//		logger.debug("location_id"+location_id);
//		List<Theater>theaterList = theaterService.selectAllById(location_id);
//		//json으로 리스트 보내기
//		
//		
////		StringBuilder sb=new StringBuilder();
////		sb.append("{");
////		sb.append("\"theaterList\" : [");
////		for(int i=0;i<theaterList.size();i++) {
////			Theater theater=theaterList.get(i);
////		
////		sb.append("{");
////		sb.append("\"theater_id\":"+theater.getTheater_id()+",");
////		sb.append("\"location_id\":"+theater.getLocation_id()+",");
////		sb.append("\"theater_name\":\""+theater.getTheater_name()+"\"");
////		sb.append("},");
////		        
////		if(i<theaterList.size()-1) {
////		sb.append("},");
////		}else {
////		sb.append("}");
////		}
////		}
////		sb.append("]");
////		sb.append("}");
//		
//		return sb.toString;
//	}
}








