<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 글번호와 비밀번호가 일치하면 삭제 -->
<h3>글 삭제</h3>
<p>
<a href="bbsList.jsp">글목록</a>
</p>
<%
int bbsno=Integer.parseInt(request.getParameter("bbsno"));
%>

<form method="post" action="bbsDelProc.jsp" onsubmit="return pwCheck()">
<input type="hidden" name="bbsno" value="<%=bbsno%>">
<table class="table">

<tr>
<th class="info">비밀번호</th>
<td><input type="password" name="passwd" id="passwd" required>
</td>
</tr>

<tr>
<td colspan="2">
<input type="submit" value="삭제" class="btn btn-danger" >
</td>
</tr>


</table>




</form>

<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>
