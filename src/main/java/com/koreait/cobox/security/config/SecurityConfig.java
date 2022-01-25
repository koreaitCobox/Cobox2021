package com.koreait.cobox.security.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;


@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{

	@Override
	public void configure(WebSecurity web) throws Exception {

		/* 스프링 시큐리티의 필터 연결을 설정하기 위한 오버라이딩. 
		 * 예외가 웹접근 URL을 설정한다.
		 * ACL(Access Control List - 접근 제어 목록)의 예외 URL을 설정.
		 */ 
		web.ignoring().antMatchers("/favicon.ico");

	}
	@Override
    protected void configure(HttpSecurity http) throws Exception {
        // 인터셉터로 요청을 안전하게 보호하는 방법을 설정하기 위한 오버라이딩이다.
        //super.configure(http); // 모든 url 막고있음
        
      /*  http.authorizeRequests()
        						.antMatchers("/main").permitAll()
        						.antMatchers("/admin/movie/**").access("hasRole('ROLE_ADMIN')")
        						.antMatchers("/admin/snack/**").access("hasRole('ROLE_ADMIN')");*/
        
		  // 1. ACL 설정
		 http.authorizeRequests()
		 						/*.antMatchers("/admin/movie/**","/admin/snack/**").hasAuthority("ROLE_ADMIN")//특정 권한을 가진 사용자만 접근 가능
*/		 						.anyRequest().permitAll(); // 접근을 전부 허용한다.
		
		 // Temporary for Testing 임시로 csrf 설정 막기
		 http.csrf().disable();
	
		 // 2. 로그인 설정
		   /* http
		        .formLogin()
		        .loginPage("/admin") 	// 로그인 페이지 url :: 사용자 정의 로그인 페이지
		        .loginProcessingUrl("/main")  // view form의 action과 맞아야함 :: 사용자 이름과 암호를 제출할 URL
		        .failureUrl("/client/movie/list") // 로그인 실패시 redirect :: 로그인 실패 후 방문 페이지
		        .defaultSuccessUrl("/admin/movie/list", true) // 로그인 성공시 :: 성공적인 로그인 후 랜딩 페이지
		        .usernameParameter("email")  // 로그인 요청시 id용 파라미터 (메소드 이름이 usernameParameter로 무조건 써야하지만, 파라미터는 email이든 id이든 name이든 상관없다.)
		        .passwordParameter("password");	// 로그인 요청시 password용 파라미터
		 */
		 
		 // 3. 로그아웃 설정
		    /*http
		        .logout()
		        .logoutRequestMatcher(new AntPathRequestMatcher("/admin"))
		        .logoutSuccessUrl("/admin") // 로그아웃 성공시
		        .invalidateHttpSession(true);*/
		 
    }
	
	@Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        // 사용자 세부 서비스를 설정하기 위한 오버라이딩이다.
        super.configure(auth);
    }
	
	
}
