package com.koreait.cobox.model.domain;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Movie {
	
	private int movie_id;
	private String movie_name;
	private  int rating_id;
	private  String director;
	private  String actor;
	private  String release;
	private  String story;
	private String poster;//movie_id.png
	
	//이미지 처리
	private MultipartFile repImg;
	
	
	//insert 
	private Genre[] genre;
	//private String rating;
	
	//rating 의 name값가져오기
	private Rating rating;
	
	//조인
	private List<Genre> genreList;
	//private List<Comments> commentsList;
	
	//영화 한건을 가지고 왔을때 한건에 맞는 코멘트리스트를 가지고온다//
	//인서트 : 세션에 멤버아이디가 담겨져있으면 등록-> 멤버테이블에서 멤버 아이디에 맞는 mid를 가져온다
	

	
	
	
	
	
	

	
	



	
}
