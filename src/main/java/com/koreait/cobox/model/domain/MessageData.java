package com.koreait.cobox.model.domain;

import lombok.Data;

@Data
public class MessageData {
	   private int resultCode; //�떎�뙣,�꽦怨� �뿬遺� �뙋�떒 肄붾뱶 
	   private String msg; //�겢�씪�씠�뼵�듃媛� 蹂닿쾶�맆 硫붿떆吏�
	   private String url; //�깉濡�寃� �슂泥��븷 �럹�씠吏�媛� �엳�떎硫� 洹� url
	   
	   
   public int getResultCode() {
		return resultCode;
	}
	public void setResultCode(int resultCode) {
		this.resultCode = resultCode;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

   
}