<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<%
String id= (String)session.getAttribute("s_id");
String passwd=request.getParameter("passwd").trim();

dto.setId(id);
dto.setPasswd(passwd);

int cnt= dao.withdraw(dto);


if ( cnt== 0) {
	out.println("<p>비밀번호가 틀립니다</p>");
	out.println("<p><a href='javascript:history.back()'>재시도</a></p>");
} else {
	
	session.removeAttribute("s_id");		
	session.removeAttribute("s_pw");
	session.removeAttribute("s_mlevel");
	out.println("<script>");
	out.println("    alert('탈퇴 성공');");
	out.println(" location.href='loginForm.jsp';"); //목록페이지 이동
	out.println("</script>");
}
%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
