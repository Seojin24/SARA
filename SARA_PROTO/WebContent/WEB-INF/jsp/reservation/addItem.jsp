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
#moreDetailTabs {width:550px;height:450px; font-size:20px;}
</style>
<script type="text/javascript">
var itemBean;
var itemList;
$(document).ready(function(){
	$('#moreDetailTabs').tabs();
	$('#addItem').button().click(all);
	$('#addCancel').button().click(function(){
		window.close();
	});
	$('#ITC').button().click(code);
	$('#GC').button().click(code);
	$('#PRO').button().click(code);
	$('#AC').button().click(code);

	setItemForm();
})
function code(){
	var features = 'width=580px; height=520px; left=550px; top=150px; titlebar=no; status=no';
  //  alert($(this).attr("id"));
	window.open('${pageContext.request.contextPath}/base/codeList.do?code='+$(this).attr("id"),'�ڵ�˻�',features);
}
function ObjectCopy(obj){
	 return JSON.parse(JSON.stringify(obj));
}
function setItemForm(){
	$.ajax({
		url:'item.do?oper=getaddForm',
		dataType:'json',
	//	cache:false,
	 	success: function(data){
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
				itemBean=ObjectCopy(data.item);
 				
 			}
	 	}
	});
}
function all(){
	itemList=[];
	if(!confirm("����Ͻðڽ��ϱ�?")) return;
	itemBean.itemName=$('#itemName').val();
	itemBean.gradeCode=$('#GCNo').val();
	itemBean.procurement=$('#PRONo').val();
    itemBean.icategoryCode=$('#ITCNo').val();
	itemBean.unit=$('#unit').val();
	itemBean.standardCost=$('#itemCost').val();
	itemBean.leadTime=$('#leadtime').val();
	itemBean.accountCode=$('#ACNo').val();
	itemBean.lossFactor=$('#itemLoss').val();
	itemBean.status="insert";
	itemList.push(itemBean);
	var list='{"itemBeanList":'+$.toJSON(itemList)+'}';
	alert(list);
	addProcess(list);
	window.opener.location.href="itemList.html";
	window.close();
}
function addProcess(list){
	$.ajax({
	    url : 'item.do?oper=batchItem',
	    contentType : "application/x-www-form-urlencoded; charset=UTF-8",
	    type : 'post',
	    data :{'list':list},
	    success : function(data, textStatus, jqXHR) {
			if(data.errorCode<0){
				alert(data.errorMsg);
			}else{
	    		alert("��� �Ǿ����ϴ�.");
	    	}
	    },
	    error : function(jqXHR, textStatus, error) {
	     	alert("�ϰ�ó�� �����Դϴ�!>>");
	    }
	});
}
</script>
 	<div id="moreDetailTabs" >
		<ul >
			<li style="font-size:13px">��ǰ����</li>
		</ul>
		<div id="itemDetail">
		<table id="iteminfo" align="center">			
					<tr>
						<td><label>ǰ�� : </label></td>
						<td><input type=text id="ITCNo" name="iCategory" size=5 readonly="readonly">
						<input type="button" id="ITC" value="+"></td>	
					</tr>
								
					<tr>
						<td><label>��ǰ�� : </label></td>
						<td><input type=text id="itemName" name="itemName" size=10>
						</td>
					</tr>
					<tr>
						<td><label>�� �� : </label></td>
						<td><input type=text id="GCNo" name="grade" size=10>
						<input type="button" id="GC"value="+">
						</td>
					</tr>
					<tr>
						<td><label>�� �� : </label></td>
						<td><input type=text id="PRONo" name="procurement" size=10>
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
						<td><label>�ҿ��ϼ�: </label></td>
						<td><input type=text id="leadtime" name="leadtime" size=5></td> 
					</tr>
					<tr>
						<td><label>�ŷ�ó�ڵ�: </label></td>
						<td><input type=text id="ACNo" name="account" size=6>
						<input type="button" id="AC"value="+">
						</td>
					</tr>
					<tr>
					<td colspan="2" align="center" style="font-size:12px">
					<input type="button" id="addItem" value="Ȯ��">
					<input type="button" id="addCancel" value="���">
					</td>
					</tr>
					</table>	
		       </div>
		 </div>