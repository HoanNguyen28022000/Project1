<%@page import="com.hoan.Objects.CartItem"%>
<%@page import="com.hoan.Objects.Cart"%>
<%@page import="java.util.Set"%>
<%@page import="com.hoan.Objects.SizeOfColor"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hoan.Connection.ConnectSQLServer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="	vi-VN" />

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Shop Item - Start Bootstrap Template</title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style type="text/css">
body {
	padding-top: 56px;
}

.btn btn-secondary {
	background: white;
}

.quantityCart {
	height: 25px;
	width: 25px;
	background-color: red;
	border-radius: 50%;
	display: inline-block;
	color: white;
}
</style>

</head>

<body style="background:;">
	<%
		String itemDetail, itemImg, itemName, itemType, dateOfMade, productionCompany, madeIn, itemColor;
		int itemPrice, stocking;

		String itemID = request.getParameter("itemID");
		ConnectSQLServer connection = new ConnectSQLServer();
		String username = (String) session.getAttribute("user");

		HashMap<String, Object> item = connection.getItem(itemID);
		itemDetail = (String) item.get("itemDetail");
		itemImg = ((String) item.get("itemImg")).substring(20);
		itemName = (String) item.get("itemName");
		itemPrice = connection.getItemPrice(itemID).get(1);
		stocking = connection.getStockingItem(itemID).get(0);
		itemType = (String) item.get("itemType");
		dateOfMade = (String) item.get("dateOfMade");
		productionCompany = (String) item.get("productionCompany");
		madeIn = (String) item.get("madeIn");
		itemColor = (String) item.get("itemColor");

		HashMap<String, Integer> sizeItem = connection.getSize(itemID);
		HashMap<String, String> sameItemColor = connection.getSameItemColor(itemName, itemColor);
	%>
	<script>
		function loggedIn() {
			document
					.write('<li class="nav-item"><a class="nav-link" href="http://localhost:8080/com.spring-mvc-demo/Login">Đăng nhập</a></li>');
		}
		function logout(username) {
			document
					.write('<li class="nav-item"><a class="nav-link"href="http://localhost:8080/com.spring-mvc-demo/Login">Đăng xuất</a></li>');
			/* document.write('<li class="nav-item"><span class="nav-link">'
					+ username + '</span></li>'); */
		}
		function addSize(size, available) {
			document.write('<button type="button" class="btn btn-light" id="'
					+ size + '" onclick="sizeClick(this.id, ' + available
					+ ')">' + size + '</button>');
		}
		function sizeClick(buttonID, available) {
			if (available <= 0) {
				alert('đã hết size ' + buttonID);
			} else {
				document.getElementById("getSize").innerHTML = buttonID;
				document.getElementById("available").innerHTML = 'Còn '
						+ available + ' sản phẩm';
			}
		}
		function addColor(itemID, color) {
			document
					.write('<a href="http://localhost:8080/com.spring-mvc-demo/Home/Item?itemID='
							+ itemID
							+ '"><button type="button" class="btn btn-light"  name="size_39">'
							+ color + '</button></a>');
		}

		function addCartItem(itemID) {
			<%
				if(username == null) out.print("var username= null;") ;
				else out.print("var username= '"+username+"';");
			%>
			if (username != null) {
				var size = document.getElementById("getSize").textContent;
				var quantity = document.getElementById("quantity").value;
				if (size == '') {
					alert('bạn chưa chọn size');
				} else if (quantity < 1) {
					alert('chọn sai số lượng');
				} else {
					alert('1');
					quantity = quantity.toString();
					$
							.ajax({
								type : 'POST',
								url : '/com.spring-mvc-demo/Home/Item/AddCartItem',
								dataType : 'JSON',
								data : {
									'itemID' : itemID,
									'size' : size,
									'quantity' : quantity
								},
								success : function(data) {
									alert('đã thêm sản phẩm vào giỏ hàng');
									var quantityCart = parseInt(document
											.getElementById("quantityCart").innerText) + 1;
									document.getElementById("quantityCart").innerHTML = quantityCart
											.toString();
									alert(quantityCart);
								},
								error : function(data) {
									alert('2')
								}
							});
				}
			} else
				window.location = "http://localhost:8080/com.spring-mvc-demo/Login";
		}
		function getLinkLogin() {
			var link = '<a href="http://localhost:8080/com.spring-mvc-demo/Login"><input type="button" class="btn btn-success" onclick="addItemCart()" value="Thêm vào giỏ hàng"></a>';
			document.write(link);
		}

		function addItemTypeNotActive(itemType) {
			document
					.write('<a href="http://localhost:8080/com.spring-mvc-demo/Home?itemType='
							+ itemType
							+ '" class="list-group-item">'
							+ itemType + '</a>');
		}
		function addItemTypeActive(itemType) {
			document
					.write('<a href="http://localhost:8080/com.spring-mvc-demo/Home?itemType='
							+ itemType
							+ '" class="list-group-item active">'
							+ itemType + '</a>');
		}
		function addHomePageActive() {
			document
					.write('<a href="http://localhost:8080/com.spring-mvc-demo/Home" class="list-group-item active">Toàn bộ sản phẩm</a>');
		}
		function addHomePageNotActive() {
			document
					.write('<a href="http://localhost:8080/com.spring-mvc-demo/Home" class="list-group-item">Toàn bộ sản phẩm</a>');
		}
	</script>
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand"
				href="http://localhost:8080/com.spring-mvc-demo/Home">BK SHOES</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link"
						href="http://localhost:8080/com.spring-mvc-demo/Home">Home <span
							class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#">About</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
					<!-- <li class="nav-item"><a class="nav-link"href="http://localhost:8080/com.spring-mvc-demo/Login">Đăng nhập</a></li>
					<li class="nav-item"><a class="nav-link"href="http://localhost:8080/com.spring-mvc-demo/Login">Đăng xuất</a></li> -->
					<%
						if (username == null) {
							out.print("<script>loggedIn()</script>");
						} else {
							out.print("<script>logout('" + username + "')</script>");
						}
					%>
					<%
						int quantityCart = 0;
						if (session.getAttribute("quantityCart_" + username) != null) {
							quantityCart = (int) session.getAttribute("quantityCart_" + username);
						}
					%>
					<li class="nav-item"><a
						href="http://localhost:8080/com.spring-mvc-demo/Home/Cart"
						class="btn btn-outline-info btn-sm nav-link"><i
							class="fa fa-shopping-cart" aria-hidden="true"></i> Giỏ hàng
							&nbsp;<span id="quantityCart" class="quantityCart"><%=String.valueOf(quantityCart)%></span></a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Page Content -->
	<div class="container">

		<div class="row">

			<div class="col-lg-3">
				<h2 class="my-4">SHOES MENU</h2>
				<div class="list-group">
					<%
						if (itemType != null) {
							out.write("<script>");
							out.write("addHomePageNotActive()");
							out.write("</script>");
						} else {
							out.write("<script>");
							out.write("addHomePageActive()");
							out.write("</script>");
						}
					%>
					<%
						ArrayList<String> allItemType = connection.getItemType();
						for (String s : allItemType) {
							if (s.equals(itemType)) {
								out.write("<script>");
								out.write("addItemTypeActive('" + s + "')");
								out.write("</script>");
							} else {
								out.write("<script>");
								out.write("addItemTypeNotActive('" + s + "')");
								out.write("</script>");
							}
						}
					%>
				</div>
			</div>
			<!-- /.col-lg-3 -->

			<div class="col-lg-9">

				<div class="card mt-4">
					<img class="card-img-top img-fluid" width="auto" height="auto"
						src="<c:url value="<%=itemImg%>"/>">
					<div class="card-body">
						<h2 class="card-title"><%=itemName%></h2>
						<h3 style="color: red; font-weight: bold;">
							<fmt:formatNumber value="<%=itemPrice%>" type="number" />
							đ
						</h3>
						<h5 style="font-weight: lighter;"><%=itemDetail%></h5>
						<!-- span class="text-warning">&#9733; &#9733; &#9733; &#9733;
							&#9734;</span> 4.0 stars -->
						<div>
							<label style="font-weight: bold;">Chọn màu:</label>
							<div class="btn-group" role="group" aria-label="Third group">
								<button type="button" class="btn btn-light active"><%=itemColor%></button>
								<%
									Set<String> ketset = sameItemColor.keySet();
									for (String id : ketset) {
										out.write("<script>");
										out.write("addColor('" + id + "','" + sameItemColor.get(id) + "')");
										out.write("</script>");
									}
								%>
							</div>
						</div>
						<hr>
						<div style="display: inline;">
							<label style="font-weight: bold;">Chọn size: </label>
							<p id="getSize" style="font-weight: bold; width: 100px;"></p>
							<p id="available"></p>
						</div>
						<div class="btn-group" role="group" aria-label="Third group">
							<%
								Set<String> keySet = sizeItem.keySet();
								for (String size : keySet) {
									out.write("<script>");
									out.write("addSize('" + size + "', '" + String.valueOf(sizeItem.get(size)) + "')");
									out.write("</script>");
								}
							%>
						</div>
						<hr>
						<h5>
							Số lượng x <input type="number" name="quantity" id="quantity"
								value=1 min="0" max="100" /> <br>
							<button class="btn btn-success"
								onclick="addCartItem('<%=itemID%>')">Thêm vào giỏ hàng</button>
						</h5>
					</div>

				</div>
				<!-- /.card -->

				<div class="card card-outline-secondary my-4">
					<div class="card-header">
						<h3 style="font-weight: lighter;">Thông tin chi tiết</h3>
					</div>
					<div class="card-body">
						<p>
							Loại giày :
							<%=itemType%></p>
						<hr>
						<p>
							Made in :
							<%=madeIn%></p>
						<hr>
						<p>
							Công ty sản xuất :
							<%=productionCompany%></p>
						<hr>
						<p>
							Ngày sản xuất :
							<%=dateOfMade%></p>
					</div>
				</div>
				<!-- /.card -->

			</div>
			<!-- /.col-lg-9 -->

		</div>

	</div>
	<!-- /.container -->

	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2020</p>
		</div>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

</body>

</html>
