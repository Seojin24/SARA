<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
#grid{font-size:18px;}
#detail{font-size:18px;}
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
var categoryCodeBean;
var CodeInfoBean;
var codeInfoBeanList;
var index;
$(document).ready(function(){
// 	alert("리스트폼");
	$('#detailtab').css({'display':'none'})
	showCodeGrid();
	$('#addcode').button().click(function(){
	var nextRowId=$("#detail").getGridParam("records");
    
	var tempcodeBean=ObjectCopy(CodeInfoBean);
		tempcodeBean.status="insert";
		alert("새로운 행이 추가되었습니다.");
   // tempcodeBean.CATEGORY_CODE=document.getElementById("empNo").value;
    $("#detail").addRowData(Number(nextRowId)+1,tempcodeBean);
	});
	$('#allProcess').button().click(all);
	$('#reload').button().click(function(){
		$("#detail").trigger("reloadGrid");
		showDetailCode();
		
	});
	
});
function ObjectCopy(obj){
	 return JSON.parse(JSON.stringify(obj));
}
function all(){
	
	modifyCodeInfo();
	var list='{"codeBean":'+$.toJSON(categoryCodeBean)+'}';
	allProcess(list);
	showCodeGrid();
	showDetailCode();
	$('#detailtab').css({'display':'none'});
}
function allProcess(list){
	alert(list);
	$.ajax({
	    url : 'code.do?oper=batchCode',
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
	    		$('#grid').trigger("reloadGrid");
	      	//	$('#detail').trigger("reloadGrid");
	      	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     	alert("일괄처리 오류입니다!>>");
	    }
	});
	
	
}
function modifyCodeInfo(){
	
	var updateList = $('#detail').getChangedCells('all');
	var deleteList = $('#detail').jqGrid('getGridParam','selarrrow');
 //	alert("업데이트 리스트"+updateList);
// 	alert("삭제 리스트"+deleteList);
	for(var inde=0; inde<deleteList.length; inde++){
		var copyCodeInfoBean=ObjectCopy(CodeInfoBean);
		copyCodeInfoBean.categoryCode=dataset[index].categoryCode;
		copyCodeInfoBean.detailCode=$("#detail").getRowData(deleteList[inde]).detailCode;
		copyCodeInfoBean.status='delete';
		codeInfoBeanList.push(copyCodeInfoBean);
	}
	for(var inde=0; inde<updateList.length; inde++){
		var copyCodeInfoBean=ObjectCopy(CodeInfoBean);
		alert(dataset[index].CATEGORYCODE);
		copyCodeInfoBean.categoryCode=dataset[index].categoryCode;
		copyCodeInfoBean.detailCode=updateList[inde].detailCode;
		copyCodeInfoBean.detailName=updateList[inde].detailName;
		copyCodeInfoBean.useWhether=updateList[inde].useWhether;
		
		if(updateList[inde].status=="insert")copyCodeInfoBean.status='insert';
		else copyCodeInfoBean.status='update';
		codeInfoBeanList.push(copyCodeInfoBean);
	}
	categoryCodeBean.codeInfoBeanList=codeInfoBeanList;
	
	
}
function showCodeGrid(){
	$('#grid').jqGrid({
		url:'code.do?oper=getCategoryCodeList',
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
				categoryCodeBean=data.CategoryCodeBean;
				CodeInfoBean=data.CodeInfoBean;
				codeInfoBeanList=categoryCodeBean.codeInfoBeanList;
 			 	alert(codeInfoBeanList);
 			}
		},
		colNames:['구분코드','코드이름','수정여부'],
		colModel:[
		{name:'categoryCode',width:15, editable:false,align:"center"},    
		{name:'categoryName',width:20, editable:false,align:"center"},
		{name:'modiWhether',width:10, editable:false,align:"center"}
		],
		ondblClickRow : function (id) {
			index=id-1;
		//	alert(dataset[index].CATEGORY_CODE)
			showDetailCode();
			$('#detailtab').css({'display':'block'});
	    },
	    //editurl:"${pageContext.request.contextPath}/emp/emp.do",
		width:300,
    	height:300,
		viewrecords: true,
   	//	multiselect : true,
   		multiboxonly : true,
   		cellsubmit : 'clientArray',
   		rownumbers: true,
		sortname: 'CATEGORYCODE',
		sortorder: 'desc',
		sortable: true,
		rowNum:13,
    	rowList:[3,6,9],
    	pager:'#pager',
  		caption:'코드리스트'
	});
	$("#grid").jqGrid('navGrid',"#pager",
		{add:false,edit:false,del:false}, //options
		{}, // edit options
		{}, // add options
		{}, //del options
		{multipleSearch:true} // search options
	);
}

function showDetailCode(){
//	alert("디테일")
// 	$("#detail").jqGrid("GridUnload")
	$('#detail').jqGrid({
		
		datatype:'json',
        jsonReader:{
        	page :'page',	
        	total:'total',
        	root:'dataset'
        },

		colNames:['상세코드','코드이름','사용여부','상태'],
		colModel:[
		{name:'detailCode',width:20, editable:true,align:"center"},    
		{name:'detailName',width:20, editable:true,align:"center"},
		{name:'useWhether',width:10, editable:true, edittype:"select",editoptions:{value:"1:Y;2:N"},align:"center"},
		{name:'status',width:10, editable:false, hidden:true},
		
		],
		
	    //editurl:"${pageContext.request.contextPath}/emp/emp.do",
		clearGridData: true,
	    width:350,
    	height:300,
		viewrecords: true,
		cellEdit: true,
		multiselect : true,
   		multiboxonly : true,
   		cellsubmit : 'clientArray',
   		rownumbers: true,
		sortname: 'detailCode',
		sortorder: 'desc',
		sortable: true,
    	rowNum:6,
    	rowList:[3,6,9],
    	pager:'#dpager',
  		caption:'상세코드리스트'
	});
	$("#detail").jqGrid('navGrid',"#dpager", //options
		{add:false,edit:false,del:false},	
		{}, // edit options
		{}, // add options
		{}, //del options
		{} // search options
	);
	$('#detail').clearGridData();
	for(var i=0;i<dataset[index].codeInfoBeanList.length;i++){
        $('#detail').addRowData(i,(dataset[index].codeInfoBeanList)[i]);
	}
	}


</script>
	<table>
	<tr>
	<td>
	<table id="grid"></table>
  	<div id="pager"></div>
  	
  	</td>
  	<td valign="top" id="detailtab" style="text-align:center">
  	
  	<table id="detail"></table>
  	<div id="dpager"></div>
  	<input type="button" id="addcode" value="코드추가">
  	<input type="button" id="allProcess" value="일괄처리">
  	<input type="button" id="reload" value="새로고침">
  	
  	</td>
  	</tr>
  	 </table> 
  