<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import = "user.BbsDAO" %>
<%@page import = "java.io.PrintWriter"%>
<!-- jsp적기 -->
<%
request.setCharacterEncoding("UTF-8");
%>
<!-- 인코딩 -->

<jsp:useBean id="bbs" class="user.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle" />
<jsp:setProperty name="bbs" property="bbsContent" />
<!DOCTYPE html>
<html>
<head>
</head>
<body>
	<%
	// 세션 확인
	String userID=null;
	if(null != session.getAttribute("userID")){
		userID=(String)session.getAttribute("userID");
	}
	%>
	<%
	// 로그인 된 사람만 게시글 쓰기
	if(null == userID){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 하세요.')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}else{
		// 입력 안 한 부분 체크
		if(null == bbs.getBbsTitle()){
			// 제목 빈칸
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('제목이 비어있어요.')");
			script.println("history.back()");
			script.println("</script>");
		}else if(null == bbs.getBbsContent()){
			// 내용 빈칸
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('내용이 비어있어요.')");
			script.println("history.back()");
			script.println("</script>");
		}else{
			// 빈칸 없음
			BbsDAO bbsDAO = new BbsDAO();
			int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
			if(-1 == result){
				// DB error
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기 실패: getNext ERROR')");
				script.println("history.back()");
				script.println("</script>");
			}else if(-2 == result){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기 실패: write ERROR')");
				script.println("history.back()");
				script.println("</script>");
			}else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기 성공')");
				script.println("location.href='bbs.jsp'");
				script.println("</script>");
			}
		}
	}
	%>
</body>
</html>