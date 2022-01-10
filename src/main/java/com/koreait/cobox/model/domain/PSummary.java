package com.koreait.cobox.model.domain;

public class PSummary {

	private int p_summary_id;
	private int schedule_id;
	private int p_method_id;
	private String p_date;
	private int total_price;
	
	
	private Schedule[] schedule;
	
	
	public Schedule[] getSchedule() {
		return schedule;
	}
	public void setSchedule(Schedule[] schedule) {
		this.schedule = schedule;
	}
	public int getP_summary_id() {
		return p_summary_id;
	}
	public void setP_summary_id(int p_summary_id) {
		this.p_summary_id = p_summary_id;
	}
	public int getSchedule_id() {
		return schedule_id;
	}
	public void setSchedule_id(int schedule_id) {
		this.schedule_id = schedule_id;
	}
	public int getP_method_id() {
		return p_method_id;
	}
	public void setP_method_id(int p_method_id) {
		this.p_method_id = p_method_id;
	}
	public String getP_date() {
		return p_date;
	}
	public void setP_date(String p_date) {
		this.p_date = p_date;
	}
	public int getTotal_price() {
		return total_price;
	}
	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}
	
	
}
