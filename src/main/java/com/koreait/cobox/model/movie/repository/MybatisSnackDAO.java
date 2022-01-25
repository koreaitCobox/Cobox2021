package com.koreait.cobox.model.movie.repository;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.model.domain.Snack;
@Repository
public class MybatisSnackDAO implements SnackDAO{
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	@Override
	public void insert(Snack snack) {
		int result = sqlSessionTemplate.insert("Snack.insert",snack);
		if(result == 0 ) {
			throw new DMLException("스낵 등록 실패");
		}
		
	}
	@Override
	public List<Snack> selectAll() {
	
		return sqlSessionTemplate.selectList("Snack.selectAll");
	}
	@Override
	public List<Snack> selectById(int topcategory_id) {
		 
		return sqlSessionTemplate.selectList("Snack.selectById",topcategory_id);
	}
	@Override
	public int deleteCheckSnack(HashMap<Object, Object> hashMap) {
		
		return sqlSessionTemplate.delete("Snack.deleteCheckSnack",hashMap);
	}
	@Override
	public int updateSnackused(HashMap<Object, Object> hashMap) {
		
		return sqlSessionTemplate.update("Snack.updateSnack", hashMap);
		
	}
	@Override
	public int insertSnackStat(HashMap<Object, Object> hashMap) {
		
		return sqlSessionTemplate.insert("Snack.insertSnackStat",hashMap);
		
	}
	@Override
	public int updateSnackCnt(HashMap<Object, Object> hashMap) {
		
		return sqlSessionTemplate.update("Snack.updateSnackCnt",hashMap);
	}
	@Override
	public List selectSnackStat() {
		
		return sqlSessionTemplate.selectList("Snack.selectSnackStat");
	}

}
