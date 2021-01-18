package com.koreait.cobox.model.member.service;

import java.util.List;


import com.koreait.cobox.model.domain.Member;

public interface MemberService {
	public List selectAll();//모든 회원리스트 불러오기
	public Member select(Member member); //회원1명 불러오기
	public void insert(Member member);//회원등록
	public void update(Member member); //회원정보수정
	public void delete(Member member); //회원정보삭제
	
	public int idChk(Member member);//회원 아이디체크
	public int passChk(Member member);//회원 비밀번호체크
}
