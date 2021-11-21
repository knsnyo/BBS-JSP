<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="user.BbsDAO"%>
<%@page import="user.Bbs"%>
<%@page import="java.io.PrintWriter"%>
<!-- jsp 적기 -->
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<%
	// 세션 확인
	String userID = null;
	if (null != session.getAttribute("userID")) {
		userID = (String) session.getAttribute("userID");
	}
	%>
	<%
	// 로그인 된 사람만 게시글 쓰기
	if (null == userID) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}
	
	// 유효한 글인가요?
	int bbsID = 0;
	if (null != request.getParameter("bbsID")) {
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
	}
	if (0 == bbsID) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 글입니다.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	}

	// 자신의 글인지 확인 
	Bbs bbs = new BbsDAO().getBbs(bbsID);
	if (!userID.equals(bbs.getUserID())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글 삭제 권한이 없어요.')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
	} else {
		// 글 삭제
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.delete(bbsID);
		if (-1 == result) {
			// DB error
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글삭제 실패: DB ERROR')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글삭제 성공')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
	}
	%>
</body>
</html>