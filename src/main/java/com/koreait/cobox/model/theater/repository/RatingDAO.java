package com.koreait.cobox.model.theater.repository;

import com.koreait.cobox.model.domain.Rating;

public interface RatingDAO {
	public Rating selectAllById(int rating_id);
}
