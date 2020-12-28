<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ERROR</title>
</head>
<body>
	<h1 style="color: red; text-align: center;">${name} need to be initialized </h1>
	<h2 style="text-align: center;" >Try again</h2>
	<jsp:include page="/WEB-INF/login/login.jsp"></jsp:include>
</body>
</html>