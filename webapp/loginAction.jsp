<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO"%>
<%@ page import="java.io.PrintWriter"%>
<!-- javascript 작성시 쓰는 거 -->
<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="user" class="user.User" scope="page" />
<!-- html 아이디랑 동일 -->
<jsp:setProperty name="user" property="userID" />
<!-- html 비밀번호랑 동일 -->
<jsp:setProperty name="user" property="userPW" />
<!doctype html>
<html lang="en">
<head>
</head>
<body>
	<%
	// 세션 확인
	String userID=null;
	if(null != session.getAttribute("userID")){
		userID=(String)session.getAttribute("userID");
	}
	// 이미 로그인 했을 경우
	if(null != userID){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어있어요.')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
	
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getUserID(), user.getUserPW());

	if (1 == result) {
		// 로그인 성공
		// 세션 부여
		session.setAttribute("userID", user.getUserID());
		
		// 로그인
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	} else if (0 == result) {
		// 패스워드 오류
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀렸어요.')");
		script.println("history.back()");
		script.println("</script>");
	} else if (-1 == result) {
		// 없는 id
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디 입니다.')");
		script.println("history.back()");
		script.println("</script>");
	} else if (-2 == result) {
		// DB 오류
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('DB 연결 오류 입니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</body>

</html>