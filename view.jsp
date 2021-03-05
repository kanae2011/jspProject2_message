<%@page import="com.webjjang.main.controller.Beans"%>
<%@page import="com.webjjang.util.filter.AuthorityFilter"%>
<%@page import="com.webjjang.main.controller.ExeService"%>
<%@page import="com.webjjang.message.vo.MessageVO"%>
<%@page import="com.webjjang.member.vo.LoginVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
//자바 부분
//넘어오는 데이터 받기 - 메세지 번호 
String strNo = request.getParameter("no");

//내 아이디 정보를 꺼내야 함 
String id = ((LoginVO)session.getAttribute("login")).getId(); 
//vo객체 생성-데이터 셋팅
MessageVO vo = new MessageVO();
vo.setNo(Long.parseLong(strNo)); //코드 줄였음 
vo.setAccepter(id); //받는 사람 = 나인 데이터를 읽기표시 하기 위해서 id를 accepter에 넣음 
//db처리 데이터 가져오기
//1.받은 사람이 로그인한 사람과 같아야 하고(받은 메세지) 번호가 같고 받은 날짜가 null인 읽지 않은 메세지를 읽음표시로 바꿈 (acceptDate를 현재 날짜로 -update)
//2.메세지 번호에 맞는 전체 메세지 정보 가져오기
MessageVO messageVO = (MessageVO)ExeService.execute(Beans.get(AuthorityFilter.url), vo);
//서버객체에 저장
request.setAttribute("vo", messageVO);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메세지 보기</title>
</head>
<body>
<div class="container">
<h1>메세지 보기</h1>
<table class="table">
	<tr>
	<th>번호</th>
	<td>${vo.no }</td>
	</tr>
	<tr>
	<th>보낸사람</th>
	<td>${vo.sender }</td>
	</tr>
	<tr>
	<th>보낸날짜</th>
	<td>${vo.sendDate }</td>
	</tr>
	<tr>
	<th>내용</th>
	<td><pre style="border:none; padding:0px;">${vo.content }</pre></td>
	</tr>
	<tr>
	<th>받은사람</th>
	<td>${vo.accepter }</td>
	</tr>
	<tr>
	<th>받은날짜</th>
	<td>${vo.acceptDate }</td>
	</tr>

	<tr>
	<td colspan="5">
	<c:if test="${!(vo.sender == login.id && !empty vo.acceptDate)}">
	<a href="delete.jsp?no=${vo.no }" class=" btn btn-default ">삭제</a>
	</c:if>
	<a href="delete.jsp" class=" btn btn-default ">답장</a>
	<a href="list.jsp" class=" btn btn-default ">목록</a>
	
	</td>
	</tr>
</table>

</div>
</body>
</html>