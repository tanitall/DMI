﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="en">
<head>
<base href="<%=basePath%>">
<!-- 下拉框 -->
<link rel="stylesheet" href="static/ace/css/chosen.css" />
<!-- jsp文件头和头部 -->
<%@ include file="../../system/index/top.jsp"%> 
<!-- 日期框 -->
<link rel="stylesheet" href="static/ace/css/datepicker.css" />
</head>
<body class="no-skin">

	<!-- /section:basics/navbar.layout -->
	<div class="main-container" id="main-container">
		<!-- /section:basics/sidebar -->
		<div class="main-content">
			<div class="main-content-inner">
				<div class="page-content">
					<div class="row">
						<div class="col-xs-12">
						
						
						<form action="mtsConfigTest/listmtsConfig.do" method="post" name="mtsConfigTestFrom" id="mtsConfigTestFrom">
						<!-- 检索
						<table style="margin-top:5px;">
							<tr>								
								<td style="padding-left:2px;"><input class="span10 date-picker" name="startDate" id="startDate"  value="${pd.startDate}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="开始日期" title="开始日期"/></td>
								<td style="padding-left:2px;"><input class="span10 date-picker" name="endDate" id="endDate"  value="${pd.endDate}" type="text" data-date-format="yyyy-mm-dd" readonly="readonly" style="width:88px;" placeholder="结束日期" title="结束日期"/></td>
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
							</tr>
						</table>
						检索  -->
					
						<table id="simple-table" class="table table-striped table-bordered table-hover"  style="margin-top:5px;">
							<thead>
								<tr>
									<!-- <th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th> -->
									<th class="center" style="width:50px;">序号</th>
									<th class="center">执行名称</th>
									<th class="center">执行批次</th>									
									<th class="center">操作</th>
								</tr>
							</thead>
													
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty listMtsDBdata}">
									<c:forEach items="${listMtsDBdata}" var="pd" varStatus="vs">
										<tr>
											<%-- <td class='center' style="width: 30px;">
												<label><input type='checkbox' name='ids' value="${pd.DB_DATA_ID}" class="ace"/><span class="lbl"></span></label>
											</td> --%>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
											<td class="center">${pd.PT_NAME}</td>
											<td class="center">${pd.PT_ID}</td>											
											<td class="center">
												<div class="hidden-sm hidden-xs btn-group">
													<a class="btn btn-mini btn-purple" onclick="standard('${pd.PT_ID}');">
														<i class="icon-pencil"></i>标准化
													</a>
													<a class="btn btn-xs btn-danger" onclick="delConfigData('${pd.PT_ID}');">
														<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
													</a>													
												</div>												
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="11" class="center">没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						
					<div class="page-header position-relative">
					<table style="width:100%;">
						<tr>
							<td style="vertical-align:top;">
								<a class="btn btn-mini btn-success" onclick="importExcel();">导入数据</a>
								<a class="btn btn-mini btn-success" onclick="importt();">RECORD数据导入</a>									
							</td>
							<!-- <td style="vertical-align:top;">
								<a class="btn btn-mini btn-success" onclick="downloadTemplate();">下载模板</a>
							</td> -->
							<td style="vertical-align:top;"><div class="pagination" style="float: right;padding-top: 0px;margin-top: 0px;">${page.pageStr}</div></td>
						</tr>
					</table>
					</div>
					</form>
						</div>
						<!-- /.col -->
					</div>
					<!-- /.row -->
				</div>
				<!-- /.page-content -->
			</div>
		</div>
		<!-- /.main-content -->

		<!-- 返回顶部 -->
		<a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
			<i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
		</a>

	</div>
	<!-- /.main-container -->

	<!-- basic scripts -->
	<!-- 页面底部js¨ -->
	<%@ include file="../../system/index/foot.jsp"%>
	<!-- 删除时确认窗口 -->
	<script src="static/ace/js/bootbox.js"></script>
	<!-- ace scripts -->
	<script src="static/ace/js/ace/ace.js"></script>
	<!-- 日期框 -->
	<script src="static/ace/js/date-time/bootstrap-datepicker.js"></script>
	<!-- 下拉框 -->
	<script src="static/ace/js/chosen.jquery.js"></script>
	<!--提示框-->
	<script type="text/javascript" src="static/js/jquery.tips.js"></script>
	</body>

<script type="text/javascript">
$(top.hangge());


//删除
function delConfigData(PT_ID){
	bootbox.confirm("确定要删除这批测试数据吗?", function(result) {
		if(result) {
			top.jzts();
			var url = '<%=path%>/mtsConfigTest/deleteMtsConfig.do?PT_ID='+PT_ID;
			$.get(url,function(data){
				if('${page.currentPage}' == '0'){
					 top.jzts();
					 setTimeout("self.location.reload()",100);
				 }else{
					 nextPage(${page.currentPage});
				 }
			});
		};
	});
}

//删除
function importt(){
	
		
	$.ajax({ 
		type: "post", 		
		url: '<%=basePath%>mtsConfigTest/recordinto.do', 
		cache:false, 
		async:true, 
		success: function(xmlobj){ 
			
		 } 
	});
}


//打开上传excel页面
function importExcel(){
	 top.jzts();

	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="导入数据文件EXCEL";
	 diag.URL = '<%=path%>/mtsConfigTest/goUploadExcel.do';
	 diag.Width = 1000;
	 diag.Height = 800;
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			 if('${page.currentPage}' == '0'){
				 top.jzts();
				 setTimeout("self.location.reload()",100);
			 }else{
				 nextPage(${page.currentPage});
			 }
		}
		diag.close();
	 };
	 diag.show();
}	


function standard(PT_ID){

	top.jzts();

	 var diag = new top.Dialog();
	 diag.Drag=true;
	 diag.Title ="标准化页面";
	 diag.URL = '<%=path%>/mtsConfigTest/goMtsStand.do?PT_ID='+PT_ID;
	 diag.Width = 1000;
	 diag.Height = 800;
	 diag.CancelEvent = function(){ //关闭事件
		 if(diag.innerFrame.contentWindow.document.getElementById('zhongxin').style.display == 'none'){
			 if('${page.currentPage}' == '0'){
				 top.jzts();
				 setTimeout("self.location.reload()",100);
			 }else{
				 nextPage(${page.currentPage});
			 }
		}
		diag.close();
	 };
	 diag.show();
}	




$(function() {
	//日期框
	$('.date-picker').datepicker({autoclose: true,todayHighlight: true});
	
	//下拉框
	if(!ace.vars['touch']) {
		$('.chosen-select').chosen({allow_single_deselect:true}); 
		$(window)
		.off('resize.chosen')
		.on('resize.chosen', function() {
			$('.chosen-select').each(function() {
				 var $this = $(this);
				 $this.next().css({'width': $this.parent().width()});
			});
		}).trigger('resize.chosen');
		$(document).on('settings.ace.chosen', function(e, event_name, event_val) {
			if(event_name != 'sidebar_collapsed') return;
			$('.chosen-select').each(function() {
				 var $this = $(this);
				 $this.next().css({'width': $this.parent().width()});
			});
		});
		$('#chosen-multiple-style .btn').on('click', function(e){
			var target = $(this).find('input[type=radio]');
			var which = parseInt(target.val());
			if(which == 2) $('#form-field-select-4').addClass('tag-input-style');
			 else $('#form-field-select-4').removeClass('tag-input-style');
		});
	}

	
	//复选框全选控制
	var active_class = 'active';
	$('#simple-table > thead > tr > th input[type=checkbox]').eq(0).on('click', function(){
		var th_checked = this.checked;//checkbox inside "TH" table header
		$(this).closest('table').find('tbody > tr').each(function(){
			var row = this;
			if(th_checked) $(row).addClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', true);
			else $(row).removeClass(active_class).find('input[type=checkbox]').eq(0).prop('checked', false);
		});
	});
});
</script>
</html>
