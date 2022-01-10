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
	private  String playdate;
	private  String story;
	private String poster;//movie_id.png
	
	
	//�씠誘몄� 泥섎━
	private MultipartFile repImg;
	
	
	//insert 
	private GenreList[] genre;
	//private String rating;
	
	//rating �쓽 name媛믨��졇�삤湲�
	private Rating rating;
	
	//議곗씤
	private List<GenreList> genreList;
	//private List<Comments> commentsList;

	public int getMovie_id() {
		return movie_id;
	}

	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}

	public String getMovie_name() {
		return movie_name;
	}

	public void setMovie_name(String movie_name) {
		this.movie_name = movie_name;
	}

	public int getRating_id() {
		return rating_id;
	}

	public void setRating_id(int rating_id) {
		this.rating_id = rating_id;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getActor() {
		return actor;
	}

	public void setActor(String actor) {
		this.actor = actor;
	}

	public String getPlaydate() {
		return playdate;
	}

	public void setPlaydate(String playdate) {
		this.playdate = playdate;
	}

	public String getStory() {
		return story;
	}

	public void setStory(String story) {
		this.story = story;
	}

	public String getPoster() {
		return poster;
	}

	public void setPoster(String poster) {
		this.poster = poster;
	}

	public MultipartFile getRepImg() {
		return repImg;
	}

	public void setRepImg(MultipartFile repImg) {
		this.repImg = repImg;
	}

	public GenreList[] getGenre() {
		return genre;
	}

	public void setGenre(GenreList[] genre) {
		this.genre = genre;
	}

	public Rating getRating() {
		return rating;
	}

	public void setRating(Rating rating) {
		this.rating = rating;
	}

	public List<GenreList> getGenreList() {
		return genreList;
	}

	public void setGenreList(List<GenreList> genreList) {
		this.genreList = genreList;
	}
	
	

	
	//�쁺�솕 �븳嫄댁쓣 媛�吏�怨� �솕�쓣�븣 �븳嫄댁뿉 留욌뒗 肄붾찘�듃由ъ뒪�듃瑜� 媛�吏�怨좎삩�떎//
	//�씤�꽌�듃 : �꽭�뀡�뿉 硫ㅻ쾭�븘�씠�뵒媛� �떞寃⑥졇�엳�쑝硫� �벑濡�-> 硫ㅻ쾭�뀒�씠釉붿뿉�꽌 硫ㅻ쾭 �븘�씠�뵒�뿉 留욌뒗 mid瑜� 媛��졇�삩�떎
	

	
	
	
	
	
	

	
	



	
}
