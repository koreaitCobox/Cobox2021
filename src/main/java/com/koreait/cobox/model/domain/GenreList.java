package com.koreait.cobox.model.domain;

import java.util.List;

public class GenreList {

	private int genre_list_id;
	private int movie_id;
	private String genre_list_name;
	
	private List<Movie> movie;

	
	public List<Movie> getMovie() {
		return movie;
	}
	public void setMovie(List<Movie> movie) {
		this.movie = movie;
	}
	public int getGenre_list_id() {
		return genre_list_id;
	}
	public void setGenre_list_id(int genre_list_id) {
		this.genre_list_id = genre_list_id;
	}
	public int getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}
	public String getGenre_list_name() {
		return genre_list_name;
	}
	public void setGenre_list_name(String genre_list_name) {
		this.genre_list_name = genre_list_name;
	}
	
}
