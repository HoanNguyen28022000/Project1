<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hoan.Model.Item"%>
<%@page import="com.hoan.Model.Order"%>
<%@page import="com.hoan.Model.ItemsInfor"%>
<%@page import="com.hoan.Model.OrdersInfor"%>
<%@page import="com.hoan.Model.Customers"%>
<%@page import="com.hoan.Entity.Cart"%>
<%@page import="com.hoan.Entity.CartItem"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Shop Homepage - Start Bootstrap Template</title>


<link href="<c:url value="/resources/UserTemplate/css/cart.css"/>"
	rel="stylesheet" />
<!-- Bootstrap core CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.22/css/jquery.dataTables.css">
</head>

<body>
	<%
		Item itemModel = new Item();
		ItemsInfor itemInforModel = new ItemsInfor();
		Order orderModel = new Order();
		OrdersInfor ordersInforModel = new OrdersInfor();
		Customers customersModel= new Customers();

		String username = (String) session.getAttribute("user");

		HashMap<String, Object> userinfor = customersModel.getUserInfor(username);
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
		function formatNumber(num) {
			return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
					+ 'đ';
		}
	</script>
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

	<div class="container" id="cartcontainer">
		<div class="card-header bg-dark text-light">
			<a style="background-color:"
				href="http://localhost:8080/com.spring-mvc-demo/Home"
				class="btn btn-outline-info btn-sm"> Tiếp tục mua sắm </a>
		</div>

		<div class="" id="cartcontent" style="padding-bottom: 100px;">
			<!-- Shopping Cart-->
			<div class="table-responsive shopping-cart">
				<table class="table" id="CartTable">
					<thead>
						<tr>
							<th>Product Name</th>
							<th class="text-center">Quantity</th>
							<th class="text-center">Price</th>
							<th class="text-center"><a
								class="btn btn-sm btn-outline-danger" href="#">Clear Cart</a></th>
						</tr>
					</thead>
					<tbody id="cartbody"></tbody>
				</table>
			</div>
			<div class="shopping-cart-footer cog">
				<div class="column">
					<form class="coupon-form" method="post">
						<input class="form-control form-control-sm" type="text"
							placeholder="Coupon code" >
						<button class="btn btn-outline-primary btn-sm" type="submit">Apply
							Coupon</button>
					</form>
				</div>
				<div style="padding-left: 0; padding-top: 10px; display: inline;">
					Subtotal: <span style="color: red; font-weight: bold;"
						id="Subtotal"></span>
				</div>
			</div>
			<div class="shopping-cart-footer">
				<div class="column">
					<button id="btn-checkout" class="btn btn-success"
						data-toggle="modal" data-target="#myModal">Tiến hành đặt
						hàng</button>
				</div>
			</div>
		</div>
		<%
			int sumMoney = 0;
			if (username != null) {
				sumMoney = customersModel.getSumMoney(username);
			}
		%>
		<h4>
			Lịch sử giao dịch (Tổng chi : <span id="sumMoney" style="color: red;"><%=String.valueOf(sumMoney)%></span>)
		</h4>
		<table class="table" id="orderHistoryTable"
			style="text-align: center;">
			<thead>
				<tr>
					<th></th>
					<th>Thời gian</th>
					<th>Mã đơn hàng</th>
					<th>Điện thoại</th>
					<th>Địa chỉ nhận</th>
					<th>Tổng tiền</th>
					<th>Trạng thái</th>
				</tr>
			</thead>
			<tbody id="orderHistoryBody">

			</tbody>
		</table>


	</div>
	<div class="modal fade" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<article class="card-body mx-auto" style="max-width: 400px;">
					<div class="modal-header">
						<h4 class=" modal-titl">Tiến hành đặt hàng</h4>
						<button type="button" class="close" data-dismiss="modal">×</button>
					</div>
					<form>
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text" style="width: 100px;"> <i
									class="fa fa-user"></i>&nbsp;&nbsp;Họ tên:
								</span>
							</div>
							<input id="fullname" class="form-control" placeholder="Full name"
								value="<%=userinfor.get("fullname")%>" type="text">
						</div>
						<!-- form-group// -->
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text" style="width: 100px;"> <i
									class="fa fa-envelope"></i>&nbsp;&nbsp;Email:
								</span>
							</div>
							<input id="email" class="form-control"
								placeholder="Email address" value="<%=userinfor.get("Email")%>"
								type="email">
						</div>
						<!-- form-group// -->
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text" style="width: 100px;"> <i
									class="fa fa-phone"></i>&nbsp;&nbsp;Phone:
								</span>
							</div>
							<input id="phone" value="<%=userinfor.get("phone")%>"
								class="form-control" placeholder="Phone number" type="number">
						</div>
						<!-- form-group// -->
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text" style="width: 100px;"> <i
									class="fa fa-address-book"></i>&nbsp;&nbsp;Địa chỉ:
								</span>
							</div>
							<input id="address" class="form-control"
								value="<%=userinfor.get("address")%>" type="text">
						</div>
						<!-- form-group end.// -->
						<div class="form-group" style="text-align: center;">
							<button type="submit" class="btn btn-success"
								data-dismiss="modal" style="width: 100%;"
								onclick="confirmOrder()">Đặt hàng</button>
						</div>
						<!-- form-group// -->
					</form>
				</article>

			</div>
		</div>
	</div>
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
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
	<script type="text/javascript" charset="utf8"
		src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.js"></script>

	<script>
		/* document.getElementById("checkoutcontainer").style.visibility = "hidden";
		var checkoutcontainer = document.getElementById("checkoutcontainer").innerHTML; */
		getCart();
		getOrderHistory();

		document.getElementById("sumMoney").innerHTML = formatNumber(parseInt(document
				.getElementById("sumMoney").innerText));

		var subtotal = 0;

		function confirmOrder() {
			var receive_address = document.getElementById("address").value;
			var receive_phone = (document.getElementById("phone").value)
					.toString();
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/UserActions',
				dataType : 'JSON',
				data : {
					"receive_phone" : receive_phone,
					"receive_address" : receive_address,
					"subtotal" : subtotal,
					"action" : "confirmOrder"
				},
				success : function(data) {
					alert("Đặt hàng thành công");
					getCart();
					location.reload();
				},
				error : function(data) {
					alert("Đặt hàng failed");
				}
			});
			location.reload();
		}

		/* function checkout() {
			document.getElementById("cartcontent").innerHTML = checkoutcontainer;
		} */

		function update(quantityupdate, itemID) {
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/UserActions',
				dataType : 'JSON',
				data : {
					"quantityupdate" : quantityupdate.toString(),
					"itemID" : itemID,
					"action" : "updateCart"
				},
				success : function(data) {
					/* alert("updated quantity:" +data); */
					getCart();
				}
			});
			/* location.reload(); */
		}

		function getCart() {
			var cartcontent = '';
			$
					.ajax({
						url : '/com.spring-mvc-demo/UserActions',
						type : 'POST',
						dataType : 'JSON',
						data : {
							"action" : "getCart"
						},
						success : function(data) {
							subtotal = 0;
							console.log(data.length);
							if (data.length == 0) {
								$('#btn-checkout').remove();
								$('#Subtotal').html(
										subtotal.toString() + ' VND');
							} else {
								$(data)
										.each(
												function() {
													subtotal += parseInt(this.subtotal);
													cartcontent += '<tr><td><div class="product-item"><a class="product-thumb" href="#"><img src="<c:url value="';
													cartcontent+=	this.itemImg+'"/>"></a><div class="product-info"><h4 class="product-title"><a href="#">';
													cartcontent += this.itemName
															+ '</a></h4><span><em>Size: </em>';
													cartcontent += this.size
															+ '</span><span><em>Color: </em>';
													cartcontent += this.color
															+ '</span></div></div></td>';
													cartcontent += '<td class="text-center"><input class="count-input" type="number" id="';
													cartcontent += this.itemID
															+ '" value="'
															+ this.quantity
															+ '" min="0" max="100" onchange="update(this.value,'
															+ this.itemID
															+ ')"/></td>';
													cartcontent += '<td class="text-center text-lg text-medium">'
															+ formatNumber(this.itemPrice)
															+ '</td>';
													cartcontent += '<td class="text-center"><button class="btn btn-danger" onclick="deleteItemCart('
															+ this.itemID
															+ ')"><i class="fa fa-trash"></i></button></td></tr>';
												});
								$('#cartbody').html(cartcontent);
								$('#Subtotal').html(formatNumber(subtotal));
							}
						},

						error : function(data) {
							alert("4");
						}
					});
		}

		function deleteItemCart(itemID) {
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/UserActions',
				dataType : 'JSON',
				data : {
					"itemID" : itemID,
					"action" : "deleteItemCart"
				},
				success : function(data) {
					getCart();
				}
			});
			/* alert('deleted'); */
			location.reload();
			/* getCart(); */
		}

		function showOrderDetail(orderID) {
			/* alert('1'); */
			var html_code = '';
			html_code += '<div class="table-responsive table-bordered"><table class="table" id="CartTable">';
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

		function getOrderHistory() {
			var html_code = '';
			$
					.ajax({
						url : '/com.spring-mvc-demo/UserActions',
						type : 'POST',
						dataType : 'JSON',
						data : {
							"action" : "getOrderHistory"
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
												html_code += '<td>'
														+ this.timeConfirm
														+ '</td>';
												html_code += '<td>'
														+ this.orderID
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
												html_code += '<td>'
														+ this.order_status
														+ '</td>';
												html_code += '</tr>';
												html_code += '<tr class="hide-table-padding"><td colspan="9"><div id="order_'
														+this.orderID+'" class="collapse"><div class="container" id="orderDetail_'+this.orderID+'"></div></div></td></tr>'
											});
							$('#orderHistoryBody').html(html_code);
						},
						error : function(data) {
							alert('get order failed');
						}
					});
		}
	</script>
</body>
</html>