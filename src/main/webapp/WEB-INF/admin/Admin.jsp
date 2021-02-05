<%@page import="com.hoan.Model.DAO.Statistical"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hoan.Model.DAO.Item"%>
<%@page import="com.hoan.Model.DAO.ItemsInfor"%>
<%@page import="com.hoan.Model.DAO.ConnectSQLServer"%>
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
</head>
<%
	Item itemModel = new Item();
	ItemsInfor itemInforModel = new ItemsInfor();
	Statistical statistical = new Statistical();
%>
<script>
	function addTag(tag) {
		var html_code = '';
		html_code += '<div class="custom-control custom-checkbox"> <input class="custom-control-input" onChange="searchItems()" type="checkbox" name="Tag" id="'
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
				<div class="container-fluid">
					<h1 class="mt-4">Thống kê</h1>
					<hr>
					<div class="row">
						<div class="col-xl-3 col-md-6">
							<div class="card bg-primary text-white mb-4">
								<div class="card-body">
									Doanh thu tháng<br> <span id="totalInterest"
										style="color: yellow;"></span>
								</div>
								<div
									class="card-footer d-flex align-items-center justify-content-between">
									<a class="small text-white stretched-link" href="#">View
										Details</a>
									<div class="small text-white">
										<i class="fas fa-angle-right"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6">
							<div class="card bg-warning text-white mb-4">
								<div class="card-body">
									Đơn hàng chờ xác nhận<br> <span>2 </span>đơn hàng
								</div>
								<div
									class="card-footer d-flex align-items-center justify-content-between">
									<a class="small text-white stretched-link" href="#">View
										Details</a>
									<div class="small text-white">
										<i class="fas fa-angle-right"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6">
							<div class="card bg-success text-white mb-4">
								<div class="card-body">
									Đơn hàng thành công<br> <span>1 </span>đơn hàng
								</div>
								<div
									class="card-footer d-flex align-items-center justify-content-between">
									<a class="small text-white stretched-link" href="#">View
										Details</a>
									<div class="small text-white">
										<i class="fas fa-angle-right"></i>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xl-3 col-md-6">
							<div class="card bg-danger text-white mb-4">
								<div class="card-body">
									Đơn hàng trả lại<br> <span>0 </span>đơn hàng
								</div>
								<div
									class="card-footer d-flex align-items-center justify-content-between">
									<a class="small text-white stretched-link" href="#">View
										Details</a>
									<div class="small text-white">
										<i class="fas fa-angle-right"></i>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-xl-12">
							<div class="card mb-4">
								<div class="card-header">
									<i class="fas fa-chart-area mr-1"></i> Năm <select
										class="form-control" id="year"
										style="display: inline; width: 100px;"
										onchange="showTotalIn()">
										<option>2021</option>
										<option>2020</option>
									</select>
								</div>
								<div class="card-body">
									<canvas id="myAreaChart" width="100%" height="40"></canvas>
								</div>
							</div>
						</div>
					</div>



					<div class="card mb-4">
						<div class="container-fluid">
							<h1 class="mt-4" style="padding-bottom: 20px;">
								<i class="fas fa-table mr-1"></i> Đơn hàng đang chờ xác nhận
							</h1>

							<div class="card mb-4">
								<div class="card-body">
									<div class="table-responsive">
										<table class="table" id="confirmOrder">
											<thead>
												<tr>
													<th></th>
													<th>Chọn</th>
													<th>Thời gian</th>
													<th>Mã đơn hàng</th>
													<th>Khách hàng</th>
													<th>Điện thoại</th>
													<th>Địa chỉ nhận</th>
													<th>Tổng tiền</th>
													<th>Trạng thái</th>
												</tr>
											</thead>
											<tbody id="OrderConfirmBody">

											</tbody>
										</table>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

			</main>

			<div class="modal fade bd-example-modal-lg" id="modal" tabindex="-1"
				role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
				<div class="modal-dialog modal-lg">
					<div class="modal-content">
						<canvas id="myAreaChartDay" width="100%" height="40"></canvas>
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



	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="<c:url value="/resources/admintemplate/js/scripts.js"/>"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>

	<script>
		getOrder();

		console.log(
	<%=statistical.getTotalIn()%>
		);
		console.log(
	<%=statistical.getTotalOut()%>
		);
		$("#totalInterest")
				.html(
						formatNumber(
	<%=statistical.getTotalIn() - statistical.getTotalOut()%>
		));

		var items = [];

		function formatNumber(num) {
			return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
					+ 'đ';
		}

		function showOrderDetail(orderID) {
			/* alert('1'); */
			var html_code = '';
			html_code += '<div class="table-responsive"><table class="table" id="CartTable" style="text-align: center;">';
			html_code += '<thead><tr><th>Mã</th><th>Ảnh</th><th>Thông tin cơ bản</th><th>Màu</th><th>Số lượng</th><th>Giá bán</th>'
					+ '</tr></thead>';
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
												html_code += '<tr><td><strong>'
														+ this.itemID
														+ '</strong></td><td><div class="product-item"><a class="product-thumb" href="#"><img width="100px" height="100px" src="<c:url value="';
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
			var html_code = '';
			$
					.ajax({
						url : '/com.spring-mvc-demo/Admin/OrderActions',
						type : 'POST',
						dataType : 'JSON',
						data : {
							"status" : 'Chờ xác nhận',
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
														+ this.timeConfirm
														+ '</td>';
												html_code += '<td>'
														+ this.orderID
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
												html_code += '<td><div class="dropdown"><a class="btn btn-success dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown"aria-haspopup="true" aria-expanded="false">'
														+ this.order_status
														+ '</a><div class="dropdown-menu dropdown-menu-center" aria-labelledby="dropdownMenuButton">'
														+ '<a class="dropdown-item" onclick="confirm('
														+ this.orderID
														+ ')">Xác nhận</a>'
														+ '<a class="dropdown-item" href="#">Hủy đơn</a>'
														+ '</div></div></td>';

												html_code += '</tr>';
												html_code += '<tr class="hide-table-padding"><td colspan="9"><div id="order_'
														+this.orderID+'" class="collapse"><div class="container" id="orderDetail_'+this.orderID+'"></div></div></td></tr>'
											});
							$('#OrderConfirmBody').html(html_code);
						},
						error : function(data) {
							alert('get order failed');
						}
					});
		}

		function confirm(orderID) {
			/* alert('1'); */
			$.ajax({
				url : '/com.spring-mvc-demo/Admin/OrderActions',
				type : 'POST',
				dataType : 'JSON',
				data : {
					"orderID" : orderID.toString(),
					"action" : "confirmOrder"
				},
				success : function(data) {
					getOrder('Chờ xác nhận');
				},
				error : function(data) {
					alert('error');
				}
			});
		}
	</script>

	<script>
		var dataVal= [];
		
		$.ajax({
			url : '/com.spring-mvc-demo/Admin/StatisticalActions',
			type : 'POST',
			dataType : 'JSON',
			data : {
				"action" : "getStatisticalYear",
				"year" : document.getElementById("year").value
			},
			success : function(data) {
				$(data).each(function() {
					dataVal.push(parseInt(this.In-this.Out));
					console.log(this.In-this.Out);
				});
			},
			error : function(data) {
				alert("Lấy dữ liệu thống kê lỗi");
			}
		});
		
		console.log(dataVal);
	
		var ctx = document.getElementById("myAreaChart");
		var myLineChart = new Chart(ctx, {
			type : 'line',
			data : {
				labels : [ "Tháng 1", "Tháng 2", "Tháng 3", "Tháng 4",
						"Tháng 5", "Tháng 6", "Tháng 7", "Tháng 8", "Tháng 9",
						"Tháng 10", "Tháng 11", "Tháng 12" ],
				datasets : [ {
					label : "Doanh thu",
					lineTension : 0.3,
					backgroundColor : "rgba(2,117,216,0.2)",
					borderColor : "rgba(2,117,216,1)",
					pointRadius : 5,
					pointBackgroundColor : "rgba(2,117,216,1)",
					pointBorderColor : "rgba(255,255,255,0.8)",
					pointHoverRadius : 5,
					pointHoverBackgroundColor : "rgba(2,117,216,1)",
					pointHitRadius : 50,
					pointBorderWidth : 2,
					data : [-15741000,0,0,0,0,0,0,0,0,0,0,0],
				} ],
			},
			options : {
				scales : {
					xAxes : [ {
						time : {
							unit : 'date'
						},
						gridLines : {
							display : false
						},
						ticks : {
							maxTicksLimit : 7
						}
					} ],
					yAxes : [ {
						ticks : {
							maxTicksLimit : 5
						},
						gridLines : {
							color : "rgba(0, 0, 0, .125)",
						}
					} ],
				},
				legend : {
					display : false
				}
			}
		});
		
		function showTotalIn() {
			location.reload();
		}
		
	</script>


</body>
</html>
