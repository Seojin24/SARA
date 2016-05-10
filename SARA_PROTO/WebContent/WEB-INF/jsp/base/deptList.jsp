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
<script>
var dataset;
var index;
$(document).ready(function(){
	showDeptList();
})
function showDeptList(){
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
 			}
		},
		colNames:['부서코드','부서이름'],
		colModel:[
		{name:'deptCode',width:20, editable:false,align:"center"},    
		{name:'deptName',width:20, editable:false,align:"center"},
		],
		onSelectRow: function(id){
   			index=id-1;
   			insertDept();
   		},
		width:400,
    	height:300,
    	viewrecords: true,
   		multiboxonly : true,
   		cellsubmit : 'clientArray',
   		rownumbers: true,
		sortname: 'deptCode',
		sortorder: 'desc',
		sortable: true,
		rowNum:10,
    	rowList:[3,6,9],
    	pager:'#pager',
  		caption:'부서리스트'
	});
	function insertDept(){
		//alert("aa");
		var deptcode=dataset[index].deptCode;
		opener.document.getElementById("deptNo").value=deptcode;
		window.close();
	} 	
}
</script>
<table id="deptGrid"></table>
<div id="pager"></div>