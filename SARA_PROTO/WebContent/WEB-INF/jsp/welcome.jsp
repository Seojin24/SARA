<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link href='${pageContext.request.contextPath}/fullcalendar/fullcalendar.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
<script src='${pageContext.request.contextPath}/fullcalendar/lib/moment.min.js'></script>
<script src='${pageContext.request.contextPath}/fullcalendar/lib/jquery.min.js'></script>
<script src='${pageContext.request.contextPath}/fullcalendar/fullcalendar.min.js'></script>
<script>
	$(document).ready(function() {
		var resbean;
		var dataSet; 
		var resList=[];
		alert(getResList());
		$.ajax({
			  url : 'getResList.jsp',  //'local'
			    dataType:'json',
			    success : function(data) {
			    	alert("getResList"+data);
			    }
		});
		
		$('#calendar').fullCalendar({
			//#generalDisplay 
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'agendaWeek'
			},
			//defaultDate: '2016-05-12',
			//#selection
			selectable: true,
			selectHelper: true,
			select: function(start, end) {
				var cur_m = $('#calendar').fullCalendar('getDate');
				var start_m=start;
				//alert(cur_m<start_m);

				//만약 선택날짜 > 현재날짜 
				if(cur_m<start_m){
					var title = 'PG:'+prompt('Event Title:');
				var eventData;
				if (title) { //title 입력시 
					eventData = {
						title: title,
						start: start,
						end: end,
						overlap:false
					};
					var is_save=confirm("save it?");
					if(is_save){
						$('#calendar').fullCalendar('renderEvent', eventData, true); // stick? = true
						//db연동 
						save_data(eventData); 
					}
				}
				//$('#calendar').fullCalendar('unselect');
				
				}
				
				else{
					alert("It is not available to make a reservation before this moment");
					//$('#calendar').fullCalendar('unselect');
				}
				$('#calendar').fullCalendar('unselect');
			},
			
			//#Agenda Options
			minTime:"09:00:00",//시작시간 
			maxTime:"22:00:00",//끝나는 시간
			slotEventOverlap:false,
			//#Current Date 
			nowIndicator:true,

			//#Event Dragging & Resizing 
			editable: true,
			eventLimit: true, // allow "more" link when too many events
			//#Event Data
			//fcNo : 장소 식별 번호 , 
			
			events:{
				url:'getResList.jsp', 
					//'${pageContext.request.contextPath}/reservation/reservation.do?oper=findResList&fcNo=1',
				error: function() {
					$('#script-warning').show();
				}
			}
			,
			
			events: [
				{
					title: 'All Day Event',
					start: '2016-05-01'
				},
				{
					title: 'Long Event',
					start: '2016-05-07',
					end: '2016-05-10'
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: '2016-05-09 16:00:00'
				},
				{
					id: 999,
					title: 'Repeating Event',
					start: '2016-05-16T16:00:00'
				},
				{
					title: 'Conference',
					start: '2016-05-11',
					end: '2016-05-13'
				},
				{
					title: 'Meeting',
					start: '2016-05-12T10:30:00',
					end: '2016-05-12T12:30:00'
				},
				{
					title: 'Lunch',
					start: '2016-05-12T12:00:00'
				},
				{
					title: 'Meeting',
					start: '2016-05-12T14:30:00'
				},
				{
					title: 'Happy Hour',
					start: '2016-05-12T17:30:00'
				},
				{
					title: 'Dinner',
					start: '2016-05-12T20:00:00'
				},
				{
					title: 'Birthday Party',
					start: '2016-05-13T07:00:00'
				},
				{
					title: 'Click for Google',
					url: 'http://google.com/',
					start: '2016-05-28'
				}
			]
			
			});
		});
	
// 	function parseDate(resBean){
// 		resbean=ObjectCopy(resBean);
// 		res.title=resbean.fcNo;
// 		res.start=resbean.rsStartTime;
// 		res.end=resbean.rsEndTime;
// 	}
function getResList(){
	
	var resBeanList=[];
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
 					var resBean=ObjectCopy(dataSet[i]);
 					//alert(resBean.fcNo+"resbean");
 					res.title=resBean.fcNo;
 					//alert(res.title);
 					res.start=resBean.rsStartTime.split(' ')[0];//+"T"+dataSet[i].rsStartTime.split(' ')[1];
 					res.end=resBean.rsEndTime.split(' ')[0];
 					resList.push(res);
 				}
 				//alert(resList);
 				resBeanList=resList;
	      	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     //	alert("예약 현황을 받아오는데 오류가 발생했습니다.");
	    }
	});
	return resBeanList;
}


	
	function ObjectCopy(obj){
		 return JSON.parse(JSON.stringify(obj));
	}

</script>
<style>

	body {
		margin: 40px 10px;
		padding: 0;
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}

</style>

</head>
<body>
<!-- <br><br><br><br><br><br> -->
<!-- <center> -->
<!-- <div style="font-size: 50px; color: orange; bold;">EVERYDAY</div> -->
<!-- <div style="font-size: 80px; color: black; bold;">SJ Corporation</div> -->
<!-- </center> -->

	<ul class="breadcrumb">
				<li>
					<i class="icon-home"></i>
					<a href="/sara/welcome.html">Home</a> 
					<i class="icon-angle-right"></i>
				</li>
				<li><a href="#">Dashboard</a></li>
			</ul>
	<div id='calendar'></div>

</body>
</html>