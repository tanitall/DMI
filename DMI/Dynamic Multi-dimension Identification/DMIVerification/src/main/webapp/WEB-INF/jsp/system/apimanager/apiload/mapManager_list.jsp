﻿<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="ts" uri="/rights"  %>
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
<%@ include file="../../index/top.jsp"%>
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
						<!-- 检索  -->
						<form action="api/mapload.do" method="post" name="interfaceForm" id="interfaceForm">
						<table style="margin-top:5px;">
							<tr>
								<td>
									<div class="nav-search">
									<span class="input-icon">
										<input class="nav-search-input" autocomplete="off" id="nav-search-input" type="text" name="keywords" value="${pd.keywords }" placeholder="这里输入关键词" />
										<i class="ace-icon fa fa-search nav-search-icon"></i>
									</span>
									</div>
								</td>
								<td style="vertical-align:top;padding-left:2px;"><a class="btn btn-light btn-xs" onclick="searchs();"  title="检索"><i id="nav-search-icon" class="ace-icon fa fa-search bigger-110 nav-search-icon blue"></i></a></td>
								
							</tr>
						</table>
						<!-- 检索  -->
						<table id="simple-table" class="table table-striped table-bordered table-hover" style="margin-top:5px;">
							<thead>
								<tr>
									<th colspan="5" class="center">缓存用户列表</th>
								</tr>
								<tr>
									<!-- <th class="center" style="width:35px;">
									<label class="pos-rel"><input type="checkbox" class="ace" id="zcheckbox" /><span class="lbl"></span></label>
									</th> -->
									<th class="center" style="width:50px;">序号</th>
<!-- 									<th class="center">业务ID</th> -->
									<th class="center">机构名称</th>
									<th class="center">机构状态</th>
									<th class="center">操作</th>
								</tr>
							</thead>
							<tbody>
							<!-- 开始循环 -->	
							<c:choose>
								<c:when test="${not empty loadList}">
									<c:forEach items="${loadList}" var="load" varStatus="vs">
										<tr>
											<%-- <td class='center' style="width: 30px;">
												<label><input type='checkbox' name='ids' value="${load.USER_ID }"  class="ace"/><span class="lbl"></span></label>
											</td> --%>
											<td class='center' style="width: 30px;">${vs.index+1}</td>
<%-- 											<td class="center">${inter.IN_ID }</td> --%>
											<td class="center">${load.USERNAME }</td>
											<td class="center">
												<c:if test="${load.IS_VERIFY == '1' }"><span class="label label-success arrowed">验签</span></c:if>
												<c:if test="${load.IS_VERIFY == '0' }"><span class="label label-important arrowed-in">不验签</span></c:if>
											</td>
											<td class="center">
												<div class="btn-group">
													<ts:rights code="">
														<c:if test="${load.IS_VERIFY == '1' }">
															<a class="btn btn-xs btn-success" title="加载" onclick="addLoad('${load.USERNAME}');">
																<i class="ace-icon fa fa-pencil-square-o bigger-120" title="加载"></i>
															</a>
														</c:if>
														<c:if test="${load.IS_VERIFY == '0' }">	
															<a class="btn btn-xs btn-danger" onclick="delLoad('${load.USERNAME }');">
																<i class="ace-icon fa fa-trash-o bigger-120" title="删除"></i>
															</a>
														</c:if>	
													</ts:rights>
												</div>
											</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr class="main_info">
										<td colspan="100" class="center" >没有相关数据</td>
									</tr>
								</c:otherwise>
							</c:choose>
							</tbody>
						</table>
						<div class="page-header position-relative">
						<table style="width:100%;">
							<tr>
								<td style="vertical-align:top;">

								</td>
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
	<%@ include file="../../index/foot.jsp"%>
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
		
		$(function() {
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
		
		//检索
		function searchs(){
			top.jzts();
			$("#interfaceForm").submit();
		}
	
		//加载
		function addLoad(userName){
			bootbox.confirm("确定要加载此数据吗？", function(result) {
				if(result) {
// 					top.jzts();
					var url = "<%=basePath%>api/addload.do?USERNAME="+userName;
					$.get(url,function(data){
						window.location.href="<%=basePath%>api/mapload.do"
					});
				}
			});
		}

		//删除
		function delLoad(userName){
			bootbox.confirm("确定要删除此数据吗？", function(result) {
				if(result) {
// 					top.jzts();
					var url = "<%=basePath%>api/delload.do?USERNAME="+userName;
					$.get(url,function(data){
// 						nextPage();
					window.location.href="<%=basePath%>api/mapload.do"
					});
				}
			});
		}
		
		</script>
</html>
