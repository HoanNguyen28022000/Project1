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
<link
	href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css"
	rel="stylesheet" crossorigin="anonymous" />
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
				<div class="container-fluid">
					<h1 class="mt-4" style="padding-bottom: 20px;">Khách hàng</h1>
					<div class="card mb-4">
						<div class="card-header">
							<i class="fas fa-table mr-1"></i> Số tiền đã chi
						</div>
						<div class="card-body">
							<div class="table-responsive">
								<table class="table table-bordered" id="dataTable" width="100%"
									cellspacing="0">
									<thead>
										<tr>
											<th>Tài khoản</th>
											<th>Tích lũy</th>
											<th>Họ tên</th>
											<th>Ngày sinh</th>
											<th>Điện thoại</th>
											<th>Email</th>
											<th>Địa chỉ nhà</th>
										</tr>
									</thead>
									<tfoot>
										<tr>
											<th>Tài khoản</th>
											<th>Tích lũy</th>
											<th>Họ tên</th>
											<th>Ngày sinh</th>
											<th>Điện thoại</th>
											<th>Email</th>
											<th>Địa chỉ nhà</th>
										</tr>
									</tfoot>
									<tbody id="customer">
									</tbody>
								</table>
							</div>
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
		src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
	<script
		src="<c:url value="/resources/admintemplate/js/datatables-demo.js"/>"></script>

	<script>
		$(document).ready(function() {
			$('#dataTable').DataTable();
		});

		getCustomer();

		function formatNumber(num) {
			return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
					+ 'đ';
		}

		function getCustomer() {
			var html_code = '';
			$.ajax({
				url : '/com.spring-mvc-demo/Admin/OrderActions',
				type : 'POST',
				dataType : 'JSON',
				data : {
					"action" : "getCustomers"
				},
				success : function(data) {
					$(data).each(
							function() {
								html_code += '<tr>';
								html_code += '<td>' + this.username + '</td>';
								html_code += '<td><span style="color: red;">'
										+ formatNumber(this.sumMoney)
										+ '</span></td>';
								html_code += '<td>' + this.fullname + '</td>';
								html_code += '<td>' + this.birthday + '</td>';
								html_code += '<td>' + this.phone + '</td>';
								html_code += '<td>' + this.Email + '</td>';
								html_code += '<td>' + this.address + '</td>';
								html_code += '</tr>';
							});
					$('#customer').html(html_code);
				},
				error : function(data) {
					alert('get customer failed');
				}
			});
		}
	</script>


</body>
</html>
