<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../member/authi.jsp" %>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
<!-- 본문 시작 -->

<h3> 공지사항 상세보기</h3>
<p>
<a href="noticeForm.jsp">글쓰기</a>
&nbsp;&nbsp;
<a href="noticeList.jsp">글목록</a>
</p>
<%
int noticeno=Integer.parseInt(request.getParameter("noticeno"));

dto=dao.read(noticeno);
if(dto==null){
	out.println("해당 글 없음");
}else{	
	//조회수 증가

%>

<table class="table">
	
	
	<tr>
	<th class="danger">일련번호</th>
	<td><%=dto.getNoticeno()%></td>
	</tr>
	
	<tr>
	<th class="danger">제목</th>
	<td><%=dto.getSubject() %></td>
	</tr>
	
	<tr>
	<th class="danger">내용</th>
	<td>
<%		
	//특수문자 및 엔터를 br태그로 치환
	String content=Utility.convertChar(dto.getContent());
	out.print(content);
	%>
	</td>
	</tr>

	
	<tr>
	<th class="danger">작성일</th>
	<td><%=dto.getRegdt() %></td>
	</tr>
	
	
</table>
<br>
<% if(s_mlevel.equals("A1")){%>

<input type="button" value="수정" class="btn btn-warning"	onclick="location.href='noticeUpdate.jsp?noticeno=<%=noticeno%>'">
<input type="button" value="삭제" class="btn btn-secondary"  onclick="location.href='noticeDel.jsp?noticeno=<%=noticeno%>'">


<% 
}
}
%>
<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>
