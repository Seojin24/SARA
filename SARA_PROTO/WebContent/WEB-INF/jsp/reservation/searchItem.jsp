<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sunny/jquery-ui.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/scripts/css/ui.jqgrid.css" />
   
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/scripts/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/scripts/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui-1.9.2.custom.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.json-2.3.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<style>
#itemGrid{font-size:20px;}
</style>
<script type="text/javascript">
var itemBean;
var dataset;
var index;
var codeName;
var rowid=$("#bomGrid",opener.document).jqGrid('getGridParam','selrow');
var orderRid=$("#orderGrid",opener.document).jqGrid('getGridParam','selrow');
var parentcode;
$(document).ready(function(){
	codeName = ${param.code};
//	alert(codeName);
//BOM관리의 bom register 페이지에 + 버튼--->code="parent"
	if (codeName=="parent"){
		showParentItemList(); 
	}else if(codeName=="bomlist"){
		showItemList();
	}else if(codeName=="child"){
		showChildItemList();
	}else{
		showCodeGrid();
	}
});
function showParentItemList(){
	$('#itemGrid').jqGrid({
		url:'item.do?oper=getpItemList', // 모품목 리스트 
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
				dataset=data.list;//여긴 왜 빈 bean 객체 안보내지??? -- 왜냐면 list만
						//받아올 거 라서 
 			}
		},
		colNames:['모품목코드','품목명','계정'],
		colModel:[
		{name:'itemCode',width:20, editable:false,align:"center"},    
		{name:'itemName',width:20, editable:false,align:"center"},
		{name:'gradeName',width:20, editable:false,align:"center"}
		],
		onSelectRow: function(id){
   			index=id-1;
   			parentcode='${param.p}';
   			if(parentcode==1){
   			insertParentCode();
   			}else if(parentcode==3){insertOrderCode();
   			}else{insertbParentCode();}
   		},
		width:600,
    	height:400,
//     	loadonce:true,
//         mtype: "GET",
    	viewrecords: true,
   		multiboxonly : true,
   		cellsubmit : 'clientArray',
   		rownumbers: true,
		sortname: 'itemCode',
		sortorder: 'desc',
		sortable: true,
		rowNum:10,
    	rowList:[3,6,9],
    	pager:'#pager',
  		caption:'모품목리스트'
	});
// 	jQuery("#itemGrid").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false})
}

function showChildItemList(){
	$('#itemGrid').jqGrid({
		url:'item.do?oper=getcItemList', // 모품목 리스트 
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
				dataset=data.list;//여긴 왜 빈 bean 객체 안보내지??? -- 왜냐면 list만
						//받아올 거 라서 
 			}
		},
		colNames:['자품목코드','품목명','계정'],
		colModel:[
		{name:'itemCode',width:20, editable:false,align:"center"},    
		{name:'itemName',width:20, editable:false,align:"center"},
		{name:'gradeName',width:20, editable:false,align:"center"}
		],
		onSelectRow: function(id){
   			index=id-1;
   			childcode='${param.c}';
   			insertbChildCode();
   		},
		width:600,
    	height:400,
//     	loadonce:true,
//         mtype: "GET",
    	viewrecords: true,
   		multiboxonly : true,
   		cellsubmit : 'clientArray',
   		rownumbers: true,
		sortname: 'itemCode',
		sortorder: 'desc',
		sortable: true,
		rowNum:10,
    	rowList:[3,6,9],
    	pager:'#pager',
  		caption:'모품목리스트'
	});
// 	jQuery("#itemGrid").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false})
}
function showItemList(){
	$('#itemGrid').jqGrid({
		url:'item.do?oper=getBomItemList',
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
		colNames:['품목코드','품목명','계정'],
		colModel:[
		{name:'itemCode',width:20, editable:false,align:"center"},    
		{name:'itemName',width:20, editable:false,align:"center"},
		{name:'gradeName',width:20, editable:false,align:"center"}
		],
		onSelectRow: function(id){
   			index=id-1;
   			insertItemCode();
   		},
		width:600,
    	height:400,
    	viewrecords: true,
   		multiboxonly : true,
   		cellsubmit : 'clientArray',
   		rownumbers: true,
// 		loadonce:true,
//     	mtype: "GET",
		sortname: 'itemCode',
		sortorder: 'desc',
		sortable: true,
		rowNum:10,
    	rowList:[3,6,9],
    	pager:'#pager',
  		caption:'품목리스트'
	});
// 	jQuery("#itemGrid").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false})
}
function insertParentCode(){
	var code=dataset[index].itemCode;
	var name=dataset[index].itemName;
	opener.document.getElementById('pCode').value=code;
	opener.document.getElementById('pName').value=name;
	window.close();
}
function insertOrderCode(){
	$('#orderGrid',opener.document).setCell(orderRid, 'itemCode', dataset[index].itemCode);
	$('#orderGrid',opener.document).setCell(orderRid, 'itemName', dataset[index].itemName);
	window.close();
}
function insertbParentCode(){
	var code=dataset[index].itemCode;
	var name=dataset[index].itemName;
	opener.document.getElementById('bpCode').value=code;
	opener.document.getElementById('bpName').value=name;
	window.close();
}
function insertbChildCode(){
	var code=dataset[index].itemCode;
	var name=dataset[index].itemName;
	opener.document.getElementById('bcCode').value=code;
	opener.document.getElementById('bcName').value=name;
	window.close();
}

function insertItemCode(){
	$('#bomGrid',opener.document).setCell(rowid, 'itemCode', dataset[index].itemCode);
	$('#bomGrid',opener.document).setCell(rowid, 'itemName', dataset[index].itemName);
	$('#bomGrid',opener.document).setCell(rowid, 'gradeName', dataset[index].gradeName);
	$('#bomGrid',opener.document).setCell(rowid, 'unit', dataset[index].unit);
	$('#bomGrid',opener.document).setCell(rowid, 'lossfactor', dataset[index].lossFactor);
	$('#bomGrid',opener.document).setCell(rowid, 'status', "insert");
	window.close();
}
</script>
<table id="itemGrid"></table>
<div id="pager"></div>