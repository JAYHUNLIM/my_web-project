<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<h3>포토 게시판 수정</h3>
<p><a href="pdsForm.jsp">사진 올리기</a>
&nbsp;&nbsp;
<a href="pdsList.jsp">사진 목록</a></p>

<%
int pdsno=Integer.parseInt(request.getParameter("pdsno"));

dto=dao.read(pdsno);

if(dto==null){
	out.println("해당 글 없음");
}else{	
	
	
%>
<form method="post" action="pdsUpdateProc.jsp" enctype="multipart/form-data" onsubmit="return pdsCheck()">
<input type="hidden" name="pdsno" value="<%=pdsno%>">

<table class="table">
	
<tr>
<th>이름</th>
<td>
<input type="text" name="wname" id="wname" class="form-control" maxlength="20" value="<%=dto.getWname()%>" required>
</td>
</tr>

<tr>
<th>제목</th>
<td style="text-align: left">
<textarea rows="5" cols="30" name="subject" id="subject"><%=dto.getSubject() %></textarea>
    </td>
</tr>
	
<tr>
<th>사진</th>
<td>
<img src='../storage/<%=dto.getFilename()%>' width="80px"><br>
<%=dto.getFilename()%><br>
<input type="file" name="filename" id="filename">
</td>
</tr>

<tr>
<th>비밀번호</th>
<td>
<input type="password" name="passwd" id="passwd" class="form-control" maxlength="15" required>
</td>
</tr>

<tr>
<td colspan="2">
<input type="submit" value="수정하기" class="btn btn-primary">
<input type="reset" value="취소" class="btn btn-secondary">
</td>
</tr>	
</table>
</form>
<% 
}
%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
