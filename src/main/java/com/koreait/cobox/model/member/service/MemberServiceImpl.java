package com.koreait.cobox.model.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.koreait.cobox.exception.MailSendException;
import com.koreait.cobox.exception.MemberNotFoundException;
import com.koreait.cobox.exception.MemberRegistException;
import com.koreait.cobox.model.common.MailSender;
import com.koreait.cobox.model.common.SecureManager;
import com.koreait.cobox.model.domain.Member;
import com.koreait.cobox.model.member.repository.MemberDAO;
import com.koreait.cobox.model.member.repository.MybatisMemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;

	private MybatisMemberDAO mybatisMemberDAO;

	// 메일발송 객체
	@Autowired
	private MailSender mailSender;

	// 암호화 객체
	@Autowired
	private SecureManager secureManager;

	@Override
	public List selectAll() {
		// 회원 전부를 불러오는 메서드 필요한가??
		return null;
	}

	@Override
	public Member select(Member member) throws MemberNotFoundException {
		// 유저가 전송한 파라미터비번을 해시값으로 변환하여 아래의 메서드 호출
		String hash = secureManager.getSecureData(member.getPassword());
		member.setPassword(hash); // VO에 해시값 대입!!
		Member obj = memberDAO.select(member);
		return obj;
	}
	
	@Override
	public void insert(Member member) throws MemberRegistException, MailSendException {

		// 암호화 처리
		String secureData = secureManager.getSecureData(member.getPassword());
		member.setPassword(secureData); // 변환시켜 다시 VO에 대입

		memberDAO.insert(member);
	}

	@Override
	public void update(Member member) throws MemberRegistException {
		String secureData = secureManager.getSecureData(member.getPassword());// 비밀번호 암호화
		member.setPassword(secureData); // 변환시켜 다시 VO에 대입
		memberDAO.update(member);

	}

	@Override
	public void delete(Member member) {

		memberDAO.delete(member);

	}
	

	@Override
	public int idChk(Member member) throws MemberNotFoundException {
		int result = memberDAO.idChk(member);
		return result;
	}

	@Override
	public int passChk(Member member) {
		// TODO Auto-generated method stub
		return 0;
	}

}
