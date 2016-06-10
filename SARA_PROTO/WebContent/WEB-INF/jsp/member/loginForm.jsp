<%@ page language="java" import="java.util.*" pageEncoding="EUC-KR" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%-- <script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js" type="text/javascript"></script> --%>
<%-- <script src="${pageContext.request.contextPath}/js/jquery-ui-1.9.2.custom.js"></script> --%>
<%-- <script src="${pageContext.request.contextPath}/js/jquery.json-2.3.js"></script> --%>
<%-- <script src="${pageContext.request.contextPath}/js/jquery.form.js"></script> --%>
<script>
$(document).ready(function(){
	$('#loginBtn').button();
	$('#id').focus();
});
</script>
</head>
<body>
<div class="container">
	<form action="${pageContext.request.contextPath}/member/member.do" method="post">
		<input type="hidden" name="oper" value="login">
		<br><br>
		<table align="center">
			<tr><td style="font-size:1em">아이디 :<td><input type="text" id="mbId" name="mbId"></td></tr>
			<tr><td style="font-size:1em" >비밀번호 :<td><input type="password" id="mbPw" name="mbPw"></td></tr>
			<tr><td colspan="2" align="center">
				<input type="submit" value="로그인" id="loginBtn">&nbsp
				<input type="button" value="취소" id="cancelBtn"><br>
				<br>
				<div>
				<a href="${pageContext.request.contextPath}/member/addMemberForm.html">회원가입</a>
				&nbsp 
				<a href="#">비밀번호 찾기</a>
				</div>
				
			 </td></tr>
</table>
<center><font color="red">${msg}</font></center>
</form>
</div>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
</body>
</html>