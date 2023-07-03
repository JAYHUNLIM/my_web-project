<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="authi.jsp" %>
<%@ include file="../header.jsp" %>


<!-- 본문 시작 -->
<h3>*아이디 찾기*</h3>

<form name="loginfrm" id="loginfrm" method="post" action="findIdProc.jsp" onsubmit="return findCheck()">
<table class="table">
<tr class="success">
<td> <input type="text" name="mname" id="mname" placeholder="이름" maxlength="10" required>
</td>
</tr>
<tr class="success">
<td> <input type="email" name="email" id="email" placeholder="이메일" maxlength="50" required>				
</td>
</tr>

<tr>
<td colspan="2">
<input type="submit" value="아이디/비밀번호 찾기" class="btn btn-secondary">
<input type="reset" value="취소" class="btn btn-secondary">


</td>
</tr>
</table>
</form>

<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
