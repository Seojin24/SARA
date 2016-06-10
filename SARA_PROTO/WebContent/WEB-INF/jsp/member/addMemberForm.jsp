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
	//alert("������");
	setEmpno(); //�ڵ����� empno��� -->empController�� getlastEmpno
	$('#moreDetailTabs').tabs();
	$('#adEmp').button().click(all);
	$('#adCancel').button().click(function(){
		window.close();
	});
	$('#zipBtn').button();
	 $('#zipBtn').click(function() {
	        var features = 'width=600px; height=520px; left=400px; top=100px;';
	        window.open('${pageContext.request.contextPath}/base/post.html', '�ּҰ˻�', features);
	    });
	$('#position').button().click(function(){
		var features = 'width=580px; height=520px; left=550px; top=150px; titlebar=no; status=no';
        alert($(this).attr("id"));
		window.open('${pageContext.request.contextPath}/base/codeList.do?code='+$(this).attr("id"),'�ڵ�˻�',features);
	});
	$('#selDeptBtn').button().click(function(){
		var features = 'width=580px; height=520px; left=550px; top=150px; titlebar=no; status=no';
        window.open('${pageContext.request.contextPath}/base/deptList.do','�μ��˻�',features);
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
	//JSON.stringify(obj) --�Լ� -->JSON�ؽ�Ʈ�� �����ϴ� ���ڿ��� ��ȯ�� 
	 return JSON.parse(JSON.stringify(obj));
	//JSON.parse(json���ڿ�)-->json���ڿ��� ��ü�� ��ȯ�ϴ� �Լ� 
}
function setEmpno(){
	$.ajax({
		url:'emp.do?oper=setEmpno',
		dataType:'json',
		cache:false, //�̺κ� false ����� empno�� update�� 
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
	//���� �Է±��� �Լ� 
	var ename=$.trim($('#empName').val());
	var eregno=$.trim($('#empRegno').val());
	var edate=$.trim($('#empDate').val());
	var deptno=$.trim($('#deptNo').val());
	
	if(ename=='') {alert('�̸��� �Է��ϼ���.'); $('#empName').focus(); return false;}
		else return true;
	if(eregno=='') {alert('�ֹε�Ϲ�ȣ�� �Է��ϼ���.'); $('#empRegno').focus(); return false;}
		else return true;
	if(edate=='') {alert('�Ի����ڸ� Ȯ���ϼ���.'); $('#empDate').focus(); return false;}
		else return true;
	if(deptno=='') {alert('�μ���ȣ�� �Է��ϼ���.'); $('#deptNo').focus(); return false;}
		else return true;
}
function all(){
    empBeanList=[];
	if(!checkEmpData()) return;
	if(!confirm("����Ͻðڽ��ϱ�?")) return;
	//�̶� �� empBean�� setEmpno �Ҷ� �޾ƿ� bean 
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
	empBean.status="insert"; //�߰��� �� status ���� 
	empBeanList.push(empBean);
	var list='{"empBeanList":'+$.toJSON(empBeanList)+'}';
	//list�� JSON���ڿ��� ��ȯ�� 
	//alert(list);
	//allProcess���� list�� ó���� 
	allProcess(list);
	//window.opener.location.href="listForm.do";
	window.opener.location.href="empList.html"; 
	//opener�� ��ġ -> listForm.html�� �̵��� -->���� ��ħ 
	window.close();
	//���� addForm�� �ݴ´�. 
}
function allProcess(list){
	$.ajax({
	    url : 'emp.do?oper=batchEmpList', //�Ѳ����� ó�� 
	    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	    type : 'post',
	    data :{'list':list},
	    success : function(data, textStatus, jqXHR) {
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
	    		alert("ó�� �Ǿ����ϴ�.");
	    		//ó���� �Ϸ�Ǿ��ٴ� �޼��� 
	    		alert(data);
	    	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     	alert("�ϰ�ó�� �����Դϴ�!>>");
	    }
	});
}
</script>
<div id="moreDetailTabs">
<!-- 		<ul > -->
<!-- 			<li style="font-size:13px"><h1>ȸ������</h1></li> -->
<!-- 		</ul> -->
<center><h3>ȸ������</h5></center>
		<div id="empDetail">
		<table id="empinfo">
					<tr>

						<td width="750px" valign="top">
							<table align="center">
								<tr>
									<td><label>ȸ���Ϸù�ȣ : </label></td>
									<td><input type=text id="mbNo" name="mbNo" size=7 readonly="readonly" value="${sessionScope.mbNo+1}"></td>
										<!--readonly="readonly" �Ӽ���� ����   -->
								</tr>
								<tr>
									<td><label>�� �� : </label></td>
									<td><input type=text id="mbName" name="mbName" size=7></td>
								</tr>
								<tr>
									<td><label>���̵� : </label></td>
									<td><input type=text id="mbId" name="mbId" size=7></td>
								</tr>
								<tr>
									<td><label>��й�ȣ : </label></td>
									<td><input type=text id="mbPw" name="mbPw" size=7></td>
								</tr>
<!-- 								<tr> -->
<!-- 									<td><label>�� �� : </label></td> -->
<!-- 									<td><input type="radio" name="empGender" value="M" checked>�� -->
<!-- 									<input type="radio" name="empGender" value="F">�� -->
<!-- 									</td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<td><label>�Ի�����: </label></td> -->
<!-- 									<td><input type=text id="empDate" name="empDate" size=10></td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<td><label>��ȭ��ȣ: </label></td> -->
<!-- 									<td><input type=text id="empTel" name="empTel" size=20></td> -->
<!-- 								</tr> -->
								<tr>
									<td><label>�������: </label></td>
									<td><input type=text id="mbBirth" name="mbBirth" size=20></td>
								</tr>
								<tr>
									<td><label>�޴���: </label></td>
									<td><input type=text id="mbPhone" name="mbPhone" size=20></td>
								</tr>
								
								<tr>
									<td><label>�� �� ��: </label></td>
									<td><input type=text id="mbEmail" name="mbEmail" size=20></td>
								</tr>
<!-- 								<tr> -->
<!-- 									<td><label>�����ȣ: </label></td> -->
<!-- 									<td><input type=text id="empZipcode" name="empZipcode" -->
<!-- 										size=7> <input type="button" id="zipBtn" -->
<!-- 										value="�����ȣ"></td> -->
<!-- 								</tr> -->
<!-- 								<tr> -->
<!-- 									<td><label>�� ��: </label></td> -->
<!-- 									<td><input type=text id="empAddress" name="empAddress" -->
<!-- 										size=50></td> -->
<!-- 								</tr> -->
								<tr>
									<td><label>�Ҽ��кδ���: </label></td>
									<td><input type=text name="deptNo" id="deptNo" size="4" readonly> <span id="empDept"></span>
										<input type="button" id="selDeptBtn" value="+"></td>
								</tr>
								<tr>
									<td><label>���Ƹ�: </label></td>
									<td><input type=text name="positionNo" id="positionNo" size="2" readonly> <span id="empPosition"></span>
									<input type="button" id="position" value="+"></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
					<td colspan="2" align="center" style="font-size:12px">
					<input type="button" id="adEmp" value="���">
					<input type="button" id="adCancel" value="���">
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