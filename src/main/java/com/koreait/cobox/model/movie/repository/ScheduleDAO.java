package com.koreait.cobox.model.movie.repository;

import java.util.List;

import com.koreait.cobox.model.domain.PSummary;
import com.koreait.cobox.model.domain.Schedule;

public interface ScheduleDAO {
	public int insert(Schedule schedule);
	public void insertP(PSummary psum);
	public List<?> selectAllById(int member_id);
}
