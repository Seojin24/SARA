<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<style>
#bomGrid{font-size:20px;}
</style>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sunny/jquery-ui.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/scripts/css/ui.jqgrid.css" />
   
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/scripts/js/i18n/grid.locale-en.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/scripts/js/jquery.jqGrid.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/jquery-ui-1.9.2.custom.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.json-2.3.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.form.js"></script>
<script>
var index;
var bomBean;
var bomBeanList;
var dataSet;
$(document).ready(function(){
	//봄관리와 봄정전개???? 봄관리는 -->모든 자재 리스트 뽑기 
	//봄정전개는 모품목 등록시 --->자재 모두 나오게 하기 
	//"#bomregister" BOM 관리
	//"#blist" BOM 정전개
	$('#jungjun').tabs();
	//BOM관리 -> +버튼 ->searchItem.jsp 
	$('#pSearch').button().click(function(){ 
	var features = 'width=580px; height=520px; left=550px; top=150px; titlebar=no; status=no';
   window.open('${pageContext.request.contextPath}/product/searchItem.do?code="parent"&p=1','모품목검색',features);
	});
	//BOM정전개 -> +버튼 ->searchItem.jsp 
	$('#bpSearch').button().click(function(){
	var features = 'width=580px; height=520px; left=550px; top=150px; titlebar=no; status=no';
   window.open('${pageContext.request.contextPath}/product/searchItem.do?code="parent"&p=2','모품목검색',features);
	});
	//추가
		$('#bcSearch').button().click(function(){
		var features = 'width=580px; height=520px; left=550px; top=150px; titlebar=no; status=no';
	   window.open('${pageContext.request.contextPath}/product/searchItem.do?code="child"&c=2','자품목검색',features);
		});
	
	//추가
	
	
	$('#updateItem').button().click(all);
	$('#pRegi').button().click(parentSearch);
	$('#bpRegi').button().click(function(){
		//bom정전개->등록 
	alert("봄정전개");
	bparentSearch();
	});
	//추가
	$('#bcRegi').button().click(function(){
		alert("봄역전개");
		bchildSearch();
		});
	//추가
	
	$('#addItem').button().click(function(){
		if($('#pCode').val()==""){
     		alert("모품목을 먼저 선택해주세요");
     	}else{
     		addrow();
     	}
	});
		showBomGrid(); 
	});
	function parentSearch(){
		if($('#pCode').val()==""){
     		alert("모품목을 먼저 선택해주세요");
     	}else{
     		//alert("!");
     		$("#bomGrid").hideCol('level'); //여기서 문제 발생 
     		//alert("!");
     		$("#bomGrid").setGridParam({postData:{'parent': $('#pCode').val()},cellEdit:true}).trigger('reloadGrid'); 
     		$("#bomGrid").setCaption("모품목등록:"+$('#pCode').val());
     		
     	}
	}
function bparentSearch(){
		if($('#bpCode').val()==""){
     		alert("모품목을 먼저 선택해주세요");
     	}else{
     		$("#bomGrid").showCol('level');
     		$("#bomGrid").setGridParam({cellEdit:false,url:'bom.do?oper=getBomTree',postData:{'parent': $('#bpCode').val()}}).trigger('reloadGrid'); 
     		 $("#bomGrid").setCaption($('#bpCode').val()+"정전개");
     	}
}

function bchildSearch(){
	if($('#bcCode').val()==""){
 		alert("자품목을 먼저 선택해주세요");
 	}else{
 		$("#bomGrid").showCol('level');
 		$("#bomGrid").setGridParam({cellEdit:false,url:'bom.do?oper=getBomTree',postData:{'child': $('#bcCode').val()}}).trigger('reloadGrid'); 
 		 $("#bomGrid").setCaption($('#bcCode').val()+"역전개");
 	}
}
function all(){
	modifyBomInfo();
	var list='{"bomBean":'+$.toJSON(bomBeanList)+'}';
	allProcess(list);
}
function allProcess(list){
alert(list);
	$.ajax({
	    url : 'bom.do?oper=batchBom',  //'local'
	    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	    type : 'post',
	    data :{'list':list},
	    success : function(data, textStatus, jqXHR) {
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
	    		alert(list);
	    		alert("처리 되었습니다.");
	    	//	showCodeGrid();
	    		$('#bomGrid').trigger("reloadGrid");
	      	//	$('#detail').trigger("reloadGrid");
	      	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     	alert("일괄처리 오류입니다!>>");
	    }
	});
}
function modifyBomInfo(){
	bomBeanList=[];
	var updateList = $('#bomGrid').getChangedCells('all');
	var deleteList = $('#bomGrid').jqGrid('getGridParam','selarrrow');
 //	alert("업데이트 리스트"+updateList);
// 	alert("삭제 리스트"+deleteList);
	for(var inde=0; inde<deleteList.length; inde++){
		var copybomBean=ObjectCopy(bomBean);
		copybomBean.itemCode=$("#bomGrid").getRowData(deleteList[inde]).itemCode;
		copybomBean.parentItemCode=$("#bomGrid").getRowData(deleteList[inde]).parentItemCode;
		copybomBean.status='delete';
		bomBeanList.push(copybomBean);
	}
	for(var inde=0; inde<updateList.length; inde++){
		var copybomBean=ObjectCopy(bomBean);
	//	alert(dataset[index].CATEGORY_CODE);
		copybomBean.itemCode=updateList[inde].itemCode;
		copybomBean.parentItemCode=updateList[inde].parentItemCode;
		copybomBean.netQuantity=updateList[inde].netQuantity;
		copybomBean.demandQuantity=updateList[inde].demandQuantity;
		if(updateList[inde].status=="insert")copybomBean.status='insert';
		else copybomBean.status='update';
		bomBeanList.push(copybomBean);
	}
}
function ObjectCopy(obj){
	 return JSON.parse(JSON.stringify(obj));
}
function addrow(){
	$("#bomGrid").jqGrid('addRow', {
        rowID : index,          //중복되지 않게 rowid설정
        initdata:{
        	parentItemCode : $('#pCode').val()
        },
        position:"last",
        addRowParams:{extraparam:{}},
        useDefValues : true,
        useFormatter : true
		});
}
function showBomGrid(){ //BOM관리  
	$('#bomGrid').jqGrid({
		url:'bom.do?oper=getBomList',
		postData:{'parent':$('#pCode').val()},
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
				//alert(data);
 				dataSet=data.list;
 				bomBean=data.BomBean;
 			}
		},
		colNames:['Level','품번코드','품명','단위','필요수량','LOSS(%)','정미수량','계정','status','부모코드'],
		colModel:[
		{name:'level',width:23, editable:false,align:"center",hidden:true},   
		{name:'itemCode',width:40, editable:false,align:"center"},
		{name:'itemName',width:20, editable:false,align:"center"},
		{name:'unit',width:10, editable:false,align:"center"},    
		{name:'demandQuantity',width:10, editable:false,align:"center"},
		{name:'lossfactor',width:10, editable:false,align:"center"},  
		{name:'netQuantity',width:10, editable:true,align:"center"},
		{name:'gradeName',width:25, editable:false,align:"center"},
		{name:"status",width:5, editable:false , hidden:true},
		{name:"parentItemCode",width:23, editable:false,hidden:true}
		],
		onSelectRow : function (id) {
			index=id-1;
	    },
	    onCellSelect : function(index,iCol,cellcontent,e){
			alert(iCol);
 			if(iCol==2){				//하위품목검색
 		   		 var features = 'width=580px; height=520px; left=550px; top=150px;';
 		   		 window.open('${pageContext.request.contextPath}/product/searchItem.do?code="bomlist"', '하위품목검색', features);
	     	}
		},
		width:800,
    	height:400,
		viewrecords: true,
   		multiselect : true,
   		multiboxonly : true,
   		cellsubmit : 'clientArray',
   		rownumbers: true,
		sortname: 'itemCode',
		sortorder: 'desc',
		sortable: true,
		rowNum:13,
		cellEdit:true,
    	rowList:[3,6,9],
    	pager:'#pager',
  		caption:'',
  		treeGrid:true,
    	 ExpandColumn:"itemCode",
    	 treedatatype:"json",
      	treeGridModel:"adjacency",
      	treeReader:{
         parent_id_field : "parentItemCode",
         //left_field : "lft",
         //right_field : "rgt",
         level_field : "level",
         leaf_field : "lf"   //자식노드를 가지고 있지않으면 false
         //expanded_field : "expanded",
         //loaded : "loaded",
         //icon_field : "icon"
      },
  		afterSaveCell: function(rowid,name,val,iRow,iCol) {
			var netNumber=$('#bomGrid').getCell(rowid,'netQuantity' );
 			var lossNumber=$('#bomGrid').getCell(rowid,'lossfactor' );
 			var demandQuantity=Number(netNumber)*(1+Number(lossNumber));
 			$('#bomGrid').setCell(rowid,'demandQuantity',Math.round(demandQuantity*100)/100);
 			var statusCheck = $('#bomGrid').getCell(rowid,'status');
 			if(statusCheck==""){
 				$('#bomGrid').setCell(rowid,'status',"update");
			}
		}
	});
	$("#bomPager").jqGrid('navGrid',"#pager",
		{add:false,edit:false,del:false}, //options
		{}, // edit options
		{}, // add options
		{}, //del options
		{multipleSearch:true} // search options
	);
}
</script>
<div id="jungjun" style="width:900px">
<ul>
<li><a href="#bomregister">BOM 관리</a></li>
<li><a href="#blist">BOM 정전개</a></li>
<li><a href="#bclist">BOM 역전개</a></li>
</ul>
<div id="bomregister">
   <label>모품목코드:</label>
   <input type="text" readonly="readonly" id="pCode">
   <label>품목명:</label>
   <input type="text" readonly="readonly" id="pName">
   <input  type="button" value="+" id="pSearch" >
   <input  type="button" value="등록" id="pRegi" >
   <input type="button" id="addItem" value="품목추가">
   <input type="button" id="updateItem" value="Update">  
</div>
<div id="blist">
<label>모품목코드:</label>
   <input type="text" readonly="readonly" id="bpCode">
   <label>품목명:</label>
   <input type="text" readonly="readonly" id="bpName">
   <input  type="button" value="+" id="bpSearch">
   <input  type="button" value="조회" id="bpRegi">
</div>
<div id="bclist">
<label>자품목코드:</label>
   <input type="text" readonly="readonly" id="bcCode">
   <label>품목명:</label>
   <input type="text" readonly="readonly" id="bcName">
   <input  type="button" value="+" id="bcSearch">
   <input  type="button" value="조회" id="bcRegi">
</div>
<table id="bomGrid"></table>
<div id="bomPager"></div>
</div>