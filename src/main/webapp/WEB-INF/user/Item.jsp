<%@page import="com.hoan.Entity.CartItem"%>
<%@page import="com.hoan.Entity.Cart"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hoan.Model.Item"%>
<%@page import="com.hoan.Model.Order"%>
<%@page import="com.hoan.Model.ItemsInfor"%>
<%@page import="com.hoan.Model.OrdersInfor"%>
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
<link href="<c:url value="/resources/admintemplate/css/User_Item.css"/>"
	rel="stylesheet" />

</head>

<body>
	<%
		Item itemModel = new Item();
		ItemsInfor itemInforModel = new ItemsInfor();
		Order orderModel = new Order();
		OrdersInfor ordersInforModel = new OrdersInfor();

		String itemDetail, itemImg, itemName, itemType, dateOfMade, productionCompany, madeIn, itemColor;
		int itemPrice, stocking;

		String itemID = request.getParameter("itemID");
		String username = (String) session.getAttribute("user");

		HashMap<String, Object> item = itemModel.getItem(itemID);
		itemDetail = (String) item.get("itemDetail");
		itemImg = ((String) item.get("itemImg")).substring(20);
		itemName = (String) item.get("itemName");
		itemPrice = itemInforModel.getItemPrice(itemID).get(1);
		stocking = itemInforModel.getSumStockItem(itemID).get(0);
		itemType = (String) item.get("itemType");
		dateOfMade = (String) item.get("dateOfMade");
		productionCompany = (String) item.get("productionCompany");
		madeIn = (String) item.get("madeIn");
		itemColor = (String) item.get("itemColor");

		HashMap<String, Integer> sizeItem = itemInforModel.getSize(itemID);
		HashMap<String, String> sameItemColor = itemInforModel.getSameItemColor(itemName, itemColor);
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
	<%if (username == null)
				out.print("var username= null;");
			else
				out.print("var username= '" + username + "';");%>
		if (username != null) {
				var size = document.getElementById("getSize").textContent;
				var quantity = document.getElementById("quantity").value;
				if (size == '') {
					alert('bạn chưa chọn size');
				} else if (quantity < 1) {
					alert('chọn sai số lượng');
				} else {
					quantity = quantity.toString();
					$
							.ajax({
								type : 'POST',
								url : '/com.spring-mvc-demo/UserActions',
								dataType : 'JSON',
								data : {
									'itemID' : itemID,
									'size' : size,
									'quantity' : quantity,
									'action' : 'addCartItem'
								},
								success : function(data) {
									alert('đã thêm sản phẩm vào giỏ hàng');
									var quantityCart = parseInt(document
											.getElementById("quantityCart").innerText) + 1;
									document.getElementById("quantityCart").innerHTML = quantityCart
											.toString();
									
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

				<div class="card card-outline-secondary my-4">
					<div class="card-header">
						<h3 style="font-weight: lighter;">Bình luận</h3>
					</div>
					<div class="card-body">
						<div class="bootstrap snippets">
							<div class="panel">
								<div class="panel-body">
									<textarea class="form-control" rows="2"
										placeholder="What are you thinking?"></textarea>
									<div class="mar-top clearfix">
										<button class="btn btn-sm btn-primary pull-right"
											type="submit">
											<i class="fa fa-pencil fa-fw"></i> Send
										</button>
										<a class="btn btn-trans btn-icon fa fa-camera add-tooltip"
											href="#"></a>
									</div>
									<img alt="" src="<c:url value="/resources/images/avatar_login.png"/>"> 
								</div>
							</div>

						</div>

						<div class="media-block">
							<a class="media-left" href="#"><img class="img-circle img-sm"
								alt="Profile Picture"
								src="https://bootdey.com/img/Content/avatar/avatar1.png"></a>
							<div class="media-body">
								<div class="mar-btm">
									<a href="#"
										class="btn-link text-semibold media-heading box-inline">Lisa
										D.</a>
									<p class="text-muted text-sm">
										<i class="fa fa-mobile fa-lg"></i> - From Mobile - 11 min ago
									</p>
								</div>
								<p>consectetuer adipiscing elit, sed diam nonummy nibh
									euismod tincidunt ut laoreet dolore magna aliquam erat
									volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci
									tation ullamcorper suscipit lobortis nisl ut aliquip ex ea
									commodo consequat.</p>
								<div class="pad-ver">
									<div class="btn-group">
										<a class="btn btn-sm btn-default btn-hover-success" href="#"><i
											class="fa fa-thumbs-up"></i></a> <a
											class="btn btn-sm btn-default btn-hover-danger" href="#"><i
											class="fa fa-thumbs-down"></i></a>
									</div>
									<a class="btn btn-sm btn-default btn-hover-primary" href="#">Comment</a>
								</div>
								<hr>

								<!-- Comments -->
								<div>
									<div class="media-block">
										<a class="media-left" href="#"><img
											class="img-circle img-sm" alt="Profile Picture"
											src="https://bootdey.com/img/Content/avatar/avatar2.png"></a>
										<div class="media-body">
											<div class="mar-btm">
												<a href="#"
													class="btn-link text-semibold media-heading box-inline">Bobby
													Marz</a>
												<p class="text-muted text-sm">
													<i class="fa fa-mobile fa-lg"></i> - From Mobile - 7 min
													ago
												</p>
											</div>
											<p>Sed diam nonummy nibh euismod tincidunt ut laoreet
												dolore magna aliquam erat volutpat. Ut wisi enim ad minim
												veniam, quis nostrud exerci tation ullamcorper suscipit
												lobortis nisl ut aliquip ex ea commodo consequat.</p>
											<div class="pad-ver">
												<div class="btn-group">
													<a class="btn btn-sm btn-default btn-hover-success active"
														href="#"><i class="fa fa-thumbs-up"></i> You Like it</a> <a
														class="btn btn-sm btn-default btn-hover-danger" href="#"><i
														class="fa fa-thumbs-down"></i></a>
												</div>
												<a class="btn btn-sm btn-default btn-hover-primary" href="#">Comment</a>
											</div>
											<hr>
										</div>
									</div>

									<div class="media-block">
										<a class="media-left" href="#"><img
											class="img-circle img-sm" alt="Profile Picture"
											src="https://bootdey.com/img/Content/avatar/avatar3.png">
										</a>
										<div class="media-body">
											<div class="mar-btm">
												<a href="#"
													class="btn-link text-semibold media-heading box-inline">Lucy
													Moon</a>
												<p class="text-muted text-sm">
													<i class="fa fa-globe fa-lg"></i> - From Web - 2 min ago
												</p>
											</div>
											<p>Duis autem vel eum iriure dolor in hendrerit in
												vulputate ?</p>
											<div class="pad-ver">
												<div class="btn-group">
													<a class="btn btn-sm btn-default btn-hover-success"
														href="#"><i class="fa fa-thumbs-up"></i></a> <a
														class="btn btn-sm btn-default btn-hover-danger" href="#"><i
														class="fa fa-thumbs-down"></i></a>
												</div>
												<a class="btn btn-sm btn-default btn-hover-primary" href="#">Comment</a>
											</div>
											<hr>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>



			</div>
			<!-- /.col-lg-9 -->

		</div>
	</div>

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
