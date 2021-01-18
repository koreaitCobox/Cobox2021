package com.koreait.cobox.model.member.repository;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.koreait.cobox.exception.MemberDeleteException;
import com.koreait.cobox.exception.MemberEditException;
import com.koreait.cobox.exception.MemberNotFoundException;
import com.koreait.cobox.exception.MemberRegistException;
import com.koreait.cobox.model.domain.Member;

@Repository
public class MybatisMemberDAO implements MemberDAO {
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public List selectAll() {
		return null;
	}

	@Override
	public Member select(Member member) throws MemberNotFoundException {
		Member obj = sqlSessionTemplate.selectOne("Member.select", member); //여기서 나올수 있는 결과  selectOne 을 써서 에러가 난데요 
		if (obj == null) {// 가입되지 않은 정보로 로그인을 하려고 하면
			throw new MemberNotFoundException("가입 된 정보가 없습니다.\n 회원가입을 먼저 진행해주세요.");
		}
		return obj;
	}

	@Override
	public void insert(Member member) throws MemberRegistException {
		int result = sqlSessionTemplate.insert("Member.insert", member);
		if (result == 0) {// 회원가입 중 옳지 않은 정보를 입력하면
			throw new MemberRegistException("회원가입에 실패하였습니다.");
		}
	}

	@Override
	public void update(Member member) throws MemberEditException {
		int result = sqlSessionTemplate.update("Member.update", member);
		if (result != 1) {// 회원수정중에 정보가 다 채워진게 아니라면
			throw new MemberRegistException("올바르지 않은 회원정보입니다.\n 다시 입력해주세요.");
		}
	}

	@Override
	public void delete(Member member) throws MemberDeleteException {
		int result = sqlSessionTemplate.delete("Member.delete", member);
		if (result == 0) {// 회원가입 중 옳지 않은 정보를 입력하면
			throw new MemberRegistException("회원탈퇴에 실패했습니다.\n 아이디와 비밀번호를 확인해주세요.");
		}
	}

	//아이디 중복체크
	@Override
	public int idChk(Member member) throws MemberNotFoundException {
		int result = sqlSessionTemplate.selectOne("memberMapper.idChk", member);
		return result;
	}

	@Override
	public int passChk(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

}
