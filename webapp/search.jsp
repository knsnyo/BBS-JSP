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
<title>검색</title>
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



	<!-- 검색 2 map 8, 매물 보여주는거 2 -->
	<div class="container-fluid">
		<div class="row">
			<div class="col-2" id="search">
				<!-- 검색창 -->
				<div class="input-group mb-3">
					<input type="text" class="form-control" placeholder="검색창"
						aria-label="Recipient's username" aria-describedby="button-addon2">
					<button class="btn btn-outline-primary" type="button"
						id="button-addon2">검색</button>
				</div>
				<!-- 조건 설정 -->
				<!-- 계약 조건 -->
				<div>
					<p>계약 조건</p>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio"
							name="inlineRadioOptions1" id="inlineRadio1" value="option1"
							checked> <label class="form-check-label"
							for="inlineRadio1">전체</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio"
							name="inlineRadioOptions1" id="inlineRadio2" value="option2">
						<label class="form-check-label" for="inlineRadio2">월세</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio"
							name="inlineRadioOptions1" id="inlineRadio3" value="option3">
						<label class="form-check-label" for="inlineRadio3">전세</label>
					</div>
				</div>
				<hr />
				<div>
					<p>집 종류</p>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio"
							name="inlineRadioOptions2" id="inlineRadio1" value="option1"
							checked> <label class="form-check-label"
							for="inlineRadio1">전체</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio"
							name="inlineRadioOptions2" id="inlineRadio2" value="option2">
						<label class="form-check-label" for="inlineRadio2">원룸</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio"
							name="inlineRadioOptions2" id="inlineRadio3" value="option3">
						<label class="form-check-label" for="inlineRadio3">투룸</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio"
							name="inlineRadioOptions2" id="inlineRadio4" value="option4">
						<label class="form-check-label" for="inlineRadio4">쓰리룸</label>
					</div>
					<div class="form-check form-check-inline">
						<input class="form-check-input" type="radio"
							name="inlineRadioOptions2" id="inlineRadio5" value="option5">
						<label class="form-check-label" for="inlineRadio5">APT</label>
					</div>
				</div>
				<hr />
			</div>
			<!-- map -->
			<div class="col-8">
				<div id="map" style="width: 100%; height: 600px;">
					<!-- map api -->
					<script type="text/javascript"
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<APPKEY>"></script>
				</div>
			</div>
			<!-- 매물 보여주는거 -->
			<div class="col-2"></div>
		</div>
	</div>

	<!-- script -->
	<script src="js/jquery.min.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script>
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center : new kakao.maps.LatLng(33.450701,126.570667), //지도의 중심좌표.
			level : 3//지도의 레벨(확대, 축소 정도)
		};
		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		var markerPosition  = new kakao.maps.LatLng(33.450701, 126.570667); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});
		
		marker.setMap(map);
	</script>
</body>

</html>
