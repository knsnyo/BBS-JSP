<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>
	<%
	session.invalidate();
	%>
	<script>
		alert('로그아웃 되었어요.');
		location.href = 'main.jsp';
	</script>
</body>
</html>