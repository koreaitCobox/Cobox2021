package com.koreait.cobox.theater.service;

import java.util.List;

public interface TheaterService {
	public List selectAll();
	public List selectAllById(int location_id);
}
