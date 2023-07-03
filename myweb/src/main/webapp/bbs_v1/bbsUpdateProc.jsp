<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<!-- 폼에서 모든 값을 받아오기 -->
<%
int bbsno=Integer.parseInt(request.getParameter("bbsno"));
String subject=request.getParameter("subject").trim();
String wname=request.getParameter("wname").trim();
String content=request.getParameter("content").trim();
String passwd=request.getParameter("passwd").trim();
String ip=request.getRemoteAddr();

	dto.setBbsno(bbsno);
	dto.setWname(wname);
	dto.setSubject(subject);
	dto.setContent(content);
	dto.setPasswd(passwd);
	dto.setIp(ip);
	
	
	int cnt=dao.updatepro(dto);
	
	if (cnt == 0) {
		out.println("<p>글수정 실패 비밀번호가 다릅니다</p>");
		out.println("<p><a href='javascript:history.back()'>재시도</a></p>");
	} else {
		out.println("<script>");
		out.println("    alert('글수정 성공');");
		out.println(" location.href='bbsList.jsp';"); //목록페이지 이동
		out.println("</script>");
	}

%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
