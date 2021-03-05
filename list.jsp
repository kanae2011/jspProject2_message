<%@page import="com.webjjang.member.vo.LoginVO"%>
<%@page import="com.webjjang.message.vo.MessageVO"%>
<%@page import="java.util.List"%>
<%@page import="com.webjjang.util.filter.AuthorityFilter"%>
<%@page import="com.webjjang.main.controller.Beans"%>
<%@page import="com.webjjang.main.controller.ExeService"%>
<%@page import="com.webjjang.util.PageObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="pageObject" tagdir="/WEB-INF/tags" %>

<%
PageObject pageObject = new PageObject();
String strCurPage = request.getParameter("page");
String strPerPageNum = request.getParameter("perPageNum");
long curPage = 1;
long perPageNum = 10;
if(strCurPage !=null) pageObject.setPage(Long.parseLong(strCurPage));
if(strPerPageNum !=null)pageObject.setPerPageNum(Long.parseLong(strPerPageNum));

//내 아이디를 가져와서 pageObject에 저장해두기
pageObject.setAccepter(((LoginVO)session.getAttribute("login")).getId());

//데이터 가져오기
@SuppressWarnings("unchecked")
List<MessageVO>list = (List<MessageVO>)ExeService.execute(Beans.get(AuthorityFilter.url), pageObject);

 request.setAttribute("list",list);
 request.setAttribute("pageObject",pageObject);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메세지 목록</title>
<style type="text/css">
tr{
	color: #777;
}
.noRead{
	color: #433d3d;
}
.dataRow:hover{
	cursor: pointer;
	background: #eee;
}
</style>
<script type="text/javascript">
$(function () {
	//이벤트 처리
	//메세지 보기로 이동 
	$(".dataRow").click(function () {
		//alert("보기 클릭");
		//$(this) : $(자기 자신)이벤트가 일어난 곳->현재는 tr 에서 no를 찾아라. 태그 안에 있는 글자를 가져가라->text
		var no = $(this).find(".no").text();
		location = "view.jsp?no=" + no;
	})
});

</script>
</head>
<body>
<div class="container">
<h1>메세지 목록</h1>
<table class="table">
	<tr>
	
		<th>번호</th>
		<th>보낸사람</th>
		<th>보낸날짜</th>
		<th>받은사람</th>
		<th>받은날짜</th>
	
	</tr>
	
	<c:forEach items="${list }" var = "vo">
	<tr class="dataRow">
		<td class="no">${vo.no }</td>
		<td>${vo.sender }</td>
		<td>${vo.sendDate }</td>
		<td>${vo.accepter }</td>
		<td class='${(empty vo.acceptDate)?"noRead":"" }'>${(empty vo.acceptDate)?"읽지 않음":vo.acceptDate }</td>
	</tr>
	</c:forEach>
	
	<tr>
		<td colspan="5">
		<pageObject:pageNav listURI="list.jsp" pageObject="${pageObject }"></pageObject:pageNav><br>
		<a href="writeForm.jsp" class="btn btn-default">작성</a>
		<a href="delete.jsp" class="btn btn-default">삭제</a>
		</td>
	</tr>

</table>
</div>
</body>
</html>
