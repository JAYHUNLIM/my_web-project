<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
<!-- 본문 시작 -->
<h3>글 수정하기</h3>
<p>
<a href="bbsForm.jsp">글쓰기</a>
&nbsp;&nbsp;
<a href="bbsList.jsp">글목록</a>
</p>
<%
int bbsno=Integer.parseInt(request.getParameter("bbsno"));

dto = dao.read(bbsno);

if(dto==null){
	out.println("해당 글 없음");
}else{	
	
%>
<form action="bbsUpdateProc.jsp" method="post" name="bbsUpdatefrm" id="bbsUpdatefrm" onsubmit="return bbsCheck()">
<!-- <input type="hidden" name="sno" value="<%=bbsno%>"> -->
<input type="hidden" name="bbsno" value="<%=bbsno%>">
<table class="table">
<tr>
   <th class="success">작성자</th>
   <td><input type="text" name="wname" id="wname" class="form-control" maxlength="20" value="<%=dto.getWname()%>" required>
   </td>
</tr>
<tr>
   <th class="success">제목</th>
   <td><input type="text" name="subject" id="subject" class="form-control" maxlength="100" value="<%=dto.getSubject()%>" required>
   </td>
</tr>

<tr>
   <th class="success">내용</th>
   <td><textarea rows="5"  class="form-control" name="content" id="content"><%=dto.getContent()%></textarea></td>
</tr>

<tr>
   <th class="success">비밀번호</th>
   <td><input type="password" name="passwd" id="passwd" class="form-control" maxlength="20" required></td>
</tr>

<tr>
<td colspan="2">
<input type="submit" value="수정" class="btn btn-primary" >
<input type="reset" value="취소" class="btn btn-secondary" >
</td>
</tr>
</table>
</form>

<%
}
%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
