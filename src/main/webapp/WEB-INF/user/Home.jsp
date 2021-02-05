<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hoan.Model.Entity.Cart"%>
<%@page import="com.hoan.Model.Entity.CartItem"%>
<%@page import="com.hoan.Model.DAO.Item"%>
<%@page import="com.hoan.Model.DAO.Order"%>
<%@page import="com.hoan.Model.DAO.ItemsInfor"%>
<%@page import="com.hoan.Model.DAO.OrdersInfor"%>
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

<title>Shop Homepage - Start Bootstrap Template</title>

<!-- Bootstrap core CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<style type="text/css">
body {
	padding-top: 56px;
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

<body>
	<%
		Item itemModel = new Item();
		ItemsInfor itemInforModel = new ItemsInfor();
		Order orderModel = new Order();
		OrdersInfor ordersInforModel = new OrdersInfor();
		String itemType = (String) request.getParameter("itemType");
	%>
	<script>
		function formatNumber(num) {
			return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
					+ 'đ';
		}

		function addTag(tag) {
			var html_code = '';
			html_code += '<div class="custom-control custom-checkbox"> <input class="custom-control-input" onChange="searchItem()" type="checkbox" name="Tag" id="'
					+ tag
					+ '" value="'
					+ tag
					+ '"> <label class="custom-control-label" for="'+tag+'">'
					+ tag + '</label></div>';
			document.write(html_code);
		}

		function addShoe(itemID, itemImg, itemName, itemPrice, itemDetail,
				stocking) {
			var html_code = '<div class="col-lg-4 col-md-6 mb-4" >';
			html_code += '<div class="card h-100">';
			html_code += '<a href="http://localhost:8080/com.spring-mvc-demo/Home/Item?itemID='
					+ itemID
					+ '"><img class="card-img-top" width="300" height="250" src="<c:url value="'+itemImg+'"/>"></a>';
			html_code += '<div class="card-body">';
			html_code += '<h4 class="card-title" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"><a href="http://localhost:8080/com.spring-mvc-demo/Home/Item?itemID='
					+ itemID + '">' + itemName + '</a></h4>';
			html_code += '<h5>' + formatNumber(itemPrice) + '</h5>';
			html_code += '<p class="card-text" style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;">'
					+ itemDetail + '</p></div>';
			html_code += '<div class="card-footer">';
			if (stocking > 0) {
				html_code += '<h5 style="color:limegreen;text-align: center;">Còn '
						+ stocking + ' sản phẩm</h5>';
			} else {
				html_code += '<h5 style="color:red;text-align: center;">Hết hàng</h5>';
			}
			html_code += '</div></div></div>';
			document.write(html_code);
		}

		function loggedIn() {
			document
					.write('<li class="nav-item"><a class="nav-link" href="http://localhost:8080/com.spring-mvc-demo/Login">Đăng nhập</a></li>');
		}
		function logout(username) {
			document
					.write('<li class="nav-item"><a class="nav-link"href="http://localhost:8080/com.spring-mvc-demo/Login">Đăng xuất</a></li>');
			/* document
					.write('<li class="nav-item"><i class="fas fa-user fa-fw"></i><span class="nav-link">'
							+ username + '</span></li>'); */
		}
	</script>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand"
				href="http://localhost:8080/com.spring-mvc-demo/Home" style="">BK
				SHOES</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item active"><a class="nav-link"
						href="http://localhost:8080/com.spring-mvc-demo/Home">Home <span
							class="sr-only">(current)</span>
					</a></li>
					<li class="nav-item"><a class="nav-link" href="#">About</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Contact</a></li>
					<!-- <li class="nav-item"><a class="nav-link"href="http://localhost:8080/com.spring-mvc-demo/Login">Đăng nhập</a></li>
					<li class="nav-item"><a class="nav-link"href="http://localhost:8080/com.spring-mvc-demo/Login">Đăng xuất</a></li> -->
					<%
						String username = (String) session.getAttribute("user");
						System.out.println(username);
						System.out.println(session.getId());
						if (username == null) {
							out.print("<script>loggedIn()</script>");
						} else {
							out.print("<script>logout('" + username + "')</script>");
						}
					%>
					<%
						int quantityCart = 0;
						if (session.getAttribute("quantityCart_" + username) != null) {
							if (((Cart) session.getAttribute("cart_" + username)).getUsername().equals(username)) {

								quantityCart = (int) session.getAttribute("quantityCart_" + username);
							}
						}
					%>
					<li class="nav-item"><a
						href="http://localhost:8080/com.spring-mvc-demo/Home/Cart"
						class="btn btn-outline-info btn-sm nav-link"><i
							class="fa fa-shopping-cart" aria-hidden="true"></i> Giỏ
							hàng&nbsp;<span id="quantityCart" class="quantityCart"><%=String.valueOf(quantityCart)%></span>
					</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Page Content -->
	<div class="container">

		<div class="row">

			<div class="col-lg-3">
				<h2 class="my-4">SHOES MENU</h2>
				<form id="formTag" action="Home/SearchTag" method="POST">
					<div class="dropdown">
						<label><span style="font-weight: bold;">Loại giày</span></label> <select
							class="form-control" id="selectType" name="selectType"
							onchange="searchItem()">
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
					<div class="input-group" style="width: 100%;">
						<input class="form-control" type="text" name="nameSearch"
							placeholder="Search for..." id="nameSearch" aria-label="Search"
							aria-describedby="basic-addon2" />
						<div class="input-group-append">
							<button class="btn btn-primary" type="button"
								onclick="searchItem()">
								<i class="fa fa-search"></i>
							</button>
						</div>
					</div>
					<hr>
					<%
						out.write("<script>");
						ArrayList<String> tags = itemInforModel.getTags();
						for (String s : tags) {
							out.write("addTag('" + s + "');");
						}
						out.write("</script>");
					%>
					<hr>
					<input type="text" id="action" name="action" value="getItemSearch"
						style="visibility: hidden;">
				</form>
			</div>
			<!-- /.col-lg-3 -->

			<div class="col-lg-9">

				<div id="carouselExampleIndicators" class="carousel slide my-4"
					data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carouselExampleIndicators" data-slide-to="0"
							class="active"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="3"></li>
					</ol>
					<div class="carousel-inner" role="listbox">
						<div class="carousel-item active">
							<a href="http://localhost:8080/com.spring-mvc-demo/Home"><img
								class="d-block img-fluid" width="100%"
								src="<c:url value="/resources/images/banner1.jpg"/>"
								alt="First slide"></a>
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid" width="100%"
								src="<c:url value="/resources/images/banner2.jpg"/>"
								alt="Second slide">
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid" width="100%"
								src="<c:url value="/resources/images/banner3.jpg"/>"
								alt="Third slide">
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid" width="100%"
								src="<c:url value="/resources/images/banner4.jpg"/>"
								alt="Four slide">
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleIndicators"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>
				<div class="row" id="items">




					<%
						String itemDetail, itemImg, itemName, dateOfMade, productionCompany, madeIn;
						int itemPrice, stocking;

						if (itemType != null) {
							ArrayList<String> allItemID = itemInforModel.getAllItemType(itemType, "Đang bán");
							for (String itemID : allItemID) {
								System.out.println(itemID);
								HashMap<String, Object> item = itemModel.getItem(itemID);
								itemDetail = (String) item.get("itemDetail");
								itemImg = (String) item.get("itemImg");
								itemName = (String) item.get("itemName");
								dateOfMade = (String) item.get("dateOfMade");
								productionCompany = (String) item.get("productionCompany");
								madeIn = (String) item.get("madeIn");
								itemPrice = itemInforModel.getItemPrice(itemID).get(1);
								stocking = itemInforModel.getSumStockItem(itemID).get(0);

								System.out.println(itemID + " " + itemDetail + " " + itemImg + " " + itemName + " " + stocking + " "
										+ itemType + " " + dateOfMade + " " + productionCompany + " " + madeIn + " " + itemPrice);

								out.write("<script>");
								out.write("addShoe('" + itemID + "', '" + itemImg + "', '" + itemName + "', '"
										+ String.valueOf(itemPrice) + "', '" + itemDetail + "', " + String.valueOf(stocking) + ")");
								out.write("</script>");
							}
						} else {
							ArrayList<String> allItemID = itemInforModel.getAllItemID("Đang bán");
							for (String itemID : allItemID) {
								System.out.println(itemID);
								HashMap<String, Object> item = itemModel.getItem(itemID);
								itemDetail = (String) item.get("itemDetail");
								itemImg = (String) item.get("itemImg");
								itemName = (String) item.get("itemName");;
								itemType = (String) item.get("itemType");
								dateOfMade = (String) item.get("dateOfMade");
								productionCompany = (String) item.get("productionCompany");
								madeIn = (String) item.get("madeIn");
								itemPrice = itemInforModel.getItemPrice(itemID).get(1);
								stocking = itemInforModel.getSumStockItem(itemID).get(0);
								System.out.println(itemID + " " + itemDetail + " " + itemImg + " " + itemName + " " + stocking + " "
										+ itemType + " " + dateOfMade + " " + productionCompany + " " + madeIn + " " + itemPrice);

								out.write("<script>");
								out.write("addShoe('" + itemID + "', '" + itemImg + "', '" + itemName + "', '"
										+ String.valueOf(itemPrice) + "', '" + itemDetail + "', " + String.valueOf(stocking) + ")");
								out.write("</script>");
							}
						}
					%>


				</div>
				<!-- /.row -->

			</div>
			<!-- /.col-lg-9 -->

		</div>
		<!-- /.row -->

	</div>
	<!-- /.container -->

	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">Copyright &copy; Your
				Website 2020</p>
		</div>
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>

	<script>
		var form = $('#formTag');
		function searchItem() {
			var html_code = '';
			$
					.ajax({
						type : 'POST',
						url : '/com.spring-mvc-demo/UserActions',
						dataType : 'JSON',
						data : form.serialize(),
						success : function(data) {
							/* alert(data); */
							$(data)
									.each(
											function() {
												html_code += '<div class="col-lg-4 col-md-6 mb-4" >';
												html_code += '<div class="card h-100">';
												html_code += '<a href="http://localhost:8080/com.spring-mvc-demo/Home/Item?itemID='
														+ this.itemID
														+ '"><img class="card-img-top" width="300" height="250" src="<c:url value="'+this.itemImg+'"/>"></a>';
												html_code += '<div class="card-body">';
												html_code += '<h4 class="card-title" style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"><a href="http://localhost:8080/com.spring-mvc-demo/Home/Item?itemID='
														+ this.itemID
														+ '">'
														+ this.itemName
														+ '</a></h4>';
												html_code += '<h5>'
														+ this.itemPrice
														+ ' đ</h5>';
												html_code += '<p class="card-text" style="display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden;">'
														+ this.itemDetail
														+ '</p></div>';
												html_code += '<div class="card-footer">';
												if (parseInt(this.stocking) > 1) {
													html_code += '<h5 style="color:limegreen;text-align: center;">Còn '
															+ parseInt(this.stocking)
															+ ' sản phẩm</h5>';
												} else {
													html_code += '<h5 style="color:red;text-align: center;">Hết hàng</h5>';
												}
												html_code += '</div></div></div>';

											});
							/* alert(html_code); */
							$('#items').html(html_code);

						},
						error : function(data) {

						}
					});
		};
	</script>

</body>
</html>