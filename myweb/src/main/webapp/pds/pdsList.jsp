<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<h3>포토 갤러리</h3>
<p><a href="pdsForm.jsp">[사진올리기]</a> </p>

<%
 ArrayList<PdsDTO> list=dao.list();
if(list==null){

	out.println("글 없음");
}else{
	
	%>
<table class="table table-hover" border="1">
<thead>
<tr class="info" >
<th>제목</th>
<th>사진</th>
<th>조회수</th>
<th>작성자</th>
<th>작성일</th>
</tr>
</thead>
<tbody>
<%
String today=Utility.getDate();
for(int i=0;i<list.size();i++){
dto=list.get(i);

%>
<tr>
<td><a href="pdsRead.jsp?pdsno=<%=dto.getPdsno()%>"><%=dto.getSubject()%>
<% 
String regdt=dto.getRegdate().substring(0,10);
	if(regdt.equals(today)){
		out.println("<img src='../images/new.gif'>");
	}
	
	//조회수 10이상 hot 이미지 출력
	if(dto.getReadcnt()>=10){
		out.println("<img src='../images/hot.gif'>");
	}
%>
</a></td>
<td><img src='../storage/<%=dto.getFilename()%>' width="80px"></td>
<td><%=dto.getReadcnt()%></td>
<td><%=dto.getWname()%></td>
<td><%=dto.getRegdate().substring(0,10)%></td>
</tr>



<%
}


%>

</tbody>	
</table>	
	
<%
out.println("글 갯수: "+list.size());
}
%>



<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
