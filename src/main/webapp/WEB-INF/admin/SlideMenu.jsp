<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div id="layoutSidenav_nav">
		<nav class="sb-sidenav accordion sb-sidenav-dark"
			id="sidenavAccordion">
			<div class="sb-sidenav-menu">
				<div class="nav">
					<a class="nav-link"
						href="http://localhost:8080/com.spring-mvc-demo/Admin">
						<div class="sb-nav-link-icon">
							<i class="fas fa-tachometer-alt"></i>
						</div> Tổng quan
					</a> <a class="nav-link collapsed" href="#" data-toggle="collapse"
						data-target="#collapseLayouts1" aria-expanded="false"
						aria-controls="collapseLayouts1">
						<div class="sb-nav-link-icon">
							<i class="fas fa-box"></i>
						</div> Sản phẩm
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>
					<div class="collapse" id="collapseLayouts1"
						aria-labelledby="headingOne" data-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav">
							<a class="nav-link"
								href="http://localhost:8080/com.spring-mvc-demo/Admin/Items">Danh
								sách sản phẩm</a> <a class="nav-link" href="#">Quản lí kho</a> <a
								class="nav-link" href="#">Nhập hàng</a><a class="nav-link"
								href="#">Nhà cung cấp</a>
						</nav>
					</div>
					<a class="nav-link collapsed" href="#" data-toggle="collapse"
						data-target="#collapseLayouts2" aria-expanded="false"
						aria-controls="collapseLayouts2">
						<div class="sb-nav-link-icon">
							<i class="fas fa-clipboard-list"></i>
						</div> Đơn hàng
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>
					<div class="collapse" id="collapseLayouts2"
						aria-labelledby="headingOne" data-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav">
							<a class="nav-link" href="#">Tạo đơn hàng </a> <a
								class="nav-link"
								href="http://localhost:8080/com.spring-mvc-demo/Admin/Order">Danh
								sách đơn hàng</a>
						</nav>
					</div>
					<a class="nav-link collapsed" href="#" data-toggle="collapse"
						data-target="#collapseLayouts3" aria-expanded="false"
						aria-controls="collapseLayouts3">
						<div class="sb-nav-link-icon">
							<i class="fas fa-shipping-fast"></i>
						</div>Vận chuyển
						<div class="sb-sidenav-collapse-arrow">
							<i class="fas fa-angle-down"></i>
						</div>
					</a>
					<div class="collapse" id="collapseLayouts3"
						aria-labelledby="headingOne" data-parent="#sidenavAccordion">
						<nav class="sb-sidenav-menu-nested nav">
							<a class="nav-link" href="#">Shipper </a> 
						</nav>
					</div>
					<a class="nav-link" href="#"><div class="sb-nav-link-icon">
							<i class="fas fa-user"></i>
						</div>Khách hàng </a>
				</div>
			</div>
			<div class="sb-sidenav-footer">
				<div class="small">Logged in as:</div>
				Start Bootstrap
			</div>
		</nav>
	</div>
</body>
</html>