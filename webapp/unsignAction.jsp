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
	// 로그인 안 했을 경우
	if(null == userID){
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('회원이 아닌데 어떻게 들어오셨죠?')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}
	
	UserDAO userDAO = new UserDAO();
	int result = userDAO.unsign(userID);

	if (-1 == result) {
		// 실패
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('무슨 오류일까요?')");
		script.println("history.back()");
		script.println("</script>");

	}else{
		// 탈퇴 성공
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("alert('회원탈퇴 되었습니다')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	    
		// 세션 파괴
	    session.invalidate();
	}
	%>
</body>

</html>