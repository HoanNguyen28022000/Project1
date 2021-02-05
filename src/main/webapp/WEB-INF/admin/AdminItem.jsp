<%@page import="java.lang.reflect.Array"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hoan.Model.DAO.Item"%>
<%@page import="com.hoan.Model.DAO.ItemsInfor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="	vi-VN" />
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>BK SHOES ADMIN</title>
<link href="<c:url value="/resources/admintemplate/css/styles.css"/>"
	rel="stylesheet" />
<link
	href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<%
	Item itemModel = new Item();
	ItemsInfor itemInforModel = new ItemsInfor();
	
	if(request.getAttribute("insert")!=null) {
		out.println("<script>");
		   out.println("alert('Thêm không thành công. Kiểm tra lại dữ liệu');");
		   out.println("</script>");
	}
%>
</head>
<script>
	function addTag(tag) {
		var html_code = '';
		html_code += '<div class="custom-control custom-checkbox"> <input class="custom-control-input" onChange="searchItem()" type="checkbox" name="Tag" id="'
				+ tag
				+ '" value="'
				+ tag
				+ '"> <label class="custom-control-label" for="'+tag+'">'
				+ tag
				+ '</label></div>';
		document.write(html_code);
	}
</script>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/admin/head.jsp"></jsp:include>
	<div id="layoutSidenav">
		<jsp:include page="/WEB-INF/admin/SlideMenu.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid" style="padding-top: 50px;">
					<div class="row">
						<div class="col-sm-2">
							<form id="formTag">
								<div class="dropdown">
									<label><span style="font-weight: bold;">Trạng
											thái</span></label> <select class="form-control" id="selectStatus"
										name="selectStatus" onchange="searchItem()">
										<option value="%">Tất cả</option>
										<option value="Đang bán">Đang bán</option>
										<option value="Ngừng bán">Ngừng bán</option>
										<option value="Mới">Mới</option>
									</select>
								</div>
								<hr>
								<div class="dropdown">
									<label><span style="font-weight: bold;">Loại
											giày</span></label> <select class="form-control" id="selectType"
										name="selectType" onchange="searchItem()">
										<option value="%">Tất cả</option>
										<%
											ArrayList<String> itemTypes = itemInforModel.getItemType();
											for (String s : itemTypes) {
												out.print("<option value='" + s + "'>" + s + "</option>");
											}
										%>
									</select>
								</div>
								<hr>
								<label><span style="font-weight: bold;">Tag</span></label>
								<%
									out.write("<script>");
									ArrayList<String> tags = itemInforModel.getTags();
									for (String s : tags) {
										out.write("addTag('" + s + "');");
									}
									out.write("</script>");
								%>
								<hr>
								<div class="input-group" style="width: 100%;">
									<input class="form-control" type="text" name="nameSearch"
										placeholder="Search for..." id="nameSearch"
										aria-label="Search" aria-describedby="basic-addon2" />
									<div class="input-group-append">
										<button class="btn btn-primary" type="button"
											onclick="searchItem()">
											<i class="fa fa-search"></i>
										</button>
									</div>
								</div>
								<input type="text" id="action" name="action" value="search"
									style="visibility: hidden;">
							</form>
						</div>
						<div class="table-responsive col-sm-10">
							<div>
								<div class="dropdown ">
									<button type="button" class="btn btn-primary dropdown-toggle"
										data-toggle="dropdown">Chọn hành động</button>
									<div class="dropdown-menu">
										<button class="dropdown-item" onclick="onAction(this.value)"
											id="action1" value="Ngừng bán">Ngừng bán</button>
										<button class="dropdown-item" onclick="onAction(this.value)"
											id="action2" value="Đang bán">Đang bán</button>
									</div>
								</div>
								<a
									href="http://localhost:8080/com.spring-mvc-demo/Admin/Items/Insert"><button
										class="btn btn-primary" style="float: right;">Thêm
										sản phẩm</button></a>

							</div>
							<br>
							<form id="formAction">
								<input type="text" id="status" name="status"
									style="visibility: hidden;">
								<table class="table" id="CartTable">
									<thead>
										<tr>
											<th>Chọn</th>
											<th>Mã</th>
											<th>Ảnh</th>
											<th>Thông tin</th>
											<th>Có thể bán</th>
											<th>Tồn kho</th>
											<th>Giá nhập</th>
											<th>Giá bán</th>
											<th>Trạng thái</th>
										</tr>
									</thead>
									<tbody id="TableBody">
									</tbody>
								</table>
								<input type="text" id="action" name="action" value="changeStatus"
									style="visibility: hidden;">
							</form>
						</div>
					</div>
				</div>
			</main>
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2020</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
	<script
		src="<c:url value="/resources/admintemplate/assets/demo/datatables-demo.js"/>"></script>
	<script>
		searchItem();

		function itemAction() {
			/* alert('1'); */
			var formAction = $('#formAction');
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/Admin/ItemActions',
				dataType : 'JSON',
				data : formAction.serialize(),
				success : function(data) {
					alert('update successfully');
					searchItem();
				},
				error : function(data) {
					alert('update failed')
				}
			});
			/* alert('2'); */
		}

		function searchItem() {
			var form = $('#formTag');
			var html_code = '';
			$
					.ajax({
						type : 'POST',
						url : '/com.spring-mvc-demo/Admin/ItemActions',
						dataType : 'JSON',
						data : form.serialize(),
						success : function(data) {
							/* alert('in success'); */
							$(data)
									.each(
											function() {
												/* alert('4'); */
												html_code += '<tr>';
												html_code += '<td style="text-align: center;"><input class="form-check-input" type="checkbox" name="item_selected" id="'
													+this.itemID+'" value="'
													+this.itemID+'"/></td>';
												html_code += '<td>'
														+ this.itemID + '</td>';
												html_code += '<td><div class="product-item"><a class="product-thumb" href="http://localhost:8080/com.spring-mvc-demo/Admin/Items/Edit?itemID='
														+ this.itemID
														+ '"><img width="100px" height="100px" src="<c:url value="';
												html_code+=	this.itemImg+'"/>"></a></div></td>';
												html_code += '<td><div class="product-info"><h5 class="product-title">'
														+ this.itemName
														+ '</h5><p><em>Loại: </em>'
														+ this.itemType
														+ '</p><p><em>Màu: </em>'
														+ this.itemColor
														+ '</p></div></td>'
												html_code += '<td>'
														+ this.available
														+ '</td>';
												html_code += '<td>'
														+ this.inventory
														+ '</td>';
												html_code += '<td>'
														+ formatNumber(this.purchase_price)
														+ '</td>';
												html_code += '<td>'
														+ formatNumber(this.sale_price)
														+ '</td>';
												html_code += '<td>'
														+ this.status + '</td>';
												html_code += '</tr>';
											});
							$('#TableBody').html(html_code);
						},
						error : function(data) {
							alert('in error');
						}
					});
		};

		function onAction(action) {
			document.getElementById("status").value = action;
			/* alert(action); */
			itemAction();
		}

		function formatNumber(num) {
			return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
					+ 'đ';
		}
	</script>
</body>
</html>
