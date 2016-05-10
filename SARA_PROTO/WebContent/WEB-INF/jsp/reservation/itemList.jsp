<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<style>
#Itemgrid{font-size:20px;}
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
var dataSet;
var itemBean;
var index;
var modiItemBeanList;
var delItemBeanList;
$(document).ready(function(){
	$('#moreDetailTabs').tabs();
	$('#adItem').button().click(function(){
		var features = 'width=580px; height=480px; left=100px; top=10px; overflow=auto;';
        window.open('${pageContext.request.contextPath}/product/addItem.do','ǰ����', features);
		//addItem.do
	});
	$('#delItem').button().click(delItem);
	$('#modiItem').button().click(modifyItem);
	$('#modiCancel').button().click(function(){
		$('#moreDetailTabs').css({'display':'none'})
	});
	$('#GC').button().click(code);
	$('#PRO').button().click(code);
	$('#AC').button().click(code);
	
	showItemGrid();
});
function ObjectCopy(obj){
	 return JSON.parse(JSON.stringify(obj));
}
function delItem(){
	deleteItemInfo();
	var list='{"itemBeanList":'+$.toJSON(delItemBeanList)+'}';
	deleteProcess(list);
}
function deleteItemInfo(){
	delItemBeanList=[];
	var deleteList = $('#Itemgrid').jqGrid('getGridParam','selarrrow');
//		alert("������Ʈ ����Ʈ"+updateList);
//		alert("���� ����Ʈ"+deleteList);
	for(var inde=0; inde<deleteList.length; inde++){
		var copyitemBean=ObjectCopy(itemBean);
		copyitemBean.itemCode=$("#Itemgrid").getRowData(deleteList[inde]).itemCode;
		copyitemBean.status='delete';
		delItemBeanList.push(copyitemBean);
	}
	alert(delItemBeanList);
}
function deleteProcess(list){
	alert(list);
	$.ajax({
	    url : 'item.do?oper=batchItem',  //'local'
	    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	    type : 'post',
	    data :{'list':list},
	    success : function(data, textStatus, jqXHR) {
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
	    		//alert(list);
	    		alert("���� �Ǿ����ϴ�.");
	    	//	showCodeGrid();
	    		$('#Itemgrid').trigger("reloadGrid");
	      	//	$('#detail').trigger("reloadGrid");
	      	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     	alert("�ϰ�ó�� �����Դϴ�!>>");
	    }
	});
}
function modifyItem(){
	modifyItemInfo();
	var list='{"itemBeanList":'+$.toJSON(modiItemBeanList)+'}';
	modifyProcess(list);
	
	
}
function modifyItemInfo(){
	modiItemBeanList=[];
	var copyitemBean=ObjectCopy(itemBean);
	copyitemBean.itemCode=$('#itemNo').val();
	copyitemBean.gradeCode=$('#GCNo').val();
	copyitemBean.procurementCode=$('#PRONo').val();
	copyitemBean.unit=$('#unit').val();
	copyitemBean.lossFactor=$('#itemLoss').val();
	copyitemBean.standardCost=$('#itemCost').val();
	copyitemBean.leadTime=$('#leadtime').val();
	copyitemBean.accountCode=$('#ACNo').val();
	copyitemBean.status="update";
	modiItemBeanList.push(copyitemBean);
}
function modifyProcess(list){
	alert(list);
	$.ajax({
	    url : 'item.do?oper=batchItem',  //'local'
	    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	    type : 'post',

	    data :{'list':list},
	    success : function(data, textStatus, jqXHR) {
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
	    		//alert(list);
	    		alert("���� �Ǿ����ϴ�.");
	    	//	showCodeGrid();
	    		$('#Itemgrid').trigger("reloadGrid");
	      	//	$('#detail').trigger("reloadGrid");
	      	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     	alert("�ϰ�ó�� �����Դϴ�!>>");
	    }
	});
	
	
}
function code(){
	var features = 'width=580px; height=520px; left=550px; top=150px; titlebar=no; status=no';
  //  alert($(this).attr("id"));
	window.open('${pageContext.request.contextPath}/base/codeList.do?code='+$(this).attr("id"),'�ڵ�˻�',features);

}
function setItemInfo(){
	$('#iCategory').val(dataSet[index].icategoryCode);
	$('#itemNo').val(dataSet[index].itemCode);
	$('#itemName').val(dataSet[index].itemName);
	$('#GCNo').val(dataSet[index].gradeCode);
	$('#PRONo').val(dataSet[index].procurementCode);
	$('#unit').val(dataSet[index].unit);
	$('#itemLoss').val(dataSet[index].lossFactor);
	$('#itemCost').val(dataSet[index].standardCost);
	$('#leadtime').val(dataSet[index].leadTime);
	$('#ACNo').val(dataSet[index].accountCode);

}

function showItemGrid(){
	$('#Itemgrid').jqGrid({
		url:'item.do?oper=getItemList',//item���� list�� ������ 
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
				//alert("����")
			  	dataSet=data.list;
 			 	itemBean=data.itemBean;
 			}
		},
		colNames:['ǰ���ڵ�','ǰ���','����'],
		colModel:[
		{name:'itemCode',width:20, editable:false},
		{name:'itemName',width:20, editable:false},
		{name:'gradeName',width:10, editable:false}	
		],
		ondblClickRow : function (id) {
			index=id-1;
			$("#moreDetailTabs").tabs().css({'display':'block'});
			setItemInfo();
	    },
	    //editurl:"${pageContext.request.contextPath}/emp/emp.do",
		width:300,
    	height:300,
		viewrecords: true,
   		multiselect : true,
   		multiboxonly : true,
//    		loadonce:true,
//      	 mtype: "GET",
   		cellsubmit : 'clientArray',
   		rownumbers: true,
		sortname: 'itemCode',
		sortorder: 'desc',
		sortable: true,
    	rowNum:15,
    	rowList:[3,6,9],
    	pager:'#pager',
  		caption:'ǰ�񸮽�Ʈ'
	});
	$("#Itemgrid").jqGrid('navGrid',"#pager",
		{add:false,edit:false,del:false}, //options
		{}, // edit options
		{}, // add options
		{}, //del options
		{multipleSearch:true} // search options
	);
// 	jQuery("#Itemgrid").jqGrid('filterToolbar',{stringResult: true,searchOnEnter : false})
}
</script>
<table>
  	<tr>

  	<td valign="top" align="center" >
	<table>
	<tr>
	<td id="itemtable">
	<table id="Itemgrid"></table>
	<div id="pager"></div>
	</td>
	</tr>
	<tr>
	<td align="center">
	<input type="button" id="adItem" value="���">
	<input type="button" id="delItem" value="����">
	</td>
	</tr>
	</table>
	</td>
	
	<td valign="top" align="center">
  	 	<div id="moreDetailTabs" style="width:400px;font-size:20px">
		<ul >
			<li style="font-size:13px">��ǰ����</li>
		</ul>
		<div id="itemDetail">
		<table id="iteminfo">
					
						
							
								<tr>
									<td><label>ǰ�� : </label></td>
									<td><input type=text id="iCategory" name="iCategory" size=5
									readonly="readonly">
										
								</tr>
								<tr>
									<td><label>��ǰ�ڵ� : </label></td>
									<td><input type=text id="itemNo" name="itemNo" size=20
										readonly="readonly"></td>
								</tr>
								<tr>
									<td><label>��ǰ�� : </label></td>
									<td><input type=text id="itemName" name="itemName" size=20
									readonly="readonly">
										</td>
								</tr>
								<tr>
									<td><label>�� �� : </label></td>
									<td><input type=text id="GCNo" name="grade" size=10 readonly="readonly">
									<input type="button" id="GC"value="+">
									</td>
								</tr>
								<tr>
									<td><label>�� �� : </label></td>
									<td><input type=text id="PRONo" name="procurementCode" size=10 readonly="readonly">
									<input type="button" id="PRO" value="+">
									</td>
								</tr>
								
								<tr>
									<td><label>�� ��: </label></td>
									<td><input type=text id="unit" name="unit" size=3></td>
								</tr>
								<tr>
									<td><label>�ս���: </label></td>
									<td><input type=text id="itemLoss" name="loss" size=5></td>
								</tr>
								<tr>
									<td><label>ǥ�ؿ���: </label></td>
									<td><input type=text id="itemCost" name="empEmail" size=20></td>
								</tr>
								<tr>
									<td><label>�ҿ�ð�(min): </label></td>
									<td><input type=text id="leadtime" name="leadtime"
										size=5></td> 
								</tr>
								<tr>
									<td><label>�ŷ�ó�ڵ�: </label></td>
									<td><input type=text id="ACNo" name="account" size=6 readonly="readonly">
										<input type="button" id="AC"value="+">
										</td>
								</tr>
								
							
						
		
					<tr>
					<td colspan="2" align="center" style="font-size:12px">
					<input type="button" id="modiItem" value="����">
					<input type="button" id="modiCancel" value="���">
					</td>
					</tr>
					</table>	
		       </div>
		      </div>
				
		
		</td>
	</tr>		
</table>