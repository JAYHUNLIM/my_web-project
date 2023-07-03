
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="authi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<h3> 회원탈퇴 </h3>

<p>
<a href="loginForm.jsp"></a>
</p>
<% 	
String id= (String)session.getAttribute("s_id");

%>

<form method="post" action="memberWithdrawProc.jsp" onsubmit="return pwCheck()">
<input type="hidden">
<table class="table">
<tr>
<th class="info">아이디</th>
<td><input type="text" name="id" id="id"  value="<%=id%>"required readonly>
</td>
</tr>

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
