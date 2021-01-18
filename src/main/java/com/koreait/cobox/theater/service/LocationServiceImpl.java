package com.koreait.cobox.theater.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.koreait.cobox.model.theater.repository.LocationDAO;
@Service
public class LocationServiceImpl implements LocationService{
	@Autowired
	private LocationDAO locationDAO;
	
	@Override
	public List selectAll() {
		
		return locationDAO.selectAll();
	}

}
