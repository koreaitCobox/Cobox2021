package com.koreait.cobox.model.domain;

public class Schedule {

	private int schedule_id; 
	private int member_id;
	private int box_id;
	private int time_table_id;
	private int movie_id;
	private String use_day;
	private int total_price;
	
	public int getSchedule_id() {
		return schedule_id;
	}
	public void setSchedule_id(int schedule_id) {
		this.schedule_id = schedule_id;
	}
	public int getMember_id() {
		return member_id;
	}
	public void setMember_id(int member_id) {
		this.member_id = member_id;
	}
	public int getBox_id() {
		return box_id;
	}
	public void setBox_id(int box_id) {
		this.box_id = box_id;
	}
	public int getTime_table_id() {
		return time_table_id;
	}
	public void setTime_table_id(int time_table_id) {
		this.time_table_id = time_table_id;
	}
	public int getMovie_id() {
		return movie_id;
	}
	public void setMovie_id(int movie_id) {
		this.movie_id = movie_id;
	}
	public String getUse_day() {
		return use_day;
	}
	public void setUse_day(String use_day) {
		this.use_day = use_day;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	
	
}
