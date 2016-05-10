<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
<!-- start: Main Menu -->
			<div id="sidebar-left" class="span2">
				<div class="nav-collapse sidebar-nav">
					<ul class="nav nav-tabs nav-stacked main-menu">
					<li><a href="${pageContext.request.contextPath}/welcome.html"><i class="icon-home"></i><span class="hidden-tablet">Home</span></a></li>	
					<li>
							<a class="dropmenu" href="#"><i class="icon-pencil"></i><span class="hidden-tablet">스터디룸</span><span class="label label-important"> 3 </span></a>
							<ul>
								<li><a class="submenu" href="submenu.html"><i class="icon-nothing"></i><span class="hidden-tablet">해동학습실</span></a></li>
								<li><a class="submenu" href="submenu2.html"><i class="icon-nothing"></i><span class="hidden-tablet">도서관</span></a></li>
								<li><a class="submenu" href="submenu3.html"><i class="icon-nothing"></i><span class="hidden-tablet">강의실</span></a></li>
							</ul>	
						</li>
							<li>
							<a class="dropmenu" href="#"><i class="icon-globe"></i><span class="hidden-tablet">교내시설</span><span class="label label-important"> 3 </span></a>
							<ul>
								<li><a class="submenu" href="${pageContext.request.contextPath}/reservation/proto.html"><i class="icon-nothing"></i><span class="hidden-tablet">대운동장</span></a></li>
								<li><a class="submenu" href="submenu5.html"><i class="icon-nothing"></i><span class="hidden-tablet">뜨락</span></a></li>
								<li><a class="submenu" href="submenu6.html"><i class="icon-nothing"></i><span class="hidden-tablet">소강당</span></a></li>
							</ul>	
						</li>
					
						
<!-- 						<li><a href="messages.html"><i class="icon-envelope"></i><span class="hidden-tablet"> Messages</span></a></li> -->
<!-- 						<li><a href="tasks.html"><i class="icon-tasks"></i><span class="hidden-tablet"> Tasks</span></a></li> -->
<!-- 						<li><a href="ui.html"><i class="icon-eye-open"></i><span class="hidden-tablet"> UI Features</span></a></li> -->
<!-- 						<li><a href="widgets.html"><i class="icon-dashboard"></i><span class="hidden-tablet"> Widgets</span></a></li> -->
<!-- 						<li><a href="form.html"><i class="icon-edit"></i><span class="hidden-tablet"> Forms</span></a></li> -->
<!-- 						<li><a href="chart.html"><i class="icon-list-alt"></i><span class="hidden-tablet"> Charts</span></a></li> -->
<!-- 						<li><a href="typography.html"><i class="icon-font"></i><span class="hidden-tablet"> Typography</span></a></li> -->
<!-- 						<li><a href="gallery.html"><i class="icon-picture"></i><span class="hidden-tablet"> Gallery</span></a></li> -->
<!-- 						<li><a href="table.html"><i class="icon-align-justify"></i><span class="hidden-tablet"> Tables</span></a></li> -->
<!-- 						<li><a href="calendar.html"><i class="icon-calendar"></i><span class="hidden-tablet"> Calendar</span></a></li> -->
<!-- 						<li><a href="file-manager.html"><i class="icon-folder-open"></i><span class="hidden-tablet"> File Manager</span></a></li> -->
<!-- 						<li><a href="icon.html"><i class="icon-star"></i><span class="hidden-tablet"> Icons</span></a></li> -->
						
						<c:if test='${sessionScope.mbId eq null}'>
					<li><a href="${pageContext.request.contextPath}/member/loginForm.html"><i class="icon-lock"></i><span class="hidden-tablet"> Login Page</span></a></li>
						</c:if>
					</ul>
				</div>
			</div>
			<!-- end: Main Menu -->
</body>
</html>