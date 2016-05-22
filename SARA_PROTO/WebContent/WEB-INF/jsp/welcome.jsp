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
				url: '/reservation/reservation.do?oper=getReservationList&fcNo=1',
				error: function() {
					$('#script-warning').show();
				}
			}
// 			events: [
// 				{
// 					title: 'All Day Event',
// 					start: '2016-05-01'
// 				},
// 				{
// 					title: 'Long Event',
// 					start: '2016-05-07',
// 					end: '2016-05-10'
// 				},
// 				{
// 					id: 999,
// 					title: 'Repeating Event',
// 					start: '2016-05-09T16:00:00'
// 				},
// 				{
// 					id: 999,
// 					title: 'Repeating Event',
// 					start: '2016-05-16T16:00:00'
// 				},
// 				{
// 					title: 'Conference',
// 					start: '2016-05-11',
// 					end: '2016-05-13'
// 				},
// 				{
// 					title: 'Meeting',
// 					start: '2016-05-12T10:30:00',
// 					end: '2016-05-12T12:30:00'
// 				},
// 				{
// 					title: 'Lunch',
// 					start: '2016-05-12T12:00:00'
// 				},
// 				{
// 					title: 'Meeting',
// 					start: '2016-05-12T14:30:00'
// 				},
// 				{
// 					title: 'Happy Hour',
// 					start: '2016-05-12T17:30:00'
// 				},
// 				{
// 					title: 'Dinner',
// 					start: '2016-05-12T20:00:00'
// 				},
// 				{
// 					title: 'Birthday Party',
// 					start: '2016-05-13T07:00:00'
// 				},
// 				{
// 					title: 'Click for Google',
// 					url: 'http://google.com/',
// 					start: '2016-05-28'
// 				}
// 			]
		});
		
	});
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

	<div id='calendar'></div>

</body>
</html>