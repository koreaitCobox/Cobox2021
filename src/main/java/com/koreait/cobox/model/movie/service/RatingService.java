package com.koreait.cobox.model.movie.service;

import com.koreait.cobox.model.domain.Rating;

public interface RatingService {

	public Rating selectAllById(int rating_id);
	
}
