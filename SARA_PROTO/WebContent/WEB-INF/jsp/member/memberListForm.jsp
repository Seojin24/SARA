<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%-- <%@ page import="javax.xml.parsers.*"%> --%>
<%-- <%@ page import="org.w3c.dom.*"%> --%>
<style>
#grid {
	font-size: 20px;
}

#moreDetailTabs {
	width: 700px;
	font-size: 20px;
}
</style>
<script type="text/javascript">
var dataSet;
var empBean;
var index;
var delEmpBeanList;
var modiEmpBeanList;
$(document).ready(function(){
	$("#moreDetailTabs").css({'display':'none'});
	$("#moreDetailTabs").tabs();
	$('#adEmp').button().click(function(){
		 var features = 'width=780px; height=480px; left=100px; top=10px; overflow=auto;';
	      window.open('${pageContext.request.contextPath}/emp/addForm.html','사원등록', features);
	});
	$('#delEmp').button().click(deleteEmp);
	$('#modiEmp').button().click(modifyEmp);
	$('#modiCancel').button().click(function(){
		$("#moreDetailTabs").css({'display':'none'})
	});
	$('#zipBtn').button();
	$('#zipBtn').click(function() {
        var features = 'width=600px; height=520px; left=400px; top=100px;';
        window.open('${pageContext.request.contextPath}/base/post.html', '주소검색', features);
    });
	$('#empDate').datepicker({
        dateFormat: "yy/mm/dd",
        showOn: "button",
        buttonImage: "${pageContext.request.contextPath}/images/calendar.jpg",
        buttonImageOnly: true,
        buttonText: "Select date"
    });
	showEmpGrid();
	
	xmlEmpList();
	
	
	//alert("${pageContext.request.contextPath}/emp/emp.do?oper=getEmpXmlList");
	// ${pageContext.request.contextPath} : /프로젝트명 
});
function setEmpInfo(){
	empBean=ObjectCopy(dataSet[index]);
	//document.frames[0].document.getElementById('empImg').background="c:\\upload\\"+dataSet[index].empFilename;
	document.frames[0].document.getElementById('empImg').background="http://localhost/upload/"+dataSet[index].empFilename;
	
	//alert("c:\\temp\\"+dataSet[index].empFilename);
	//alert("이미지삽입");
	//C:\dev\server\ApacheHttpServer\htdocs\upload 
	//document.frames[0].document.getElementById('empImg').background="http://localhost/choi/temp/"+dataSet[index].empFilename;
	$('#empNo').val(dataSet[index].empNo);
	$('#empName').text(dataSet[index].empName);
	$('#empRegno').text(dataSet[index].empRegno);
	$('#empGender').text(dataSet[index].genderCode);
	$('#empDate').val(dataSet[index].empHiredate);
	//alert(dataSet[index].empHiredate);
	$('#empTel').val(dataSet[index].empTel);
	$('#empPhone').val(dataSet[index].empPhone);
	$('#empEmail').val(dataSet[index].empEmail);
	$('#empZipcode').val(dataSet[index].empZip);
	$('#empAddress').val(dataSet[index].empAddr);
	//$('#deptNo').text(dataSet[index].deptCode);
	$('#deptName').text(dataSet[index].deptName);
	//$('#positionNo').text(dataSet[index].positionCode);
	$('#positionName').text(dataSet[index].positionName);
	$('#empFilename').val(dataSet[index].empFilename);
}
function modifyEmp(){
	modifyEmpInfo();
	var list='{"empBeanList":'+$.toJSON(modiEmpBeanList)+'}';
	modifyProcess(list);
}
function modifyProcess(list){
	alert(list);
	$.ajax({
	    url : 'emp.do?oper=batchEmpList',  //'local'
	    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	    type : 'post',
	    data :{'list':list},
	    success : function(data, textStatus, jqXHR) {
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
	    		//alert(list);
	    		alert("수정 되었습니다.");
	    	//	showCodeGrid();
	    		$('#grid').trigger("reloadGrid");
	      	//	$('#detail').trigger("reloadGrid");
	      	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     	alert("일괄처리 오류입니다!>>");
	    }
	});
}
function deleteEmp(){
	deleteEmpInfo();
	var list='{"empBeanList":'+$.toJSON(delEmpBeanList)+'}';
	deleteProcess(list);
}
function deleteProcess(list){
	alert(list);
	$.ajax({
	    url : 'emp.do?oper=batchEmpList',  //'local'
	    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	    type : 'post',
	    data :{'list':list},
	    success : function(data, textStatus, jqXHR) {
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
	    		//alert(list);
	    		alert("삭제 되었습니다.");
	    	//	showCodeGrid();
	    		$('#grid').trigger("reloadGrid");
	      	//	$('#detail').trigger("reloadGrid");
	      	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     	alert("일괄처리 오류입니다!>>");
	    }
	});
}
function modifyEmpInfo(){
	modiEmpBeanList=[];
	var copyempBean=ObjectCopy(empBean);
	copyempBean.empNo=$('#empNo').val();
	copyempBean.empTel=$('#empTel').val();
	copyempBean.empPhone=$('#empPhone').val();
	copyempBean.empEmail=$('#empEmail').val();
	copyempBean.empZip=$('#empZipcode').val();
	copyempBean.empAddr=$('#empAddress').val();
	copyempBean.empHiredate=$('#empDate').val();//입사일자 수정 추가 
	copyempBean.empFilename=$('#empFilename').val();
	copyempBean.empTempfilename=$('#empFilename').val();
	copyempBean.status="update";
	modiEmpBeanList.push(copyempBean);
}

function deleteEmpInfo(){
	delEmpBeanList=[];
var deleteList = $('#grid').jqGrid('getGridParam','selarrrow');
//	alert("업데이트 리스트"+updateList);
//	alert("삭제 리스트"+deleteList);
for(var inde=0; inde<deleteList.length; inde++){
	var copyempBean=ObjectCopy(empBean);
	copyempBean.empNo=$("#grid").getRowData(deleteList[inde]).empNo;
	copyempBean.status='delete';
	delEmpBeanList.push(copyempBean);
}

}
function showEmpGrid(){
	$('#grid').jqGrid({
		url:'emp.do?oper=getEmpList',
		datatype:'json',
        jsonReader:{
        	page :'page',	
        	total:'total',
        	root:'list'
        },
		beforeProcessing:function(data){
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
			  	dataSet=data.list;
 				empBean=data.empBean;
 			}
		},
		colNames:['사원번호','이 름','부서명'],
		colModel:[
		{name:'empNo',width:20, editable:false},
		{name:'empName',width:25, editable:false},
		{name:'deptName',width:30, editable:false}
		],
	     ondblClickRow : function (id) {
			index=id-1;
 		//	showMoreDetail();
			setEmpInfo();
			$("#moreDetailTabs").css({'display':'block'});
			
	    },
	    //editurl:"${pageContext.request.contextPath}/emp/emp.do",
		width:300,
    	height:300,
		viewrecords: true,
   		multiselect : true,
   		multiboxonly : true,
   		cellsubmit : 'clientArray',
   		rownumbers: true,
		sortname: 'empNo',
		sortorder: 'desc',
		sortable: true,
    	rowNum:6,
    	rowList:[3,6,9],
    	pager:'#pager',
  		caption:'사원리스트'
	});
	$("#grid").jqGrid('navGrid',"#pager",
		{add:false,edit:false,del:false}, //options
		{}, // edit options
		{}, // add options
		{}, //del options
		{multipleSearch:true} // search options
	);
}
function xmlEmpList(){
	alert("xml리스트");
	 $.ajax({
	   url:"emp.do?oper=getEmpXmlList",
	   cache:false,
	   dataType:'xml',
	   success:function(data){
		   alert(data);
	    var XmlList =$(data).find("emp-bean");
	    //왜 이름이 emp-bean이 되지???? 매핑방식? 
	    var len=XmlList.length;
	    var str="";
	    for(var i=0;i<len;i++){
	    	 var empNo =XmlList.eq(i).find("emp-no").text();
	  	    var empName =XmlList.eq(i).find("emp-name").text();
	  	    var empHiredate =XmlList.eq(i).find("emp-hiredate").text();
	  	    var xsi =XmlList.eq(i).attr("xsi:type");
	  	    var xmlns =XmlList.eq(i).attr("xmlns:java");
	  	    str+="("+i+")번 사원"+"empno:"+empNo+",empname:"+empName+",empHiredate:"+empHiredate;
	    }
	    alert(str);
	   }
	  });
}
function ObjectCopy(obj){
	//controller -> view :json객체
	//stringify : json객체 -> json텍스트 
	//parse : json텍스트 -> 스크립트 객체 
	 return JSON.parse(JSON.stringify(obj));
}
</script>
<table>
	<tr>
		<td valign="top" align="center">
			<table>
				<tr>
					<td id="infotable">
						<table id="grid"></table>
						<div id="pager"></div>
					</td>
				</tr>
				<tr>
					<td><input type="button" id="adEmp" value="사원등록"> <input
						type="button" id="delEmp" value="삭제"></td>
				</tr>
			</table>
		</td>
		<td valign="top">
			<div id="moreDetailTabs">
				<ul>
					<li style="font-size: 13px">사원정보</li>
				</ul>
				<div id="empDetail">
					<input type="hidden" id="empFilename" name="empFilename">
					<table id="empinfo">
						<tr>
							<td width="100px" valign="top"><iframe name="imgFrame"
									id="imgFrame" src="saveImg.do" scrolling="no" frameborder="0"
									allowfullscreen width="200px" height="250px"></iframe></td>
							<td width="700px" valign="top">
								<table align="center">
									<tr>
										<td><label>사원번호 : </label></td>
										<td><input type=text id="empNo" name="empNo" size=7
											readonly="readonly"></td>
									</tr>
									<tr>
										<td><label>이 름 : </label></td>
										<td><div id="empName"></div></td>
									</tr>
									<tr>
										<td><label>주민등록번호 : </label></td>
										<td><div id="empRegno"></div></td>
									</tr>
									<tr>
										<td><label>성별 : </label></td>
										<td><div id="empGender"></div></td>
									</tr>
									<tr>
										<td><label>입사일자: </label></td>
										<td><input type=text id="empDate" name="empDate" size=10></td>
									</tr>
									<tr>
										<td><label>전화번호: </label></td>
										<td><input type=text id="empTel" name="empTel" size=20></td>
									</tr>
									<tr>
										<td><label>휴대번호: </label></td>
										<td><input type=text id="empPhone" name="empPhone"
											size=20></td>
									</tr>
									<tr>
										<td><label>이 메 일: </label></td>
										<td><input type=text id="empEmail" name="empEmail"
											size=20></td>
									</tr>
									<tr>
										<td><label>우편번호: </label></td>
										<td><input type=text id="empZipcode" name="empZipcode"
											size=7> <input type="button" id="zipBtn" value="우편번호"></td>
									</tr>
									<tr>
										<td><label>주 소: </label></td>
										<td><input type=text id="empAddress" name="empAddress"
											size=50></td>
									</tr>
									<tr>
										<td><label>부서: </label></td>
										<td><span id="deptName"></span><span id="empDept"></span></td>
									</tr>
									<tr>
										<td><label>직급: </label></td>
										<td><span id="positionName"></span><span id="empPosition"></span></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center" style="font-size: 12px"><input
								type="button" id="modiEmp" value="수정"> <input
								type="button" id="modiCancel" value="취소"></td>
						</tr>
					</table>
				</div>
			</div>
		</td>
	</tr>
</table>
