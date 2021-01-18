package com.koreait.cobox.model.theater.repository;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
@Repository
public class MybatisTheaterDAO implements TheaterDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	@Override
	public List selectAll() {
		
		return null;
	}

	@Override
	public List selectAllById(int location_id) {
		
		return sqlSessionTemplate.selectList("Theater.selectAllById",location_id);
	}

}
