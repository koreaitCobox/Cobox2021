package com.koreait.cobox.model.movie.service;

import java.util.HashMap;
import java.util.List;

import com.koreait.cobox.model.common.FileManager;
import com.koreait.cobox.model.domain.Snack;

public interface SnackService {

	// 스낵 등록
	public void regist(FileManager fileManger, Snack snack);
	//스낵 리스트 가져오기
	public List<Snack> selectAll();
	//스낵 분류 리스트 가져오기
	public List<Snack> selectById(int topcategory_id);
	//체크된 스낵 삭제하기
	int deleteCheck(HashMap<Object,Object>hashMap);
	//스낵 사용 여부 
	public int updateSnackused(HashMap<Object,Object> params);
	//스낵 통계
	public int insertSnackStat(HashMap<Object,Object>params);
	//스낵 통계 update
	public int updateSnackCnt(HashMap<Object,Object>params);
	//스낵 통계 가져오기 
	public List selectSnackStat();
}
