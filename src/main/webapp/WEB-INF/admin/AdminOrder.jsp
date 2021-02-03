<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hoan.Model.ConnectSQLServer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Dashboard - SB Admin</title>
<link href="<c:url value="/resources/admintemplate/css/styles.css"/>"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>

<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/admin/head.jsp"></jsp:include>
	<div id="layoutSidenav">
		<jsp:include page="/WEB-INF/admin/SlideMenu.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<main>
				<form id="orders">
					<div class="container-fluid">
						<h1 class="mt-4" style="padding-bottom: 20px;">
							<i class="fas fa-table mr-1"></i> Đơn hàng
						</h1>
						<div class="card mb-4">
							<div class="card-header">
								<div class="form-group" style="float: left; display: inline">
									<select class="form-control" id="status" name="status"
										onchange="getOrder()">
										<option>Tất cả</option>
										<option>Chờ xác nhận</option>
										<option>Đang đóng gói</option>
										<option>Chờ shipper</option>
										<option>Đang vận chuyển</option>
										<option>Bị trả lại</option>
										<option>Thành công</option>
										<option>Bị hủy</option>
									</select>
								</div>
								<div style="display: inline; float: right;">
									<div class="dropdown dropleft">
										<button type="button" class="btn btn-primary dropdown-toggle"
											data-toggle="dropdown">Thay đổi</button>
										<div class="dropdown-menu">
											<a class="dropdown-item" onclick="changeStatus('Chờ xác nhận')">Chờ xác nhận</a> <a
												class="dropdown-item" onclick="changeStatus('Đang đóng gói')">Đang đóng gói</a><a
												class="dropdown-item" onclick="changeStatus('Chờ shipper')">Chờ shipper</a><a
												class="dropdown-item" onclick="changeStatus('Bị hủy')">Bị hủy</a> <a
												class="dropdown-item" onclick="changeStatus('Đang vận chuyển')">Đang vận chuyển</a><a
												class="dropdown-item" onclick="changeStatus('Bị trả lại')">Bị trả lại</a> <a
												class="dropdown-item" onclick="changeStatus('Thành công')">Thành công</a>
										</div>
									</div>
								</div>
							</div>
							<div class="card-body">
								<div class="table-responsive">
									<table class="table" id="dataTableOrder">
										<thead>
											<tr>
												<th></th>
												<th>Chọn</th>
												<th>Mã đơn</th>
												<th>Thời gian</th>
												<th>Khách hàng</th>
												<th>Điện thoại</th>
												<th>Địa chỉ nhận</th>
												<th>Tổng tiền</th>
												<th>Trạng thái</th>
											</tr>
										</thead>
										<tbody id="OrderBody">
										</tbody>
									</table>
								</div>
							</div>
						</div>
						<input type="text" id="statusChange" name="statusChange" style="visibility: hidden;">
						<input type="text" id="action" name="action" value="changeStatus" style="visibility: hidden;">
					</div>
				</form>
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
	<script>
		getOrder();

		function formatNumber(num) {
			return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
					+ 'đ';
		}

		function showOrderDetail(orderID) {
			/* alert('1'); */
			var html_code = '';
			html_code += '<div class="table-responsive"><table class="table" id="CartTable">';
			html_code += '<thead><tr><th>Ảnh</th><th>Thông tin cơ bản</th><th>Màu</th><th>Số lượng</th><th>Giá bán</th></tr></thead>';
			html_code += '<tbody>';
			$
					.ajax({
						url : '/com.spring-mvc-demo/Admin/OrderActions',
						type : 'POST',
						dataType : 'JSON',
						data : {
							"orderID" : orderID,
							"action" : "getOrderDetail"
						},
						success : function(data) {
							$(data)
									.each(
											function() {
												/* alert('4'); */
												html_code += '<tr><td><div class="product-item"><a class="product-thumb" href="#"><img width="100px" height="100px" src="<c:url value="';
												html_code+=	this.itemImg+'"/>"></a></div></td>';
												html_code += '<td><div class="product-info"><h5 class="product-title">'
														+ this.itemName
														+ '</h5><p><em>Size: </em>'
														+ this.size
														+ '</p><p><em>Loại: </em>'
														+ this.itemType
														+ '</p></div></td>';
												html_code += '<td>'
														+ this.color + '</td>';
												html_code += '<td>'
														+ this.itemQuantity
														+ '</td>';
												html_code += '<td>'
														+ formatNumber(this.price)
														+ '</td>';
												html_code += '</tr>';
											});
							html_code += '</tbody></table></div>';
							$('#orderDetail_' + orderID).html(html_code);
						},
						error : function(data) {
							alert('error');
						}
					});
			/* alert('2'); */
		}

		function getOrder() {
			var status = document.getElementById("status").value;
			var html_code = '';
			$
					.ajax({
						url : '/com.spring-mvc-demo/Admin/OrderActions',
						type : 'POST',
						dataType : 'JSON',
						data : {
							"status" : status,
							"action" : "getOrders"
						},
						success : function(data) {
							$(data)
									.each(
											function() {
												html_code += '<tr>';
												html_code += '<td style="text-align: center;"><a onclick="showOrderDetail('
														+ this.orderID2
														+ ')" href="#order_'
														+ this.orderID
														+ '" data-toggle="collapse"><i class="fas fa-caret-down"></i></a></td>';
												html_code += '<td style="text-align: center;"><input class="form-check-input" type="checkbox" name="order_selected" id="'
												+this.orderID+'" value="'
												+this.orderID+'"/></td>';
												html_code += '<td>'
														+ this.orderID
														+ '</td>';
												html_code += '<td>'
														+ this.timeConfirm
														+ '</td>';
												html_code += '<td>'
														+ this.fullname
														+ '</td>';
												html_code += '<td>'
														+ this.receive_phone
														+ '</td>';
												html_code += '<td>'
														+ this.receive_address
														+ '</td>';
												html_code += '<td><span style="color: red;">'
														+ formatNumber(this.totalMoney)
														+ '</span></td>';
												html_code += '<td><strong>'
														+ this.order_status
														+ '</strong></td>';
												html_code += '</tr>';
												html_code += '<tr class="hide-table-padding"><td colspan="9"><div id="order_'
														+this.orderID+'" class="collapse"><div class="container" id="orderDetail_'+this.orderID+'"></div></div></td></tr>';
											});
							$('#OrderBody').html(html_code);
						},
						error : function(data) {
							alert('get order failed');
						}
					});
		}

		function changeStatus(status) {
			document.getElementById("statusChange").value= status;
			var form = $('#orders');
			$.ajax({
				url : '/com.spring-mvc-demo/Admin/OrderActions',
				type : 'POST',
				dataType : 'JSON',
				data :form.serialize(),
				success : function(data) {
					getOrder();
				},
				error : function(data) {
					alert('Tồn tại đơn hàng không thể thay đổi sang trạng thái này');
				}
			});
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
</body>
</html>
