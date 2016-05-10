<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator" %>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><decorator:title/></title>
<!-- start: CSS -->
<decorator:head />
	<link id="bootstrap-style" href="${pageContext.request.contextPath}/sara/css/bootstrap.min.css" rel="stylesheet">
	<link href="${pageContext.request.contextPath}/sara/css/bootstrap-responsive.min.css" rel="stylesheet">
	<link id="base-style" href="${pageContext.request.contextPath}/sara/css/style.css" rel="stylesheet">
	<link id="base-style-responsive" href="${pageContext.request.contextPath}/sara/css/style-responsive.css" rel="stylesheet">
	<link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800&subset=latin,cyrillic-ext,latin-ext' rel='stylesheet' type='text/css'>
	<!-- end: CSS -->
	
	<!-- start: Favicon -->
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/sara/img/favicon.ico">
	<!-- end: Favicon -->
</head>
<body>


		<jsp:include page="header.jsp" /> 
	
		<div class="container-fluid-full">
		<div class="row-fluid">
		
				<jsp:include page="menu.jsp" /> 
				
			<noscript>
				<div class="alert alert-block span10">
					<h4 class="alert-heading">Warning!</h4>
					<p>You need to have <a href="http://en.wikipedia.org/wiki/JavaScript" target="_blank">JavaScript</a> enabled to use this site.</p>
				</div>
			</noscript>
<!-- 			</div> -->
<!-- 			</div> -->
			
<!-- 	<center> -->
<!-- 		<table> -->
<!-- 			<tr> -->
<%-- 				<td colspan="2" valign="top"><jsp:include page="top.jsp" /></td> --%>
<!-- 			</tr> -->
<!-- 			<tr style="height: 700px"> -->
<!-- 				<td valign="top" style="width: 150px;"> -->
<%-- 					<jsp:include page="menu.jsp" /> --%>
<!-- 				</td> -->
<%-- 				<td valign="top" id="bgr" ><decorator:body /></td> --%>
<!-- 			</tr> -->
<!-- 			<tr> -->
<%-- 				<td colspan="2"><jsp:include page="bottom.jsp" /> --%>
<!-- 				</td> -->
<!-- 			</tr> -->
<!-- 		</table> -->
<!-- 	</center> -->
	
	
		<!-- start: Content -->
		<div id="content" class="span10">	
		<div class="container-fluid-full">
       <decorator:body />
		<!-- end: Content -->
		</div><!--/#content.span10-->
		</div><!--/fluid-row-->
	
	</div>
	</div>
	
	
	<!--  footer -->
	
	<div class="modal hide fade" id="myModal">
		<div class="modal-header">
			<button type="button" class="close" data-dismiss="modal">¡¿</button>
			<h3>Settings</h3>
		</div>
		<div class="modal-body">
			<p>Here settings can be configured...</p>
		</div>
		<div class="modal-footer">
			<a href="#" class="btn" data-dismiss="modal">Close</a>
			<a href="#" class="btn btn-primary">Save changes</a>
		</div>
	</div>
	
	<div class="common-modal modal fade" id="common-Modal1" tabindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-content">
			<ul class="list-inline item-details">
				<li><a href="http://themifycloud.com">Admin templates</a></li>
				<li><a href="http://themescloud.org">Bootstrap themes</a></li>
			</ul>
		</div>
	</div>
	
	<div class="clearfix"></div>
	
	<footer>
		<p>
			<span style="text-align:left;float:left">&copy; 2016 <a href="http://themifycloud.com/downloads/janux-free-responsive-admin-dashboard-template/" alt="Bootstrap_Metro_Dashboard">SKKU SARA </a></span>
		</p>
	</footer>
	
	<!-- start: JavaScript-->
		<script src="${pageContext.request.contextPath}/sara/js/jquery-1.9.1.min.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery-migrate-1.0.0.min.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery-ui-1.10.0.custom.min.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.ui.touch-punch.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/modernizr.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/bootstrap.min.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.cookie.js"></script>
		<script src='${pageContext.request.contextPath}/sara/js/fullcalendar.min.js'></script>
		<script src='${pageContext.request.contextPath}/sara/js/jquery.dataTables.min.js'></script>
		<script src="${pageContext.request.contextPath}/sara/js/excanvas.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.flot.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.flot.pie.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.flot.stack.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.flot.resize.min.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.chosen.min.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.uniform.min.js"></script>	
		<script src="${pageContext.request.contextPath}/sara/js/jquery.cleditor.min.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.noty.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.elfinder.min.js"></script>	
		<script src="${pageContext.request.contextPath}/sara/js/jquery.raty.min.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.iphone.toggle.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.uploadify-3.1.min.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.gritter.min.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.imagesloaded.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.masonry.min.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.knob.modified.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/jquery.sparkline.min.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/counter.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/retina.js"></script>
		<script src="${pageContext.request.contextPath}/sara/js/custom.js"></script>
	<!-- end: JavaScript-->
</body>
</html>