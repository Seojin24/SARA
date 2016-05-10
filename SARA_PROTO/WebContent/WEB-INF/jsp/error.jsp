<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript">
$(document).ready(function(){
	$('#main').click(function(){
		location.href="${pageContext.request.contextPath}/welcome.html";
	});	
	$('#login').click(function(){
		location.href="history.go(-1)";
	});	

});
</script>
<center>
	<br>
	<c:if test='${sessionScope.id eq null}'>
		<h1>오류 : ${requestScope.errorMsg}</h1>
		<input type="button" id="login" value="로그인페이지로">
	</c:if>
	<c:if test='${sessionScope.id ne null}'>
		<h1>오류 : ${requestScope.errorMsg}</h1>
		<input type="button" id="main" value="메인페이지로">
	</c:if>
</center>
