<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hoan.Connection.ConnectSQLServer"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="	vi-VN" />
<!DOCTYPE html>
<html lang="vi">
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
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/js/all.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<style>

/*the container must be positioned relative:*/
.autocomplete {
	position: relative;
	display: inline-block;
}

.autocomplete-items {
	position: absolute;
	border: 1px solid #d4d4d4;
	border-bottom: none;
	border-top: none;
	z-index: 99;
	/*position the autocomplete items to be the same width as the container:*/
	top: 100%;
	left: 150px;
	right: 0;
}

.autocomplete-items div {
	padding: 10px;
	cursor: pointer;
	background-color: #fff;
	border-bottom: 1px solid #d4d4d4;
}

/*when hovering an item:*/
.autocomplete-items div:hover {
	background-color: #e9e9e9;
}

/*when navigating through the items using the arrow keys:*/
.autocomplete-active {
	background-color: DodgerBlue !important;
	color: #ffffff;
}

.alert {
	padding: 5px;
	background-color: LightGray; /* Red */
	color: white;
	margin-top: 20px;
	margin-bottom: 20px;
}

.close {
	margin-left: 15px;
	color: white;
	font-weight: bold;
	float: right;
	font-size: 22px;
	line-height: 20px;
	cursor: pointer;
	transition: 0.3s;
	float: right;
}
</style>
</head>
<body class="sb-nav-fixed">
	<script>
		function checkSize(size) {
			console.log(size);
			document.getElementById(size).checked = true;
		}
		function checkStocking(stocking) {
			console.log(stocking);
			if (stocking == 1)
				document.getElementById("stocking").checked = true;
		}
	</script>
	<%
		String itemID = request.getParameter("itemID");

		String itemDetail, itemImg, itemName, stocking, itemType, dateOfMade, productionCompany, madeIn, itemColor;

		ConnectSQLServer connection = new ConnectSQLServer();

		HashMap<String, Object> item = connection.getItem(itemID);
		itemDetail = (String) item.get("itemDetail");
		itemImg = ((String) item.get("itemImg")).substring(20);
		itemName = (String) item.get("itemName");
		itemType = (String) item.get("itemType");
		dateOfMade = (String) item.get("dateOfMade");
		productionCompany = (String) item.get("productionCompany");
		madeIn = (String) item.get("madeIn");
		itemColor = (String) item.get("itemColor");

		int itemPrice = connection.getItemPrice(itemID).get(1);
	%>
	<jsp:include page="/WEB-INF/admin/head.jsp"></jsp:include>
	<div id="layoutSidenav">
		<jsp:include page="/WEB-INF/admin/SlideMenu.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<main>
				<form class="container-fluid" action="fileuploadservlet"
					style="padding-top: 30px;" method="post"
					enctype="multipart/form-data">
					<!-- <input type="submit" style="float: right;" class="btn btn-success" value="Thay đổi"> -->
					<div class="row">
						<div class="col-lg-6">
							<h2>Thay đổi sản phẩm</h2>
							<hr>
							<div class="form-group input-group">
								<div class="input-group-prepend">
									<span style="width: 150px;" class="input-group-text"> <i
										class="fa fa-user"></i>&nbsp;&nbsp;ID:
									</span>
								</div>
								<input name="itemID" id="itemID" class="form-control" readonly
									placeholder="ID sản phẩm" value="<%=itemID%>" type="text">
							</div>

							<div class="form-group input-group">
								<div class="input-group-prepend">
									<span style="width: 150px;" class="input-group-text"> <i
										class="fa fa-envelope"></i>&nbsp;&nbsp;Tên:
									</span>
								</div>
								<input name="itemName" id="itemName" class="form-control"
									placeholder="Tên sản phẩm" value="<%=itemName%>" type="text">
							</div>

							<div class="form-group input-group">
								<div class="input-group-prepend">
									<span style="width: 150px;" class="input-group-text"> <i
										class="fa fa-address-book"></i>&nbsp;&nbsp;Loại giày:
									</span>
								</div>
								<input id="itemType" name="itemType" class="form-control"
									placeholder="Loại giày" value="<%=itemType%>" type="text">
							</div>
							<div class="form-group input-group">
								<div class="input-group-prepend">
									<span style="width: 150px;" class="input-group-text"> <i
										class="fa fa-address-book"></i>&nbsp;&nbsp;Màu:
									</span>
								</div>
								<input id="itemColor" name="itemColor" class="form-control"
									placeholder="màu" value="<%=itemColor%>" type="text">
							</div>
							<div class="form-group input-group">
								<div class="input-group-prepend">
									<span style="width: 150px;" class="input-group-text"> <i
										class="fa fa-address-book"></i>&nbsp;&nbsp;Ngày sản xuất:
									</span>
								</div>
								<input id="dateOfMade" name="dateOfMade" class="form-control"
									placeholder="yy-mm-dd" value="<%=dateOfMade.substring(0, 10)%>"
									type="date">
							</div>
							<div class="form-group input-group">
								<div class="input-group-prepend">
									<span style="width: 150px;" class="input-group-text"> <i
										class="fa fa-address-book"></i>&nbsp;&nbsp;Nhà máy:
									</span>
								</div>
								<input id="productionCompany" name="productionCompany"
									class="form-control" placeholder="abc"
									value="<%=productionCompany%>" type="text">
							</div>
							<div class="form-group input-group">
								<div class="input-group-prepend">
									<span style="width: 150px;" class="input-group-text"> <i
										class="fa fa-address-book"></i>&nbsp;&nbsp;Made in:
									</span>
								</div>
								<input id="madeIn" name="madeIn" class="form-control"
									placeholder="abc" value="<%=madeIn%>" type="text">
							</div>
							<div class="form-group input-group">
								<div style="width: 150px;" class="input-group-prepend">
									<span style="width: 150px;" class="input-group-text"> <i
										class="fa fa-address-book"></i>&nbsp;&nbsp;Mô tả:
									</span>
								</div>
								<input id="itemDetail" name="itemDetail" class="form-control"
									placeholder="Loại" value="<%=itemDetail%>" type="text">
							</div>
							<!-- <div class="form-group input-group">
							<div class="input-group-prepend">
								<span class="input-group-text"> <i
									class="fa fa-address-book"></i>&nbsp;&nbsp;Size:
								</span>
							</div>
							&nbsp;&nbsp;&nbsp;&nbsp;
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="size"
									id="36" value="36"> <label class="form-check-label"
									for="inlineCheckbox1">36</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="size"
									id="37" value="37"> <label class="form-check-label"
									for="inlineCheckbox1">37</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="size"
									id="38" value="38"> <label class="form-check-label"
									for="inlineCheckbox1">38</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="size"
									id="39" value="39"> <label class="form-check-label"
									for="inlineCheckbox1">39</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="size"
									id="40" value="40"> <label class="form-check-label"
									for="inlineCheckbox1">40</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="size"
									id="41" value="41"> <label class="form-check-label"
									for="inlineCheckbox1">41</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="size"
									id="42" value="42"> <label class="form-check-label"
									for="inlineCheckbox1">42</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="size"
									id="43" value="43"> <label class="form-check-label"
									for="inlineCheckbox1">43</label>
							</div>
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="size"
									id="44" value="44"> <label class="form-check-label"
									for="inlineCheckbox1">44</label>
							</div>
						</div>
						<div class="form-group input-group">
							<div class="form-check form-check-inline">
								<input class="form-check-input" type="checkbox" name="stocking"
									id="stocking" value="1">
							</div>
							<div class="input-group-prepend">
								<span class="input-group-text"> Còn hàng: </span>
							</div>
						</div> -->

						</div>
						<div class="col-lg-6 " style="text-align: center;">
							<h2>Upload Product Here</h2>
							<hr>
							<label for="file">SELECT FILE:</label>&nbsp;&nbsp;&nbsp;<input
								type="file" name="file" id="file" /> <br> <img id="blah"
								src="<c:url value="<%=itemImg%>"/>" width="50%" height="auto" />
						</div>
					</div>
					<hr>
					<div class="row">
						<div class="col-lg-6 ">
							<h4>Lịch sử giá</h4>
							<table class="table" id="priceTable" style="text-align: center;">
								<thead>
									<tr>
										<th>Giá nhập</th>
										<th>Giá bán</th>
										<th>Ngày thay đổi</th>
									</tr>
								</thead>
								<tbody id="priceTableBody">

								</tbody>
							</table>
							<h4>Hàng trong kho</h4>
							<table class="table" id="stockTable" style="text-align: center;">
								<thead>
									<tr>
										<th>Size</th>
										<th>Đang giao dịch</th>
										<th>Có thể bán</th>
										<th>Tồn kho</th>
									</tr>
								</thead>
								<tbody id="stockTableBody">

								</tbody>
							</table>
						</div>
						
						<div class="col-lg-3 ">
							<h4 style="display: inline;">Giá bán hiện tại :</h4>
							&nbsp;&nbsp;
							<h5 id="showPrice" style="display: inline; color: red"></h5>
							<input class="form-control" id="currSalePrice"
								name="currSalePrice" value="<%=String.valueOf(itemPrice)%>"
								style="margin-top: 20px;" type="number" step="1000" min="0"
								onchange="showPrice()" readonly>
							<button class="btn btn-primary" onclick="editSalePrice()"
								type="button" style="float: right; margin-top: 10px;">
								Sửa</button>
						</div>
						<div class="col-lg-3 ">
							<div>
								<h4 style="display: inline;">Tag</h4>
								<button class="btn btn-primary" type="button"
									data-toggle="modal" data-target="#myModal"
									style="display: inline; float: right;">Thêm Tag</button>
							</div>
							<div id="tags"></div>
						</div>
					</div>
					<hr>
					<div class="row">
						
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
	<!-- The Modal -->
	<div class="modal" id="myModal">
		<div class="modal-dialog">
			<div class="modal-content">

				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">Thêm Tag</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<input class="form-control" type="text" id="insertTag" placeholder="nhập tag">
				</div>

				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" onclick="insertTag('<%=itemID%>', '')" class="btn btn-success" data-dismiss="modal">Thêm</button>
				</div>

			</div>
		</div>
	</div>
	<script>
		
	<%-- <%out.write("checkStocking(" + stocking + ");");
			for (String s : size) {
				out.write("checkSize('" + s + "');");
			}%> --%>
		priceHistory();
		showPrice();
		showStock();
		<%out.write("showTags('" + itemID + "');");%>
		
		function editSalePrice() {
			document.getElementById("currSalePrice").readOnly = false;
		}
		
		function showPrice() {
			document.getElementById("showPrice").innerText = formatNumber(document.getElementById("currSalePrice").value);
		}
		
		function deleteTag(itemID, tag) {
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/Admin/Items/DeleteTag',
				dataType : 'JSON',
				data : {
					"tag" : tag,
					"itemID" : itemID
				},
				success : function(data) {
					alert('delete successfully');
					showTags(itemID);
				},
				error : function(data) {
					alert('update failed');
				}
			});
		}
		
		function insertTag(itemID) {
			var tag= document.getElementById("insertTag").value;
			$.ajax({
				type : 'POST',
				url : '/com.spring-mvc-demo/Admin/Items/InsertTag',
				dataType : 'JSON',
				data : {
					"tag" : tag,
					"itemID" : itemID
				},
				success : function(data) {
					alert('insert successfully');
					showTags(itemID);
				},
				error : function(data) {
					alert('insert failed');
				}
			});
		}
		
		function showTags(itemID) {
			var html_code = '';
			$
					.ajax({
						type : 'POST',
						url : '/com.spring-mvc-demo/Admin/Items/GetTags',
						dataType : 'JSON',
						data : {"itemID" : itemID },
						success : function(data) {
							/* alert('in success'); */
							$(data)
									.each(
											function() {
												/* alert('4'); */
												html_code += '<div class="alert"><button onclick="deleteTag('+this.itemID+', '+this.tagFunc+')" type="button" class="close" data-dismiss="alert">&times;</button><strong>'
												+this.tag+'</strong></div>';
											});
							/* alert(html_code); */
							$('#tags').html(html_code);
						},
						error : function(data) {
							alert('in error');
						}
					});
		}
		
		function showStock() {
			html_code= '';
			<%ArrayList<HashMap<String, Object>> stock = connection.getStock(itemID);

			for (HashMap<String, Object> obj : stock) {
				out.print("html_code+= '<tr><td>" + (String)obj.get("size")
						+ "</td><td>"+String.valueOf((int)obj.get("inventory")-(int)obj.get("available"))+"</td><td>" + String.valueOf(obj.get("available")) + "</td><td>"
						+ String.valueOf(obj.get("inventory")) + "</td></tr>';");
			}%>
			document.getElementById("stockTableBody").innerHTML = html_code;
		}
		
		function priceHistory() {
			html_code= '';
			<%ArrayList<HashMap<String, Object>> priceHistory = connection.getHistoryPrice(itemID);

			for (HashMap<String, Object> obj : priceHistory) {
				out.print("html_code+= '<tr><td>'+formatNumber(" + String.valueOf(obj.get("purchase_price"))
						+ ")+'</td><td>'+formatNumber(" + String.valueOf(obj.get("sale_price")) + ")+'</td><td>"
						+ (String) obj.get("effect_time") + "</td></tr>';");
			}%>
			document.getElementById("priceTableBody").innerHTML = html_code;
		}
		
			
		function formatNumber(num) {
			return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1.')
					+ 'đ';
		}
		
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#blah').attr('src', e.target.result);
				}

				reader.readAsDataURL(input.files[0]);
			}
		}

		$("#file").change(function() {
			readURL(this);
		});
		
		function autocomplete(inp, arr) {
			/*the autocomplete function takes two arguments,
			the text field element and an array of possible autocompleted values:*/
			var currentFocus;
			/*execute a function when someone writes in the text field:*/
			inp
					.addEventListener(
							"input",
							function(e) {
								var a, b, i, val = this.value;
								/*close any already open lists of autocompleted values*/
								closeAllLists();
								if (!val) {
									return false;
								}
								currentFocus = -1;
								/*create a DIV element that will contain the items (values):*/
								a = document.createElement("DIV");
								a.setAttribute("id", this.id
										+ "autocomplete-list");
								a.setAttribute("class", "autocomplete-items");
								/*append the DIV element as a child of the autocomplete container:*/
								this.parentNode.appendChild(a);
								/*for each item in the array...*/
								for (i = 0; i < arr.length; i++) {
									/*check if the item starts with the same letters as the text field value:*/
									if (arr[i].substr(0, val.length)
											.toUpperCase() == val.toUpperCase()) {
										/*create a DIV element for each matching element:*/
										b = document.createElement("DIV");
										/*make the matching letters bold:*/
										b.innerHTML = "<strong>"
												+ arr[i].substr(0, val.length)
												+ "</strong>";
										b.innerHTML += arr[i]
												.substr(val.length);
										/*insert a input field that will hold the current array item's value:*/
										b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
										/*execute a function when someone clicks on the item value (DIV element):*/
										b
												.addEventListener(
														"click",
														function(e) {
															/*insert the value for the autocomplete text field:*/
															inp.value = this
																	.getElementsByTagName("input")[0].value;
															/*close the list of autocompleted values,
															(or any other open lists of autocompleted values:*/
															closeAllLists();
														});
										a.appendChild(b);
									}
								}
							});
			/*execute a function presses a key on the keyboard:*/
			inp.addEventListener("keydown", function(e) {
				var x = document.getElementById(this.id + "autocomplete-list");
				if (x)
					x = x.getElementsByTagName("div");
				if (e.keyCode == 40) {
					/*If the arrow DOWN key is pressed,
					increase the currentFocus variable:*/
					currentFocus++;
					/*and and make the current item more visible:*/
					addActive(x);
				} else if (e.keyCode == 38) { //up
					/*If the arrow UP key is pressed,
					decrease the currentFocus variable:*/
					currentFocus--;
					/*and and make the current item more visible:*/
					addActive(x);
				} else if (e.keyCode == 13) {
					/*If the ENTER key is pressed, prevent the form from being submitted,*/
					e.preventDefault();
					if (currentFocus > -1) {
						/*and simulate a click on the "active" item:*/
						if (x)
							x[currentFocus].click();
					}
				}
			});
			function addActive(x) {
				/*a function to classify an item as "active":*/
				if (!x)
					return false;
				/*start by removing the "active" class on all items:*/
				removeActive(x);
				if (currentFocus >= x.length)
					currentFocus = 0;
				if (currentFocus < 0)
					currentFocus = (x.length - 1);
				/*add class "autocomplete-active":*/
				x[currentFocus].classList.add("autocomplete-active");
			}
			function removeActive(x) {
				/*a function to remove the "active" class from all autocomplete items:*/
				for (var i = 0; i < x.length; i++) {
					x[i].classList.remove("autocomplete-active");
				}
			}
			function closeAllLists(elmnt) {
				/*close all autocomplete lists in the document,
				except the one passed as an argument:*/
				var x = document.getElementsByClassName("autocomplete-items");
				for (var i = 0; i < x.length; i++) {
					if (elmnt != x[i] && elmnt != inp) {
						x[i].parentNode.removeChild(x[i]);
					}
				}
			}
			/*execute a function when someone clicks in the document:*/
			document.addEventListener("click", function(e) {
				closeAllLists(e.target);
			});
		}

		var itemType = [ "Adidas", "Nike", "Converse", "McQueen", "Puma",
				"Balenciaga", "Gucci", "Anta", "Dolce & Gabbana", "MLB",
				"Domba", "Lacoste", "Burberry", "Vans", "New Balance", "Y-3",
				"Fendi", "Prada", "Reebok", "Filling Pieces", ];
		
		var itemTags= [
			<%
				ArrayList<String> itemTags= connection.getTags();
				for (String tag: itemTags) {
					out.print("'"+ tag+"', ");
				}
			%>
		];

		autocomplete(document.getElementById("itemType"), itemType);
		autocomplete(document.getElementById("insertTag"), itemTags);
	</script>
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
		
	</script>
</body>
</html>
