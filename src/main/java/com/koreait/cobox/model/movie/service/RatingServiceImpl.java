package com.koreait.cobox.model.movie.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.cobox.model.movie.repository.RatingDAO;
@Service
public class RatingServiceImpl implements RatingService{
	@Autowired
	private RatingDAO ratingDAO;

	@Override
	public List selectRating() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public RatingDAO select(int rating_id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void insert(RatingDAO rating) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void update(RatingDAO rating) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void delete(int rating_id) {
		// TODO Auto-generated method stub
		
	}
	
	

}
