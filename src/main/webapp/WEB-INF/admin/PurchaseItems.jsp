<%@page import="com.hoan.Model.Entity.PurchaseOrder"%>
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
<title>Dashboard - SB Admin</title>
<link href="<c:url value="/resources/admintemplate/css/styles.css"/>"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" />
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
%>
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
						<div class="table-responsive col-lg-11">
							<div class="dropdown ">
								<button class="btn btn-primary" data-toggle="modal"
									style="display: inline;" data-target="#myModal">Nhập
									sản phẩm</button>
								<a href="http://localhost:8080/com.spring-mvc-demo/Admin/PurchaseOrderHistory"><button class="btn btn-primary"style="display: inline;">Lịch sử nhập hàng</button></a>
								<h5 id="today" style="display: inline; float: right;"></h5>
							</div>
							<table class="table" id="CartTable" style="text-align: center;">
								<thead>
									<tr>
										<th>Mã</th>
										<th>Ảnh</th>
										<th>Thông tin</th>
										<th>Giá nhập</th>
										<th>Giá bán</th>
										<th>Số lượng</th>
										<th>Thành tiền</th>
										<th></th>
										<th></th>
										<th></th>
									</tr>
								</thead>
								<tbody id="TableImportBody">
								</tbody>
								<tfoot style="border-top: 1px solid #ddd;" >
									<tr>
										<td colspan="7" style="text-align: right;">
											<h5>Total:&nbsp;<span style="color: red; font-weight: bold;"
											id="Total"></span></h5>
										</td>
										<td></td>
										<td></td>
										<td><button class="btn btn-primary" onclick="savePurchaseOrder()">Thanh toán</button></td>
									</tr>
								</tfoot>
							</table>
						</div>
					</div>
			</main>
			<div class="modal" id="myModal">
				<div class="col-md-9" style="float: none; margin: auto;">
					<div class="modal-content">
						<!-- Modal Header -->
						<div class="modal-header">
							<h4 class="modal-title">Nhập hàng</h4>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>

						<!-- Modal body -->
						<div class="modal-body">
							<div class="row">
								<div class="col-sm-3">
									<form id="formSearch">
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
								<div class="table-responsive col-sm-9">
									<form id="formSelect">
										<table class="table" id="CartTable">
											<!-- style="overflow-y: scroll; height: 500px; width: 100%; display: block;" -->
											<thead>
												<tr>
													<th>Select</th>
													<th>Mã</th>
													<th>Ảnh</th>
													<th>Thông tin</th>
													<th>Có thể bán</th>
													<th>Tồn kho</th>
												</tr>
											</thead>
											<tbody id="TableSelectBody">
											</tbody>
										</table>
										<input type="text" id="action" name="action"
											value="addPurchaseItems" style="visibility: hidden;">
									</form>
								</div>
							</div>
						</div>

						<!-- Modal footer -->
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								onclick="addPurchaseItems()" data-dismiss="modal">Thêm</button>
						</div>

					</div>
				</div>
			</div>
			<div class="modal fade" id="exampleModalCenter" tabindex="-1"
				role="dialog" aria-labelledby="exampleModalCenterTitle"
				aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header">
							<input type="text" style="display: inline; width: 100px;"
								class="form-control" id="itemID" readonly>&nbsp;&nbsp; <select
								class="form-control" id="sizeSelected"
								style="display: inline; width: 100px;"
								onchange="addSizePurchase()">
								<option>36</option>
								<option>37</option>
								<option>38</option>
								<option>39</option>
								<option>40</option>
								<option>41</option>
								<option>42</option>
								<option>43</option>
								<option>44</option>
							</select>
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<div class="modal-body">
							<table class="table">
								<thead>
									<tr>
										<th>Size</th>
										<th>Số lượng</th>
										<th></th>
									</tr>
								</thead>
								<tbody id="importSizeBody">
								</tbody>
							</table>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-success"
								onclick="getPurchaseItems()" data-dismiss="modal">OK</button>
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
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
	<script>
		getPurchaseItems();

		searchItem();

		document.getElementById("today").innerHTML = "Ngày : "
				+ new Date().toISOString().split("T")[0];
		
		function getTotalPurchase() {
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
				dataType : 'JSON',
				data : {
					"action" : "getTotalPurchase"
				},
				success : function(data) {
					$("#Total").html(formatNumber(data.totalPurchase));
				},
				error :function(data) {
					alert('getTotalPurchase falied');
				}
			});
		}

		function importSize(itemID) {
			var html_code = '';
			$
					.ajax({
						type : 'POST',
						url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
						dataType : 'JSON',
						data : {
							"action" : "getPurchaseItemSizes",
							"itemID" : itemID
						},
						success : function(data) {
							$(data)
									.each(
											function() {
												html_code += '<tr><th>'
														+ this.size
														+ '</th><th><input type="number" onchange="updateSizePurchase('
														+ this.size2
														+ ', this.value)" min=0 value='
														+ this.quantity
														+ '></th><th><button class="btn btn-danger" type="button" onclick="removeSizePurchase('
														+ this.size2
														+ ')"><i class="fas fa-trash-alt"></i></button></th></tr>';
											});
							$("#importSizeBody").html(html_code);
							document.getElementById("itemID").value = itemID;
							$("#exampleModalCenter").modal();
						},
						error : function() {
							alert('error')
						}
					});
		};

		function addSizePurchase() {
			var itemID = document.getElementById("itemID").value;
			var size = document.getElementById("sizeSelected").value;
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
				dataType : 'JSON',
				data : {
					"action" : "addSizePurchase",
					"itemID" : itemID,
					"size" : size
				},
				success : function(data) {
					if (data.failed != null)
						alert(data.failed);
					else
						importSize(itemID);
				},
				error : function(data) {
					alert('error');
				}
			});
		};

		function updateSizePurchase(size, quantity) {
			var itemID = document.getElementById("itemID").value;
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
				dataType : 'JSON',
				data : {
					"action" : "updateSizePurchase",
					"itemID" : itemID,
					"size" : size,
					"quantity" : quantity
				},
				success : function(data) {
					importSize(itemID);
				},
				error : function(data) {
					alert('error');
				}
			});
		};

		function removeSizePurchase(size) {
			var itemID = document.getElementById("itemID").value;
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
				dataType : 'JSON',
				data : {
					"action" : "removeSizePurchase",
					"itemID" : itemID,
					"size" : size,
				},
				success : function(data) {
					importSize(itemID);
				},
				error : function(data) {
					alert('error');
				}
			});
		};

		function updatePurchasePrice(itemID, purchasePrice) {
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
				dataType : 'JSON',
				data : {
					"action" : "updatePurchasePrice",
					"itemID" : itemID,
					"purchasePrice" : purchasePrice
				},
				success : function(data) {
					getPurchaseItems();
				},
				error : function(data) {
					alert('error');
				}
			});
		};

		function updateSalePrice(itemID, salePrice) {
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
				dataType : 'JSON',
				data : {
					"action" : "updateSalePrice",
					"itemID" : itemID,
					"salePrice" : salePrice
				}
			});
		};

		function addPurchaseItems() {
			/* alert("start"); */
			var form = $('#formSelect');
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
				dataType : 'JSON',
				data : form.serialize(),
				success : function(data) {
					/* alert("add successfully"); */
					getPurchaseItems();
				},
				error : function(data) {
					alert("add failed");
				}
			});
		};

		function removePurchaseItems(itemID) {
			var form = $('#formImport');
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
				dataType : 'JSON',
				data : {
					"action" : "removePurchaseItems",
					"itemID" : itemID
				},
				success : function(data) {
					getPurchaseItems();
				},
				error : function(data) {
					alert("error");
				}
			});
		}

		function getPurchaseItems() {
			var html_code = '';
			$
					.ajax({
						type : 'POST',
						url : '/com.spring-mvc-demo/Admin/PurchaseItemsActions',
						dataType : 'JSON',
						data : {
							"action" : "getPurchaseItems"
						},
						success : function(data) {
							/* alert('in success'); */
							$(data)
									.each(
											function() {
												html_code += '<tr>';
												html_code += '<td><strong>'
														+ this.itemID + '</strong></td>';
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
														+ '</p></div></td>';
												html_code += '<td><input class="form-control" type="number" min=0 step=1000 onchange="updatePurchasePrice('
														+ this.itemID2
														+ ', this.value)" value="'
														+ this.purchasePrice
														+ '" ></td>';
												html_code += '<td><input class="form-control" type="number" min=0 step=1000 onchange="updateSalePrice('
														+ this.itemID2
														+ ', this.value)" value="'
														+ this.salePrice
														+ '" ></td>';
												html_code += '<td><strong>'
														+ this.totalQuantity
														+ '</strong></td>';
												html_code += '<td><span style="color : red;">'
														+ formatNumber(this.totalPurchase)
														+ '</span></td>';
												html_code += '<td></td>';
												html_code += '<td><button class="btn btn-success" type="button" onclick="importSize('
														+ this.itemID2
														+ ')"><i class="fas fa-plus"></i></button></td>';
												html_code += '<td><button class="btn btn-danger" type="button" onclick="removePurchaseItems('
														+ this.itemID2
														+ ')"><i class="fas fa-trash-alt"></i></button></td>';
												html_code += '</tr>';
											});
							$('#TableImportBody').html(html_code);
						},
						error : function(data) {
							alert('in error');
						}
					});
			getTotalPurchase();
		};

		function searchItem() {
			var form = $('#formSearch');
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
														+ '</p></div></td>';
												html_code += '<td>'
														+ this.available
														+ '</td>';
												html_code += '<td>'
														+ this.inventory
														+ '</td>';
												html_code += '</tr>';
											});
							$('#TableSelectBody').html(html_code);
						},
						error : function(data) {
							alert('in error');
						}
					});
		};
		
		function savePurchaseOrder() {
			$.ajax({
				type : "POST",
				url : "/com.spring-mvc-demo/Admin/PurchaseItemsActions",
				dataType : "JSON",
				data : {
					"action" : "savePurchaseOrder"
				},
				success : function(data) {
					alert('Nhập hàng thành công');
					getPurchaseItems();
				},
				error : function(data) {
					alert('Chưa có sản phẩm trong đơn nhập hàng');
				}
			});
		};
		
		function formatNumber(num) {
			return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
					+ 'đ';
		}
	</script>
</body>
</html>
