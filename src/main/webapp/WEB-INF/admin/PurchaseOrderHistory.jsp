<%@page import="java.util.Calendar"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hoan.Model.DAO.ConnectSQLServer"%>
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
<%
	Calendar cal1 = Calendar.getInstance();
	cal1.add(Calendar.DATE, +1);
	Date to = cal1.getTime();
	String today = new Timestamp(to.getTime()).toString();

	Calendar cal2 = Calendar.getInstance();
	cal2.add(Calendar.MONTH, -1);
	Date from = cal2.getTime();
	String dayFrom = new Timestamp(from.getTime()).toString();
%>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/admin/head.jsp"></jsp:include>
	<div id="layoutSidenav">
		<jsp:include page="/WEB-INF/admin/SlideMenu.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid">
					<h2 class="mt-4" style="padding-bottom: 20px; color: red;">
						<i class="fas fa-history"></i> Lịch sử nhập hàng
					</h2>
					<div class="card col-lg-9">
						<div class="card-header">
							<h5>Từ :</h5>
							<div class="form-group">
								<input type="date" id="from" name="from" class="form-control"
									onchange="getPurchaseOrder()"
									value="<%=dayFrom.substring(0, 10)%>">
							</div>
							<h5>Đến :</h5>
							<div class="form-group">
								<input type="date" id="to" name="to" class="form-control"
									onchange="getPurchaseOrder()"
									value="<%=today.substring(0, 10)%>">
							</div>
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table" id="">
									<thead>
										<tr>
											<th>Detail</th>
											<th>Mã đơn</th>
											<th>Thời gian</th>
											<th>Tổng tiền</th>
										</tr>
									</thead>
									<tbody id="HistoryBody">
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</main>
			<div class="modal fade" id="exampleModalCenter" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalCenterTitle"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered bd-example-modal-sm" role="document">
					<div class="modal-content modal-sm">
						<div class="modal-header">
							<h4>Chi tiết các size đã nhập</h4>
						</div>
						<div class="modal-body">
							<table class="table">
								<thead>
									<tr>
										<th>Size</th>
										<th>Số lượng</th>
									</tr>
								</thead>
								<tbody id="SizeItemBody">
								</tbody>
							</table>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
					</div>
				</div>
			</div>
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
		document.getElementById("from").max = new Date().toISOString().split(
				"T")[0];
		document.getElementById("to").max = new Date().toISOString().split("T")[0];
		document.getElementById("to").min = document.getElementById("from").value;

		getPurchaseOrder();

		function showItemSizes(orderID, itemID) {
			var from = document.getElementById("from").value;
			var to = document.getElementById("to").value;
			var html_code = '';
			$.ajax({
				url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
				type : 'POST',
				dataType : 'JSON',
				data : {
					"action" : "getPurchaseOrderHistory",
					"detail" : "getPurchaseItemSizes",
					"orderID" : orderID,
					"itemID" : itemID,
					"from" : from,
					"to" : to
				},
				success : function(data) {
					$(data).each(function() {
							html_code += '<tr><td>'+this.size+'</td><td>'+this.quantity+'</td></tr>'
					});
					$('#SizeItemBody').html(html_code);
					$("#exampleModalCenter").modal();
				},
				error : function(data) {
					alert("error");
				}
			});
		};

		function showOrderDetail(orderID) {
			var from = document.getElementById("from").value;
			var to = document.getElementById("to").value;
			var html_code = '';
			html_code += '<div class="table-responsive"><table class="table">';
			html_code += '<thead><tr><th>Mã</th><th>Ảnh</th><th>Thông tin cơ bản</th><th>Giá nhập</th><th>Số lượng</th><th>Thành tiền</th><th>Chi tiết</th></tr></thead>';
			html_code += '<tbody>';
			$
					.ajax({
						url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
						type : 'POST',
						dataType : 'JSON',
						data : {
							"action" : "getPurchaseOrderHistory",
							"detail" : "getPurchaseItems",
							"orderID" : orderID,
							"from" : from,
							"to" : to
						},
						success : function(data) {
							$(data)
									.each(
											function() {
												html_code += '<tr>';
												html_code += '<td><Strong>'
														+ this.itemID
														+ '</Strong></td>'
												html_code += '<td><div class="product-item"><a class="product-thumb" href="http://localhost:8080/com.spring-mvc-demo/Admin/Items/Edit?itemID='
														+ this.itemID
														+ '"><img width="100px" height="100px" src="<c:url value="';
												html_code+=	this.itemImg+'"/>"></a></div></td>';
												html_code += '<td><div class="product-info"><h5 class="product-title">'
														+ this.itemName
														+ '</h5><p><em>Size: </em>'
														+ this.itemType
														+ '</p><p><em>Loại: </em>'
														+ this.itemColor
														+ '</p></div></td>';
												html_code += '<td><span style="color: red;">'
														+ formatNumber(this.purchasePrice)
														+ '</span></td>';
												html_code += '<td><Strong>'
														+ this.quantity
														+ '</Strong></td>';
												html_code += '<td><strong><span style="color: red;">'
														+ formatNumber(this.totalPurchase)
														+ '</span></strong></td>';
												html_code += '<td><button class="btn btn-success" onclick="showItemSizes('+this.orderID2+', '+this.itemID2+')"><i class="fas fa-info-circle"></i></button></td>';
												html_code += '</tr>';
											});
							html_code += '</tbody></table></div>';
							$('#orderItems_' + orderID).html(html_code);
						},
						error : function(data) {
							alert("error");
						}
					});
		};

		function getPurchaseOrder() {
			var from = document.getElementById("from").value;
			var to = document.getElementById("to").value;
			var html_code = '';
			$
					.ajax({
						type : 'POST',
						url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
						dataType : 'JSON',
						data : {
							"action" : "getPurchaseOrderHistory",
							"detail" : "getPurchaseOrder",
							"from" : from,
							"to" : to
						},
						success : function(data) {
							$(data)
									.each(
											function() {
												html_code += '<tr><td style="text-align: center;"><a onclick="showOrderDetail('
														+ this.orderID2
														+ ')" href="#order_'
														+ this.orderID
														+ '" data-toggle="collapse"><i class="fas fa-caret-down"></i></a></td><td>'
														+ this.orderID
														+ '</td><td>'
														+ this.time
														+ '</td><td><strong><span style="color: red;">'
														+ formatNumber(this.totalPurchase)
														+ '</span></strong></td></tr>';
												html_code += '<tr class="hide-table-padding"><td colspan="4"><div id="order_'
													+this.orderID+'" class="collapse"><div class="container" id="orderItems_'+this.orderID+'"></div></div></td></tr>';
											});
							$("#HistoryBody").html(html_code);
						},
						error : function() {
							alert('error')
						}
					});
		};

		function formatNumber(num) {
			return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
					+ 'đ';
		}
	</script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
</body>
</html>
