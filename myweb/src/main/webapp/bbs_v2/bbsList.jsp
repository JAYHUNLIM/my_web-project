<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<h3>글목록</h3>
<p><a href="bbsForm.jsp">글쓰러 가기</a></p>

<table class="table table-hover" border="1">
<thead>
<tr class="info" >
<th>제목</th>
<th>조회수</th>
<th>작성자</th>
<th>등록일</th>
</tr>
</thead>
<tbody>
<%
ArrayList<BbsDTO> list = dao.list2(col,word);
if(list==null){
	out.println(" <tr>");
	out.println(" <td colspan='5'>" );
	out.println(" <strong> 작성 글없음 <strong>" );
	out.println(" </td>" );
	out.println(" <tr>");
}else{
	//오늘 날짜를 문자열로 2023-04-14
	String today=Utility.getDate();
	
	
	for(int i=0;i<list.size();i++){
	dto=list.get(i);
%>
<tr>
<td style="text-align:left">
<%
//답변 이미지 출력
for(int n=1;n<=dto.getIndent();n++){
	out.println("<img src='../images/reply.gif'>");
}

%>


<a href="bbsRead.jsp?bbsno=<%=dto.getBbsno()%>&col=<%=col%>&word=<%=word%>"><%=dto.getSubject()%></a>

<%
	//오늘 작성한 글 제목 뒤에 new 이미지 출력
	//작성일(regdt)에서 년월일	자르기
	String regdt=dto.getRegdt().substring(0,10);
	if(regdt.equals(today)){
		out.println("<img src='../images/new.gif'>");
	}
	
	//조회수 10이상 hot 이미지 출력
	if(dto.getReadcnt()>=10){
		out.println("<img src='../images/hot.gif'>");
	}
%>


</td>
<td><%=dto.getReadcnt() %></td>
<td><%=dto.getWname() %></td>
<td><%=dto.getRegdt().substring(0,10) %></td>

</tr>



<%
	}
	
	int totalRecord=dao.count2(col,word);
	out.println("<tr>");
	out.println("<td colspan='4' style='text-align:center;'>");
	out.println("	글갯수:<strong>" +totalRecord +"</strong>");
	out.println("</td>");
	out.println("</tr>");
%>	
	<tr>
	<td colspan="4" style='text-align: center; height: 50px'>
	<form action="bbsList.jsp" onsubmit="return searchCheck()">
		<select name="col">
		<option value="subject_content">제목+내용 
		<option value="subject">제목
		<option value="content">내용
		<option value="wname">작성자
		</select>
		<input type="text" name="word" id="word">
		<input type="submit" value="검색">
	</form>	
	</td>
	</tr>
	
	
<%	
}
%>
</tbody>
</table>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
