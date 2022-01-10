package com.koreait.cobox.model.movie.service;

import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.model.domain.PSummary;
import com.koreait.cobox.model.domain.Schedule;
import com.koreait.cobox.model.movie.repository.ScheduleDAO;

@Service
public class ScheduleServiceImpl implements ScheduleService{
	private static final Logger logger=LoggerFactory.getLogger(ScheduleServiceImpl.class);
	@Autowired
	private ScheduleDAO  scheduleDAO;
	
	@Override
	public int insert(Schedule schedule) throws DMLException{
		
		int result = scheduleDAO.insert(schedule);
		return result;
	}

	@Override
	public List<?> selectAllById(int member_id) {
		
		 return scheduleDAO.selectAllById(member_id);
	}

	@Override
	public void insertP(PSummary psum) {
		
		scheduleDAO.insertP(psum);
	}

}
