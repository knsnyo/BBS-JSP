<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<!doctype html>
<html lang="en">

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width" , initial-scale="1">

<!-- Bootstrap CSS  -->
<link href="css/bootstrap.css" rel="stylesheet" />
<title>게시글 작성</title>
</head>

<body>
	<%
	// 세션 확인
	String userID = null;
	if (null != (String) session.getAttribute("userID")) {
		userID = (String) session.getAttribute("userID");
	}
	%>
	<!-- nav bar -->
	<nav class="navbar sticky-top navbar-expand-lg navbar-light bg-light">
		<!-- 가득 차게 -->
		<div class="container-fluid">
			<a class="navbar-brand" href="main.jsp">홈</a>
			<!-- 토글 -->
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown"
				aria-controls="navbarNavDropdown" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-between"
				id="navbarNavDropdown">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a class="nav-link" href="search.jsp">매물
							검색</a></li>
				</ul>
				<%
				if (null == userID) {
				%>
				<!-- 로그인 상태 X -->
				<ul class="navbar-nav">
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownMenuLink" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">사용자</a>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="navbarDropdownMenuLink">
							<li><a class="dropdown-item" href="signup.jsp">회원가입</a></li>
							<li><a class="dropdown-item" href="login.jsp">로그인</a></li>
						</ul></li>
				</ul>
				<%
				} else {
				%>
				<!-- 로그인 상태 O -->
				<ul class="navbar-nav">
					<li class="nav-item"><a class="nav-link" href="bbs.jsp">게시판</a></li>
					<li class="nav-item dropdown"><a
						class="nav-link dropdown-toggle" href="#"
						id="navbarDropdownMenuLink" role="button"
						data-bs-toggle="dropdown" aria-expanded="false">안녕하세요</a>
						<ul class="dropdown-menu dropdown-menu-end"
							aria-labelledby="navbarDropdownMenuLink">
							<li><a class="dropdown-item" href="mypage.jsp">마이페이지</a></li>
							<li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
						</ul></li>
				</ul>
				<%
				}
				%>
			</div>
		</div>
	</nav>

	<!-- 글 쓰는 곳 전체 -->
	<div class="container">
		<div class="row">
			<form method="POST" action="writeAction.jsp">
				<table class="table"
					style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2"
								style="background-color: #eeeeee; text-align: center;">게시판
								글쓰기 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control"
								placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용"
									name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>
						</tr>
					</tbody>
				</table>
				<div class="d-grid gap-2 d-md-flex justify-content-md-end">
					<input type="submit" class="btn btn-primary" value="글쓰기">
					<button class="btn btn-primary" onclick="history.back();">취소</button>
				</div>
			</form>
		</div>
	</div>

	<!-- script -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
</body>

</html>