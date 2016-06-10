<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
<script>
$(document).ready(function() {
	alert("getResList");
	getResList();
});


function getResList(){
	$.ajax({
	    url : '${pageContext.request.contextPath}/reservation/reservation.do?oper=findResList&fcNo=1',  //'local'
	    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	    type : 'post',
	    dataType:'json',
	   // data :{'list':list},
	    success : function(data, textStatus, jqXHR) {
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
				dataSet=data.list;
 				//alert(dataSet[0].rsStartTime.split(' ')[0]+"T"+dataSet[0].rsStartTime.split(' ')[1]);
 				//alert(dataSet[0].rsStartTime);
 				for(i=0;i<2;i++){
 					var res={"title":"","start":"","end":""};
 					//var resBean=
 					res.title=dataSet[i].fcNo;
 					//alert(res.title);
 					res.start=dataSet[i].rsStartTime.split(' ')[0];//+"T"+dataSet[i].rsStartTime.split(' ')[1];
 					res.end=dataSet[i].rsEndTime.split(' ')[0];
 					resList.push(res);
 				}
 				//alert(resList);
 				document.write(resList);
 				//return resList;
 				alert(resList);
	      	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     	alert("예약 현황을 받아오는데 오류가 발생했습니다.");
	    }
	});
}
</script>
</head>
<body>
<%
////'${pageContext.request.contextPath}/reservation/reservation.do?oper=findResList&fcNo=1',
%>
</body>
</html>