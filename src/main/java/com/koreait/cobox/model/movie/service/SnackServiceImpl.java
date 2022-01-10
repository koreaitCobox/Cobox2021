package com.koreait.cobox.model.movie.service;

import java.util.HashMap;
import java.util.List;
import java.io.File;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.koreait.cobox.exception.DMLException;
import com.koreait.cobox.model.common.FileManager;
import com.koreait.cobox.model.domain.Snack;
import com.koreait.cobox.model.movie.repository.SnackDAO;
@Service
public class SnackServiceImpl implements SnackService{
	private static final Logger logger=LoggerFactory.getLogger(SnackServiceImpl.class);
	@Autowired
	private SnackDAO snackDAO;

	//스낵 등록 
	@Override
	public void regist(FileManager fileManager, Snack snack) throws DMLException{
		
		String ext = FileManager.getExtend(snack.getRepImg().getOriginalFilename());
		snack.setFilename(ext); //확장자 설정
		
		snackDAO.insert(snack);
		
		String basicImg = snack.getSnack_id()+"."+ext;
		fileManager.saveFile(fileManager.getSaveDir()+File.separator+basicImg,snack.getRepImg());

	}
	//스낵 리스트 가져오기
	@Override
	public List<Snack> selectAll() {
		
		return snackDAO.selectAll();
	
	}
	//스낵 분류로 스낵 리스트 가져오기
	@Override
	public List<Snack> selectById(int topcategory_id) {
		
		return snackDAO.selectById(topcategory_id);
	}
	//체크된 스낵 삭제하기 
	@Override
	public int deleteCheck(FileManager fileManager, HashMap<Object, Object> hashMap) {
		// 해당 id 의 getOriginalFilename 이 path 다 
		//fileManager.deleteFile(path);
		
		
		return snackDAO.deleteCheckSnack(hashMap);
	}
	


}
