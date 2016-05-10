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
#codeGrid{font-size:20px;}
</style>
<script>
var dataset;
var index;
var rowid=$("#orderGrid",opener.document).jqGrid('getGridParam','selrow');
$(document).ready(function(){
//	alert("코드리스트");
//	alert('${param.code}'+'${param.p}')
	showCodeList();
})
function showCodeList(){
//	alert('${param.code}')
	$('#codeGrid').jqGrid({
		url:'code.do?oper=getCodeInfoList&code=${param.code}',
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
			//	alert($.toJSON(data));
				dataset=data.list;
 			}
		},
		colNames:['코드','코드명'],
		colModel:[
		{name:'detailCode',width:20, editable:false,align:"center"},    
		{name:'detailName',width:20, editable:false,align:"center"},
		],
		onSelectRow: function(id){
   			index=id-1;
   			var pCode='${param.p}';
   			if(pCode==4){
   				//insertWarehouse();
   				insertWorkplace();
   			}else{
   			insertCode();
   			}
   		},
		width:500,
    	height:400,
    	viewrecords: true,
   		multiboxonly : true,
   		cellsubmit : 'clientArray',
   		rownumbers: true,
		sortname: 'detailCode',
		sortorder: 'desc',
		sortable: true,
		rowNum:10,
    	rowList:[3,6,9],
    	pager:'#pager',
  		caption:'코드리스트'
	});
	
	function insertCode(){//alert("aa");
		var code=dataset[index].detailCode;
		opener.document.getElementById('${param.code}No').value=code;
		window.close();
	}
	function insertWorkplace(){
	$('#orderGrid',opener.document).setCell(rowid, 'workPlaceCode', dataset[index].detailCode);
		window.close();
	} 
}

</script>
<table id="codeGrid"></table>
<div id="pager"></div>