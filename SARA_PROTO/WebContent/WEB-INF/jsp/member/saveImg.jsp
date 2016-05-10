<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sunny/jquery-ui.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/scripts/css/ui.jqgrid.css" />
   
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/scripts/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/scripts/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui-1.9.2.custom.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.json-2.3.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<style type="text/css">
#empImg{
	border : 1px solid green; width : 150px; height : 170px; background-size:cover
}
table {cellpadding:0px;}
</style>
<script type="text/javascript">
var imgFilename;
$(document).ready(function(){
	
});
$('#addImgForm').ajaxForm({
	dataType:'json',
    success: function(responseText, statusText, xhr, $form){
		if(responseText.errorCode<0){
			alert(responseText.errorMsg);
		}else{
	    	imgFilename=responseText.imgFilename;
	   	//alert(imgFilename+"이미지파일네임")
	   	
	    	document.getElementById('imgFilename').value=imgFilename;
    		parent.document.getElementById('empFilename').value=imgFilename;
    		//alert('사진이 저장되었습니다.');
    	}
	}
});
function imgInsert(img){
	alert("img.value:"+img.value);
	$('#empImg').attr("background", img.value);
	//parent.document.frames[0].document.getElementById('empImg').background=img.value;

	//alert(document.getElementById('empImg'));
	//document.getElementById('empImg').background=img.value;
	
}
</script>
</head>
<body>
<center>
<form id="addImgForm" action="emp.do"  method="post" enctype="multipart/form-data" name="addImgForm">
	<input type=hidden name="oper" value="saveImg">
	<table><tr><td id="empImg"></td></tr></table>
	<input type=file id="tmpfile" name="tmpfile" style="display: none;" onchange="imgInsert(this)">
			<button type="button"
				onclick="document.getElementById('tmpfile').click();">찾아보기</button>
			<input type=submit id="btn1" name="btn1" style="display:none">
	<button type="button" onclick="document.getElementById('btn1').click();">저장</button>
	<input type="hidden" id="imgFilename">
</form>
</center>
</body>
</html>