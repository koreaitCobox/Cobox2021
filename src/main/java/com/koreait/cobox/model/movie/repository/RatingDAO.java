package com.koreait.cobox.model.movie.repository;

import java.util.List;

import com.koreait.cobox.model.domain.Rating;



public interface RatingDAO {

	public List selectAll();
	public List selectById(int movie_id); 
	public Rating select(int movie_id);
	public void insert(Rating rating);
	public void update(Rating rating);
	public void delete(int rating_id);
}
