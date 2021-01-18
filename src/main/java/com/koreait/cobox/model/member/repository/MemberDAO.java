package com.koreait.cobox.model.member.repository;

import java.util.List;

import com.koreait.cobox.model.domain.Member;

public interface MemberDAO {
	public List selectAll();//모든 회원가져오기
	public Member select(Member member); //회원1명 가져오기
	public void insert(Member member);//회원등록
	public void update(Member member); //회원정보 수정
	public void delete(Member member); //회원탈퇴
	
	public int idChk(Member member);//아이디 중복체크
	public int passChk(Member member);//패스워드 중복체크
	
}
