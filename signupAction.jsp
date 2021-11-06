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
<!-- html 이메일이랑 동일 -->
<jsp:setProperty name="user" property="userEmail" />
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
	
	// 회원가입
	if(null == user.getUserID()){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디를 입력하여 주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}else if(null == user.getUserPW()){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호를 입력하여 주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}else if(null == user.getUserEmail()){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('Email을 입력하여 주세요.')");
		script.println("history.back()");
		script.println("</script>");
	}else{
		UserDAO userDAO = new UserDAO();
		int result = userDAO.signup(user);
		if(-1 == result){
			//회원가입 실패
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디예요.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			//회원가입 성공
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원가입에 성공했어요.')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>

</html>