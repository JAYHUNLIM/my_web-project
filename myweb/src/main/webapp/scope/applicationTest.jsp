<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

/*

			[application 내장객체] 
			-servletContext application
			-사용자 모두가 공유하는 전역적 의미의 객체
			-서버에 대한 정보를 관리하는 객체
		
*/

//			bbs폴더의 실제 물리적인 경로
//	D:\202301\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp1\wtpwebapps\myweb\bbs
			out.print(application.getRealPath("/bbs"));
			out.print("<hr>");
			
//웹 경로 http://localhost:9090/myweb/bbs
			
	//톰캣 10 이상에서는 지원하지 않음
	//out.print(request.getRealPath("/bbs"));

//application 내부변수
application.setAttribute("uid", "itwill");
out.print(application.getAttribute("uid"));
out.print("<hr>");
//-------------------------------------------------------
//[application 내장객체]  -요청한 사용자에게 응답할때
//response.sendRedirect("") 페이지 이동

//요청한 사용자에게 응답메세지 전송 (ajax에서 많이 사용)
PrintWriter print =response.getWriter();
			
%>
</body>
</html>