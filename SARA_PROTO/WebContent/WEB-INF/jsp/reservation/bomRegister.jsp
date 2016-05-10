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
	//�������� ��������???? �������� -->��� ���� ����Ʈ �̱� 
	//���������� ��ǰ�� ��Ͻ� --->���� ��� ������ �ϱ� 
	//"#bomregister" BOM ����
	//"#blist" BOM ������
	$('#jungjun').tabs();
	//BOM���� -> +��ư ->searchItem.jsp 
	$('#pSearch').button().click(function(){ 
	var features = 'width=580px; height=520px; left=550px; top=150px; titlebar=no; status=no';
   window.open('${pageContext.request.contextPath}/product/searchItem.do?code="parent"&p=1','��ǰ��˻�',features);
	});
	//BOM������ -> +��ư ->searchItem.jsp 
	$('#bpSearch').button().click(function(){
	var features = 'width=580px; height=520px; left=550px; top=150px; titlebar=no; status=no';
   window.open('${pageContext.request.contextPath}/product/searchItem.do?code="parent"&p=2','��ǰ��˻�',features);
	});
	//�߰�
		$('#bcSearch').button().click(function(){
		var features = 'width=580px; height=520px; left=550px; top=150px; titlebar=no; status=no';
	   window.open('${pageContext.request.contextPath}/product/searchItem.do?code="child"&c=2','��ǰ��˻�',features);
		});
	
	//�߰�
	
	
	$('#updateItem').button().click(all);
	$('#pRegi').button().click(parentSearch);
	$('#bpRegi').button().click(function(){
		//bom������->��� 
	alert("��������");
	bparentSearch();
	});
	//�߰�
	$('#bcRegi').button().click(function(){
		alert("��������");
		bchildSearch();
		});
	//�߰�
	
	$('#addItem').button().click(function(){
		if($('#pCode').val()==""){
     		alert("��ǰ���� ���� �������ּ���");
     	}else{
     		addrow();
     	}
	});
		showBomGrid(); 
	});
	function parentSearch(){
		if($('#pCode').val()==""){
     		alert("��ǰ���� ���� �������ּ���");
     	}else{
     		//alert("!");
     		$("#bomGrid").hideCol('level'); //���⼭ ���� �߻� 
     		//alert("!");
     		$("#bomGrid").setGridParam({postData:{'parent': $('#pCode').val()},cellEdit:true}).trigger('reloadGrid'); 
     		$("#bomGrid").setCaption("��ǰ����:"+$('#pCode').val());
     		
     	}
	}
function bparentSearch(){
		if($('#bpCode').val()==""){
     		alert("��ǰ���� ���� �������ּ���");
     	}else{
     		$("#bomGrid").showCol('level');
     		$("#bomGrid").setGridParam({cellEdit:false,url:'bom.do?oper=getBomTree',postData:{'parent': $('#bpCode').val()}}).trigger('reloadGrid'); 
     		 $("#bomGrid").setCaption($('#bpCode').val()+"������");
     	}
}

function bchildSearch(){
	if($('#bcCode').val()==""){
 		alert("��ǰ���� ���� �������ּ���");
 	}else{
 		$("#bomGrid").showCol('level');
 		$("#bomGrid").setGridParam({cellEdit:false,url:'bom.do?oper=getBomTree',postData:{'child': $('#bcCode').val()}}).trigger('reloadGrid'); 
 		 $("#bomGrid").setCaption($('#bcCode').val()+"������");
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
	    		alert("ó�� �Ǿ����ϴ�.");
	    	//	showCodeGrid();
	    		$('#bomGrid').trigger("reloadGrid");
	      	//	$('#detail').trigger("reloadGrid");
	      	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     	alert("�ϰ�ó�� �����Դϴ�!>>");
	    }
	});
}
function modifyBomInfo(){
	bomBeanList=[];
	var updateList = $('#bomGrid').getChangedCells('all');
	var deleteList = $('#bomGrid').jqGrid('getGridParam','selarrrow');
 //	alert("������Ʈ ����Ʈ"+updateList);
// 	alert("���� ����Ʈ"+deleteList);
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
        rowID : index,          //�ߺ����� �ʰ� rowid����
        initdata:{
        	parentItemCode : $('#pCode').val()
        },
        position:"last",
        addRowParams:{extraparam:{}},
        useDefValues : true,
        useFormatter : true
		});
}
function showBomGrid(){ //BOM����  
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
		colNames:['Level','ǰ���ڵ�','ǰ��','����','�ʿ����','LOSS(%)','���̼���','����','status','�θ��ڵ�'],
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
 			if(iCol==2){				//����ǰ��˻�
 		   		 var features = 'width=580px; height=520px; left=550px; top=150px;';
 		   		 window.open('${pageContext.request.contextPath}/product/searchItem.do?code="bomlist"', '����ǰ��˻�', features);
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
         leaf_field : "lf"   //�ڽĳ�带 ������ ���������� false
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
<li><a href="#bomregister">BOM ����</a></li>
<li><a href="#blist">BOM ������</a></li>
<li><a href="#bclist">BOM ������</a></li>
</ul>
<div id="bomregister">
   <label>��ǰ���ڵ�:</label>
   <input type="text" readonly="readonly" id="pCode">
   <label>ǰ���:</label>
   <input type="text" readonly="readonly" id="pName">
   <input  type="button" value="+" id="pSearch" >
   <input  type="button" value="���" id="pRegi" >
   <input type="button" id="addItem" value="ǰ���߰�">
   <input type="button" id="updateItem" value="Update">  
</div>
<div id="blist">
<label>��ǰ���ڵ�:</label>
   <input type="text" readonly="readonly" id="bpCode">
   <label>ǰ���:</label>
   <input type="text" readonly="readonly" id="bpName">
   <input  type="button" value="+" id="bpSearch">
   <input  type="button" value="��ȸ" id="bpRegi">
</div>
<div id="bclist">
<label>��ǰ���ڵ�:</label>
   <input type="text" readonly="readonly" id="bcCode">
   <label>ǰ���:</label>
   <input type="text" readonly="readonly" id="bcName">
   <input  type="button" value="+" id="bcSearch">
   <input  type="button" value="��ȸ" id="bcRegi">
</div>
<table id="bomGrid"></table>
<div id="bomPager"></div>
</div>