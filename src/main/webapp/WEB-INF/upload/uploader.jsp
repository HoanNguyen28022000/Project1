<%@page import="com.hoan.Connection.ConnectSQLServer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert Product</title>
</head>
<body>
	<center>
		<h1>Upload Product Here</h1>
		<form action="fileuploadservlet" method="post"
			enctype="multipart/form-data">
			Product Name:<input type="text" name="ProductName"> <br />
			Select File:<input type="file" name="file" /><br /> <input
				type="submit" value="upload" />
		</form>
		<%
			ConnectSQLServer connection = new ConnectSQLServer();

			/* String  filename= (String) request.getAttribute("filename"); */
			String filename = connection.getCurrImageName();
			String path= "/resources/images/"+filename;
			System.out.println("done =" + path);
			out.write("<div><p>hello<p></div>");

			/* if (filename!= null) {
				response.setIntHeader("Refresh", 5);
				response.setHeader("REFRESH", "0"); 
			} */
		%><br>
		<!-- <script type="text/javascript">
			window.onload = function() {
				if (!window.location.hash) {
					window.location = window.location + '#loaded';
					window.location.reload();
				}
			}
		</script> -->
		<p>
			path=<%=path%></p>
		<img alt="" src="<c:url value="<%=path%>"/>">
	</center>
</body>
</html>