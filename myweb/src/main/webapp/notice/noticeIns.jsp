<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<%
//사용자가 입력한 정보를 가져오기
String subject=request.getParameter("subject").trim();
String content=request.getParameter("content").trim();

//dto객체에 담기
dto.setSubject(subject);
dto.setContent(content);

int cnt=dao.create(dto);

if(cnt==0){
	out.println("<p>글 목록 추가 실패</p>");
	out.println("<p><a href='javascript:history.back()'>재시도</a></p>");
}else{
	out.println("<script>");
	out.println("    alert(' 게시글 목록 추가 성공');");
	out.println(" location.href='noticeList.jsp';");	//목록페이지 이동
	out.println("</script>");
}
%>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>
