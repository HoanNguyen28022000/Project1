<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
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
</style>
</head>
<body class="sb-nav-fixed">
	<jsp:include page="/WEB-INF/admin/head.jsp"></jsp:include>
	<div id="layoutSidenav">
		<jsp:include page="/WEB-INF/admin/SlideMenu.jsp"></jsp:include>
		<div id="layoutSidenav_content">
			<main>
				<form class="container-fluid row" style="text-align: center;"
					action="EditActions" id="formInsert" name="formInsert"
					method="post" enctype="multipart/form-data">
					<div class="col-lg-6" style="padding-top: 50px;">
						<h2>Thêm sản phẩm</h2>
						<hr>
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span style="width: 150px;" class="input-group-text "> <i
									class="fa fa-user"></i>&nbsp;&nbsp;ID:
								</span>
							</div>
							<input name="itemID" id="itemID" class="form-control"
								autocomplete="off" oninput="checkItemID()"
								placeholder="ID sản phẩm" value="" type="text">
							<div id="invalidID" class="invalid-feedback"
								style="visibility: hidden;">ID sản phẩm đã trùng hoặc
								không hợp lệ</div>
						</div>
						<!-- form-group// -->
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span style="width: 150px;" class="input-group-text"> <i
									class="fa fa-envelope"></i>&nbsp;&nbsp;Tên:
								</span>
							</div>
							<input name="itemName" id="itemID" class="form-control"
								autocomplete="off" placeholder="Tên sản phẩm" value=""
								type="text">
						</div>
						<!-- form-group// -->
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span style="width: 150px;" class="input-group-text"> <i
									class="fa fa-address-book"></i>&nbsp;&nbsp;Loại giày:
								</span>
							</div>
							<input id="itemType" name="itemType" class="form-control"
								autocomplete="off" placeholder="Loại giày" value="" type="text">
						</div>
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span style="width: 150px;" class="input-group-text"> <i
									class="fa fa-address-book"></i>&nbsp;&nbsp;Màu:
								</span>
							</div>
							<input id="color" name="itemColor" class="form-control"
								placeholder="màu" value="" type="text">
						</div>
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span style="width: 150px;" class="input-group-text"> <i
									class="fa fa-address-book"></i>&nbsp;&nbsp;Ngày sản xuất:
								</span>
							</div>
							<input id="dateborn" name="dateOfMade" class="form-control"
								placeholder="dd-mm-yy" type="date">
						</div>
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span style="width: 150px;" class="input-group-text"> <i
									class="fa fa-address-book"></i>&nbsp;&nbsp;Nhà máy:
								</span>
							</div>
							<input id="company" name="productionCompany" class="form-control"
								placeholder="abc" value="" type="text">
						</div>
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span style="width: 150px;" class="input-group-text"> <i
									class="fa fa-address-book"></i>&nbsp;&nbsp;Made in:
								</span>
							</div>
							<input id="madein" name="madeIn" class="form-control"
								placeholder="abc" value="" type="text">
						</div>
						<div class="form-group input-group">
							<div class="input-group-prepend">
								<span style="width: 150px;" class="input-group-text"> <i
									class="fa fa-address-book"></i>&nbsp;&nbsp;Mô tả:
								</span>
							</div>
							<input id="detail" name="itemDetail" class="form-control"
								placeholder="Loại" value="" type="text">
						</div>
					</div>
					<div class="col-lg-6 "
						style="padding-top: 50px; text-align: center;">
						<h2>Upload Product Here</h2>
						<hr>
						<input type="file" name="file" id="file" /> <br> <img
							id="blah" src="#" width="70%" height="auto" />
						<hr>
						<input type="Submit" class="btn btn-success" style="width: 100%"
							onclick="insertItem()" value="Thêm">
						<hr>
						<input type="text" name="action" value="insert"
							style="visibility: hidden;">
					</div>

				</form>
			</main>
		</div>

	</div>
	<script>
		var allItemIDs = [];
	<%ItemsInfor itemInforModel = new ItemsInfor();
			ArrayList<String> allItemIDs = itemInforModel.getAllItemID("%");
			for (String itemID : allItemIDs) {
				out.print("allItemIDs.push('" + itemID + "');");
			}%>
		function checkItemID() {
			if (allItemIDs.includes(document.getElementById("itemID").value)
					|| document.getElementById("itemID").value == '') {
				document.getElementById("invalidID").style.visibility = "visible";
				document.getElementById("itemID").className = "form-control is-invalid";
			} else {
				document.getElementById("invalidID").style.visibility = "hidden";
				document.getElementById("itemID").className = "form-control is-valid";
			}
		}

		document.getElementById("dateborn").max = new Date().toISOString()
				.split("T")[0];

		var imgName = '';
		function formatNumber() {
			var price = document.getElementById("price").value;
			document.getElementById("price").value = price.toString().replace(
					/(\d)(?=(\d{3})+(?!\d))/g, '$1.');
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
				"Fendi", "Prada", "Reebok", "Filling Pieces" ];

		autocomplete(document.getElementById("itemType"), itemType);
	</script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.bundle.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
	<script
		src="<c:url value="/resources/admintemplate/assets/demo/chart-area-demo.js"/>"></script>
	<script
		src="<c:url value="/resources/admintemplate/assets/demo/chart-bar-demo.js"/>"></script>
	<script
		src="<c:url value="/resources/admintemplate/assets/demo/chart-pie-demo.js"/>"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
	<script
		src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js"></script>
	<script
		src="<c:url value="/resources/admintemplate/assets/demo/datatables-demo.js"/>"></script>
	<script>
		
	</script>
</body>
</html>
