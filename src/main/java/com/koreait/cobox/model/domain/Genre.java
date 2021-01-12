package com.koreait.cobox.model.domain;

import java.util.List;

import lombok.Data;
@Data
public class Genre {
	private int genre_id;
	private int movie_id;
	private String genre_name;
	
	private List<Movie> movie;
	
	
}
