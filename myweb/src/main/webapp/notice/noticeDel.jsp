<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 글번호와 비밀번호가 일치하면 삭제 -->
<h3>글 삭제</h3>
<p>
<a href="noticeList.jsp">공지사항</a>
</p>
<p>삭제 하려면 아래의 버튼을 누르세요</p>
<%
int noticeno=Integer.parseInt(request.getParameter("noticeno"));

%>

<form method="post" action="noticeDelProc.jsp">
<input type="hidden" name="notice" value="<%=noticeno%>">
<table class="table">

<tr>
<td colspan="2">
<input type="submit" value="삭제" class="btn btn-danger" >
</td>
</tr>
</table>
</form>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>
