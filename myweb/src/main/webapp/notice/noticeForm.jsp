<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<h3>글쓰기</h3>
<p><a href="noticeList.jsp">글목록</a></p>
<!-- 이벤트는 myscript.js에 함수 작성
액션을 실행하기전에 폼을 한번 찍고 간다 -->
<form name="bbsfrm" id="bbsfrm" method="post" action="noticeIns.jsp" onsubmit="return noticeCheck()">
<table class="table">

<tr>
   <th class="success">제목</th>
   <td><input type="text" name="subject" id="subject" class="form-control" maxlength="100" required></td>
</tr>
<tr>
   <th class="success">내용</th>
   <td><textarea rows="5"  class="form-control" name="content" id="content" required></textarea></td>
</tr>

<tr>
    <td colspan="2" align="center">
       <input type="submit" value="쓰기" class="btn btn-success">
       <input type="reset"  value="취소" class="btn btn-danger">
    </td>
</table>

</form>
<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>
