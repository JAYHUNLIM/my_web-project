<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<h3>게시판 상세보기</h3>
<p><a href="pdsForm.jsp">사진 올리기</a>
&nbsp;&nbsp;
<a href="pdsList.jsp">사진 목록</a></p>

<%
int pdsno=Integer.parseInt(request.getParameter("pdsno"));
dto=dao.read(pdsno);

if(dto==null){
	out.println("해당 글 없음");
}else{
	dao.incrementCnt(pdsno);
	
	
%>
<table class="table">
	
	<tr>
	<th class="danger">글제목</th>
	<td><%=dto.getSubject()%></td>
	</tr>
	
<tr><th class="danger">사진</th>
<td><img src='../storage/<%=dto.getFilename()%>' width="80px"></td>
</tr>

	<tr>
	<th class="danger">파일크기</th>
	<td><%=dto.getFilesize()%></td>
	</tr>

	<tr>
	<th class="danger">작성자</th>
	<td><%=dto.getWname()%></td>
	</tr>
	
	<tr>
	<th class="danger">작성일</th>
	<td><%=dto.getRegdate()%></td>
	</tr>
	
<tr>
	<th class="danger">조회수</th>
	<td><%=dto.getReadcnt()%></td>
	</tr>
	</table>
	<input type="button" value="수정" class="btn btn-primary"  onclick="location.href='pdsUpdate.jsp?pdsno=<%=pdsno%>'">
	<input type="button" value="삭제" class="btn btn-secondary"  onclick="location.href='pdsDel.jsp?pdsno=<%=pdsno%>'">
<% 
}
%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
