package com.koreait.cobox.model.movie.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.model.domain.PSummary;
import com.koreait.cobox.model.domain.Schedule;

@Repository
public class MybatisScheduleDAO implements ScheduleDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	
	
	@Override
	public int insert(Schedule schedule) {
		int result = sqlSessionTemplate.insert("Schedule.insert",schedule);
		if(result == 0) {
			throw new DMLException("회원이 선택한 스케줄 등록 실패");
		}
		return result;
	}



	@Override
	public List<?> selectAllById(int member_id) {
		
		return sqlSessionTemplate.selectList("Schedule.selectAllById",member_id);
	}



	@Override
	public void insertP(PSummary psum) {
		sqlSessionTemplate.insert("Schedule.insertP",psum);
		
	}

}
