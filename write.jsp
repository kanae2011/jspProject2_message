<%@page import="com.webjjang.main.controller.Beans"%>
<%@page import="com.webjjang.util.filter.AuthorityFilter"%>
<%@page import="com.webjjang.main.controller.ExeService"%>
<%@page import="com.webjjang.message.vo.MessageVO"%>
<%@page import="com.webjjang.member.vo.LoginVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
//자바부분
//넘어오는 데이터 수집
String accepter = request.getParameter("accepter");
String content = request.getParameter("content");

//session 에서 내 아이디 가져오기
//session의 내용은 /member/login.jsp에서 key를 저장해놨음 (27번째줄)
LoginVO vo = (LoginVO)session.getAttribute("login"); 
String sender = vo.getId();
//vo객체에 데이터넣기
MessageVO messageVO = new MessageVO();
messageVO.setSender(sender);
messageVO.setContent(content);
messageVO.setAccepter(accepter);

//db처리 : jsp-service-dao-db
//(실행할 서비스,전달되는 데이터 )
ExeService.execute(Beans.get(AuthorityFilter.url), messageVO);
//리스트로 자동이동
response.sendRedirect("list.jsp");
%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>