<%@page import="com.koreait.cobox.model.domain.Comments"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/json; charset=UTF-8"%>
<%
	List<Comments> commentsList =(List)request.getAttribute("commentsList");
	StringBuilder sb = new StringBuilder();
	sb.append("{");
	sb.append("\"list\":[");
	for(int i=0;i<commentsList.size();i++){
		Comments comments=commentsList.get(i);
		
		sb.append("{");
		sb.append("\"msg\":\""+comments.getMsg()+"\",");
		sb.append("\"member_id\":\""+comments.getMember_id()+"\",");
		sb.append("\"regist\":\""+comments.getCdate().substring(0,10)+"\"");
	if(i<commentsList.size()-1){
		sb.append("},");	
	}else{
		sb.append("}");
	}
	}
	sb.append("]");	
	sb.append("}");	
	out.print(sb.toString());


%>