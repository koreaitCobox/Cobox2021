package com.koreait.cobox.model.movie.service;


import java.util.HashMap;
import java.util.List;

import com.koreait.cobox.model.domain.PSummary;
import com.koreait.cobox.model.domain.Schedule;

public interface ScheduleService {
	int insert(Schedule schedule);
	void insertP(PSummary psum);
	List<?>selectAllById(int member_id);
	
}
