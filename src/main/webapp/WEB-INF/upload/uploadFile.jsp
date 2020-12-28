<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>UPLOAD_FILE</title>
</head>
<body>
	<center>
		<h1>Upload File Form</h1>
		<form action="upload" method="post" enctype="multipart/form-data">
			Select File:<input type="file" name="file" /><br /> <input
				type="submit" value="upload" />
		</form>
	</center>
	
	
</body>
</html>