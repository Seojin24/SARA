<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
td{font-size:15px;}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sunny/jquery-ui.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/scripts/css/ui.jqgrid.css" />
   
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/scripts/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/scripts/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui-1.9.2.custom.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.json-2.3.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<script type="text/javascript">
var dataset;
var deptBean;
var index;
var deptBeanList;
$(document).ready(function(){
	$("#addDept").button().click(addrow);
	$("#allProcess").button().click(all);
	$("#reload").button().click(function(){
		$("#deptGrid").trigger("reloadGrid");
	});
	showDeptGrid();
	$("#deptList").button().click(function(){
		var style = 'width=450px; height=450px; left=550px; top=150px; titlebar=no; status=no';
        window.open('${pageContext.request.contextPath}/base/deptList.do','부서검색',style);
		
	})
	
	
	
	
	
	
})
function all(){
	modifyDeptInfo();
	var list='{"deptBean":'+$.toJSON(deptBeanList)+'}';
	allProcess(list);
}

function allProcess(list){
	alert(list);
	$.ajax({
	    url : 'dept.do?oper=batchDept',  //'local'
	    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	    type : 'post',
	    data :{'list':list},
	    success : function(data, textStatus, jqXHR) {
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
	    		//alert(list);
	    		alert("처리 되었습니다.");
	    	//	showCodeGrid();
	    		$('#deptGrid').trigger("reloadGrid");
	      	//	$('#detail').trigger("reloadGrid");
	      	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     	alert("일괄처리 오류입니다!>>");
	    }
	});
	
	
	
	
}
function modifyDeptInfo(){
		deptBeanList=[];
	var updateList = $('#deptGrid').getChangedCells('all');
	var deleteList = $('#deptGrid').jqGrid('getGridParam','selarrrow');
 //	alert("업데이트 리스트"+updateList);
// 	alert("삭제 리스트"+deleteList);
	for(var inde=0; inde<deleteList.length; inde++){
		var copydeptBean=ObjectCopy(deptBean);
		copydeptBean.deptCode=$("#deptGrid").getRowData(deleteList[inde]).deptCode;
		copydeptBean.status='delete';
		deptBeanList.push(copydeptBean);
	}
	for(var inde=0; inde<updateList.length; inde++){
		var copydeptBean=ObjectCopy(deptBean);
	//	alert(dataset[index].CATEGORY_CODE);
		copydeptBean.deptCode=updateList[inde].deptCode;
		copydeptBean.deptName=updateList[inde].deptName;
		copydeptBean.deptHead=updateList[inde].deptHead;
		copydeptBean.deptTel=updateList[inde].deptTel;
		copydeptBean.useWhether=updateList[inde].useWhether;
		
		if(updateList[inde].status=="insert")copydeptBean.status='insert';
		else copydeptBean.status='update';
		deptBeanList.push(copydeptBean);
	}
	
}
function ObjectCopy(obj){
	 return JSON.parse(JSON.stringify(obj));
}
function addrow(){
var nextRowId=$("#deptGrid").getGridParam("records");
    
	var tempdeptBean=ObjectCopy(deptBean);
		tempdeptBean.status="insert";
		alert("새로운 행이 추가되었습니다.");
   // tempcodeBean.CATEGORY_CODE=document.getElementById("empNo").value;
    $("#deptGrid").addRowData(Number(nextRowId)+1,tempdeptBean);
	
	
	
}

function showDeptGrid(){
	$('#deptGrid').jqGrid({
		url:'dept.do?oper=getDeptList',
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
				dataset=data.list;
				deptBean=data.deptBean;
 				
 			}
		},
		colNames:['부서코드','부서이름','부서장','대표번호','사용여부','상태'],
		colModel:[
		{name:'deptCode',width:20, editable:true,align:"center"},    
		{name:'deptName',width:20, editable:true,align:"center"},
		{name:'deptHead',width:15, editable:true,align:"center"},
		{name:'deptTel',width:20, editable:true,align:"center"},    
		{name:'useWhether',width:15, editable:true,edittype:"select",editoptions:{value:"1:Y;2:N"},align:"center"},
		{name:'status',width:15, editable:false,align:"center" ,hidden:true},
		],
		ondblClickRow : function (id) {
			index=id-1;
		//	alert(dataset[index].CATEGORY_CODE)
		//	showDetailCode();
		//	$('#detailtab').css({'display':'block'});
	    },
	    //editurl:"${pageContext.request.contextPath}/emp/emp.do",
		width:600,
    	height:350,
    	cellEdit: true,
    	viewrecords: true,
   		multiselect : true,
   		multiboxonly : true,
   		cellsubmit : 'clientArray',
   		rownumbers: true,
		sortname: 'deptCode',
		sortorder: 'desc',
		sortable: true,
		rowNum:13,
    	rowList:[3,6,9],
    	pager:'#pager',
  		caption:'부서리스트'
	});
	$("#deptGrid").jqGrid('navGrid',"#pager",
		{add:false,edit:false,del:false}, //options
		{}, // edit options
		{}, // add options
		{}, //del options
		{multipleSearch:true} // search options
	);
}
</script>
<table>
<tr>
<td align="center">
<table id="deptGrid"></table>
  <div id="pager"></div>
  	<input type="button" id="addDept" value="부서추가">
  	<input type="button" id="allProcess" value="일괄처리">
  	<input type="button" id="reload" value="새로고침">
  	<input type="button" id="deptList" value="리스트창">
</td>
</tr>
</table>


