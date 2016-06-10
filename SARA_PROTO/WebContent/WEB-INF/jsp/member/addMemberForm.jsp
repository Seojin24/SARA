<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sunny/jquery-ui.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/scripts/css/ui.jqgrid.css" />
   
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/scripts/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/scripts/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui-1.9.2.custom.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.json-2.3.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<style>
#moreDetailTabs {width:750px; font-size:15px;}
</style>
<script type="text/javascript">
var empBean;
var empBeanList;
$(document).ready(function(){
	//alert("사원등록");
	setEmpno(); //자동으로 empno등록 -->empController의 getlastEmpno
	$('#moreDetailTabs').tabs();
	$('#adEmp').button().click(all);
	$('#adCancel').button().click(function(){
		window.close();
	});
	$('#zipBtn').button();
	 $('#zipBtn').click(function() {
	        var features = 'width=600px; height=520px; left=400px; top=100px;';
	        window.open('${pageContext.request.contextPath}/base/post.html', '주소검색', features);
	    });
	$('#position').button().click(function(){
		var features = 'width=580px; height=520px; left=550px; top=150px; titlebar=no; status=no';
        alert($(this).attr("id"));
		window.open('${pageContext.request.contextPath}/base/codeList.do?code='+$(this).attr("id"),'코드검색',features);
	});
	$('#selDeptBtn').button().click(function(){
		var features = 'width=580px; height=520px; left=550px; top=150px; titlebar=no; status=no';
        window.open('${pageContext.request.contextPath}/base/deptList.do','부서검색',features);
	});
	$('#empDate').datepicker({
        dateFormat: "yy/mm/dd",
        	showOn: "button",
            buttonImage: "${pageContext.request.contextPath}/images/calendar.jpg",
            buttonImageOnly: true,
            buttonText: "Select date"
    });
	
});
function ObjectCopy(obj){
	//JSON.stringify(obj) --함수 -->JSON텍스트를 포함하는 문자열을 반환함 
	 return JSON.parse(JSON.stringify(obj));
	//JSON.parse(json문자열)-->json문자열을 객체로 변환하는 함수 
}
function setEmpno(){
	$.ajax({
		url:'emp.do?oper=setEmpno',
		dataType:'json',
		cache:false, //이부분 false 해줘야 empno가 update됨 
	 	success: function(data){
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
				$('#empNo').val(data.lastEmpno);
 				empBean=ObjectCopy(data.emptyEmpBean);
 			}
	 	}
	});
}
function checkEmpData(){
	//공백 입력금지 함수 
	var ename=$.trim($('#empName').val());
	var eregno=$.trim($('#empRegno').val());
	var edate=$.trim($('#empDate').val());
	var deptno=$.trim($('#deptNo').val());
	
	if(ename=='') {alert('이름을 입력하세요.'); $('#empName').focus(); return false;}
		else return true;
	if(eregno=='') {alert('주민등록번호를 입력하세요.'); $('#empRegno').focus(); return false;}
		else return true;
	if(edate=='') {alert('입사일자를 확인하세요.'); $('#empDate').focus(); return false;}
		else return true;
	if(deptno=='') {alert('부서번호를 입력하세요.'); $('#deptNo').focus(); return false;}
		else return true;
}
function all(){
    empBeanList=[];
	if(!checkEmpData()) return;
	if(!confirm("등록하시겠습니까?")) return;
	//이때 빈 empBean은 setEmpno 할때 받아온 bean 
	empBean.empNo=$("#empNo").val();
	empBean.empName=$("#empName").val();
	empBean.empRegno=$("#empRegno").val();
	var gender = $(":input:radio[name='empGender']:checked").val();
	empBean.genderCode=gender;
	empBean.empHiredate=$("#empDate").val();
	//alert($("#empDate").val());
	empBean.empEmail=$("#empEmail").val();
	empBean.empTel=$("#empTel").val();
	empBean.empPhone=$("#empPhone").val();
	empBean.empAddr=$("#empAddress").val();
	empBean.empZip=$("#empZipcode").val();
	empBean.empFilename=$("#empFilename").val();
	empBean.empTempfilename=$("#empFilename").val();
	empBean.deptCode=$("#deptNo").val();
	empBean.positionCode=$("#positionNo").val();
	empBean.status="insert"; //추가할 때 status 설정 
	empBeanList.push(empBean);
	var list='{"empBeanList":'+$.toJSON(empBeanList)+'}';
	//list를 JSON문자열로 변환함 
	//alert(list);
	//allProcess에서 list를 처리함 
	allProcess(list);
	//window.opener.location.href="listForm.do";
	window.opener.location.href="empList.html"; 
	//opener의 위치 -> listForm.html로 이동함 -->새로 고침 
	window.close();
	//현재 addForm을 닫는다. 
}
function allProcess(list){
	$.ajax({
	    url : 'emp.do?oper=batchEmpList', //한꺼번에 처리 
	    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	    type : 'post',
	    data :{'list':list},
	    success : function(data, textStatus, jqXHR) {
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
	    		alert("처리 되었습니다.");
	    		//처리가 완료되었다는 메세지 
	    		alert(data);
	    	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     	alert("일괄처리 오류입니다!>>");
	    }
	});
}
</script>
<div id="moreDetailTabs">
<!-- 		<ul > -->
<!-- 			<li style="font-size:13px"><h1>회원정보</h1></li> -->
<!-- 		</ul> -->
<center><h3>회원정보</h5></center>
		<div id="empDetail">
		<table id="empinfo">
					<tr>

						<td width="750px" valign="top">
							<table align="center">
								<tr>
									<td><label>회원일련번호 : </label></td>
									<td><input type=text id="mbNo" name="mbNo" size=7 readonly="readonly" value="${sessionScope.mbNo+1}"></td>
										<!--readonly="readonly" 속성사용 ㄴㄴ   -->
								</tr>
								<tr>
									<td><label>이 름 : </label></td>
									<td><input type=text id="mbName" name="mbName" size=7></td>
								</tr>
								<tr>
									<td><label>아이디 : </label></td>
									<td><input type=text id="mbId" name="mbId" size=7></td>
								</tr>
								<tr>
									<td><label>비밀번호 : </label></td>
									<td><input type=text id="mbPw" name="mbPw" size=7></td>
								</tr>
<!-- 								<tr> -->
<!-- 									<td><label>성 별 : </label></td> -->
<!-- 									<td><input type="radio" name="empGender" value="M" checked>남 -->
<!-- 									<input type="radio" name="empGender" value="F">여 -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<td><label>입사일자: </label></td> -->
<!-- 									<td><input type=text id="empDate" name="empDate" size=10></td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<td><label>전화번호: </label></td> -->
<!-- 									<td><input type=text id="empTel" name="empTel" size=20></td> -->
<!-- 								</tr> -->
								<tr>
									<td><label>생년월일: </label></td>
									<td><input type=text id="mbBirth" name="mbBirth" size=20></td>
								</tr>
								<tr>
									<td><label>휴대폰: </label></td>
									<td><input type=text id="mbPhone" name="mbPhone" size=20></td>
								</tr>
								
								<tr>
									<td><label>이 메 일: </label></td>
									<td><input type=text id="mbEmail" name="mbEmail" size=20></td>
								</tr>
<!-- 								<tr> -->
<!-- 									<td><label>우편번호: </label></td> -->
<!-- 									<td><input type=text id="empZipcode" name="empZipcode" -->
<!-- 										size=7> <input type="button" id="zipBtn" -->
<!-- 										value="우편번호"></td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<td><label>주 소: </label></td> -->
<!-- 									<td><input type=text id="empAddress" name="empAddress" -->
<!-- 										size=50></td> -->
<!-- 								</tr> -->
								<tr>
									<td><label>소속학부대학: </label></td>
									<td><input type=text name="deptNo" id="deptNo" size="4" readonly> <span id="empDept"></span>
										<input type="button" id="selDeptBtn" value="+"></td>
								</tr>
								<tr>
									<td><label>동아리: </label></td>
									<td><input type=text name="positionNo" id="positionNo" size="2" readonly> <span id="empPosition"></span>
									<input type="button" id="position" value="+"></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
					<td colspan="2" align="center" style="font-size:12px">
					<input type="button" id="adEmp" value="등록">
					<input type="button" id="adCancel" value="취소">
					</td>
					</tr>
		</table>
		</div>
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