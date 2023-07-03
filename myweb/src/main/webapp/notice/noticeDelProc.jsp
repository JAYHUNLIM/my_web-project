<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<%
int noticeno=Integer.parseInt(request.getParameter("noticeno"));

dto.setNoticeno(noticeno);

int cnt=dao.delete(dto);

if (cnt == 0) {
	out.println("<p>공지 지우기 실패</p>");
	out.println("<p><a href='javascript:history.back()'>재시도</a></p>");
} else {
	out.println("<script>");
	out.println("    alert('삭제 성공');");
	out.println(" location.href='noticeList.jsp';"); //목록페이지 이동
	out.println("</script>");
}
%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
