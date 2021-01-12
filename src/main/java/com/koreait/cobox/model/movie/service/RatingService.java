package com.koreait.cobox.model.movie.service;

import java.util.List;

import com.koreait.cobox.model.movie.repository.RatingDAO;

public interface RatingService {
	
	public List selectRating();
	public RatingDAO select(int rating_id);
	public void insert(RatingDAO rating);
	public void update(RatingDAO rating);
	public void delete(int rating_id);
}
