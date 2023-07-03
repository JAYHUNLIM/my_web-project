<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../member/authi.jsp" %> 
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
<!-- 본문 시작 -->
  
<h3>게시판 상세보기</h3>
<p>
<a href="bbsForm.jsp">글쓰기</a>
&nbsp;&nbsp;
<a href="bbsList.jsp?col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>">글목록</a>
</p>
<%
int bbsno=Integer.parseInt(request.getParameter("bbsno"));

dto=dao.read(bbsno);
if(dto==null){
	out.println("해당 글 없음");
}else{	
	//조회수 증가
dao.increment(bbsno);
%>

<table class="table">
	
	
	<tr>
	<th class="danger">작성자</th>
	<td><%=dto.getWname()%></td>
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
	<th class="danger">조회수</th>
	<td>
	<%=dto.getReadcnt() %></td>
	</tr>
	
	<tr>
	<th class="danger">작성일</th>
	<td><%=dto.getRegdt() %></td>
	</tr>
	
	<tr>
	<th class="danger">아이피 주소</th>
	<td><%=dto.getIp() %></td>
	</tr>
</table>
<br>
<input type="button" value="답변쓰기" class="btn btn-primary" onclick="location.href='bbsReply.jsp?bbsno=<%=bbsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>'">
<input type="button" value="수정" class="btn btn-warning"	onclick="location.href='bbsUpdate.jsp?bbsno=<%=bbsno%>&col=<%=col%>&word=<%=word%>&nowPage=<%=nowPage%>'">

<% if(s_mlevel.equals("A1")){%>
<input type="button" value="삭제" class="btn btn-secondary"  onclick="location.href='bbsDel.jsp?bbsno=<%=bbsno%>'">


<% 
}
}
%>
<!-- 본문 끝 -->
<%@ include file="../footer.jsp" %>
