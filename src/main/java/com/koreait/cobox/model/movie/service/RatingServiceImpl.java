package com.koreait.cobox.model.movie.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.cobox.model.domain.Rating;
import com.koreait.cobox.model.theater.repository.RatingDAO;


@Service
public class RatingServiceImpl implements RatingService{

	@Autowired
	private RatingDAO ratingDAO;
	@Override
	public Rating selectAllById(int rating_id) {
		
		return ratingDAO.selectAllById(rating_id);
	}
	


}
