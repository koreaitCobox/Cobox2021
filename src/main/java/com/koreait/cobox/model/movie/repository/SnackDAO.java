package com.koreait.cobox.model.movie.repository;

import java.util.HashMap;
import java.util.List;

import com.koreait.cobox.model.domain.Snack;

public interface SnackDAO {
	public void insert(Snack snack);
	public List<Snack> selectAll();
	public List<Snack> selectById(int topcategory_id);
	public int deleteCheckSnack(HashMap<Object,Object>hashMap);
}
