<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import = "user.BbsDAO" %>
<%@ page import = "user.Bbs" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width" , intial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>게시판</title>
</head>
<body>
	<%
	// 세션 확인
	String userID = null;
	if (null != (String) session.getAttribute("userID")) {
		userID = (String) session.getAttribute("userID");
	}
	
	// 페이지 처리
	int pageNumber = 1;
	
	// 외부에서 넘어온 파라미터 pageNumber가 있다면
	// 즉 데이터가 10개 이상이라면
	if(null != request.getParameter("pageNumber")){
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
	%>
	<!-- nav bar -->
	<nav class="navbar sticky-top navbar-expand-lg navbar-light bg-light">
		<!-- 가득 차게 -->
		<div class="container-fluid">
			<a class="navbar-brand" href="main.jsp">홈</a>
			<!-- 토글 -->
			<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse justify-content-between" id="navbarNavDropdown">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item"><a class="nav-link" href="search.jsp">매물 검색</a></li>
				</ul>
				<%
				if (null == userID) {
				%>
				<!-- 로그인 상태 X -->
				<ul class="navbar-nav">
					<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">사용자</a>
						<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuLink">
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
					<li class="nav-item dropdown"><a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false">안녕하세요</a>
						<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdownMenuLink">
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
	
	<!-- 밑에 화면 -->
	<div class=container>
		<table class="table">
			<thead class="table-dark">
				<tr>
					<th scope="col-1">#</th>
					<th scope="col-2">작성자</th>
					<th scope="col-2">작성일</th>
					<th scope="col-7">제목</th>
				</tr>
			</thead>
			<tbody>
			    <%
			    BbsDAO bbsDAO = new BbsDAO();
			    ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
			    for(int i = 0; i < list.size(); i++){
			    %>
				<tr scope="row">
					<td ><%= list.get(i).getBbsID() %></td>
					<td><a href="view.jsp?bbsID = <%= list.get(i).getBbsID() %>">
					<%= list.get(i).getBbsTitle() %></a></td>
					<td><%= list.get(i).getUserID() %></td>
					<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13)
					+ "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
				</tr>
				<%
			    }
				%>
			</tbody>
		</table>
		<!-- 페이징 처리 영역 -->
		<%
		if(1 != pageNumber){
		%>
		<a href="bbs.jsp?pageNumber=<%=pageNumber - 1%>"
		class = "btn btn-success"> 이전 </a>
		<%
		}if(bbsDAO.nextPage(pageNumber + 1)){
		%>
		<a href = "bbs.jsp?pageNumber=<%=pageNumber + 1 %>"
		class = "btn btn-success">다음</a>
		<%
		}
		%>
		
		<!-- 글쓰기 버튼 -->
		<div class="d-grid gap-2 d-md-flex justify-content-md-end">
			<a class="btn btn-primary" type="button" href="write.jsp">글쓰기</A>
		</div>
	</div>
</body>
</html>