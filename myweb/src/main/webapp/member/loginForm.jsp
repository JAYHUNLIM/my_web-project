<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="authi.jsp" %>
<%@ include file="../header.jsp" %>


<!-- 본문 시작 -->
<h3>*로그인*</h3>
<%if(s_id.equals("guest")|| s_passwd.equals("guest") || s_mlevel.equals("E1")){ 
	//id저장 쿠키 확인
	Cookie[] cookies=request.getCookies();
	//배열이기 때문에 모든 쿠키값들을 가져온다
	
	String c_id="";
	if(cookies!=null){
		for(int i=0;i<cookies.length; i++){
			//모든 쿠키값을 검색
			Cookie cookie=cookies[i];
			if(cookie.getName().equals("c_id")==true){
				
				c_id=cookie.getValue();
			}
		}
		
	}
	
	//
		%>
<form name="loginfrm" id="loginfrm" method="post" action="loginProc.jsp" onsubmit="return loginCheck()">
<table class="table">
<tr class="success">
<td> <input type="text" name="id" id="id" value="<%=c_id%>" placeholder="아이디" maxlength="10" required>
</td>
<td rowspan="2"> <input type="image" src="../images/bt_login.gif"> </td>
</tr>

<tr class="success">
<td> <input type="password" name="passwd" id="passwd" placeholder="비밀번호" maxlength="10" required>				
</td>
</tr>

<tr>
<td colspan="2"> <label><input type="checkbox" name="c_id" value="save">id저장</label>
&nbsp;&nbsp;&nbsp;
<a href="agreement.jsp">회원가입</a>
&nbsp;&nbsp;&nbsp;
<a href="findId.jsp">아이디/비밀번호 찾기</a>



</td>
</tr>
</table>
</form>
<%
}else{
	//로그인 성공했다면
	out.println("<strong>"+s_id+"</strong> 님");
	out.println("<a href='logout.jsp'>[로그아웃]</a>");
	out.println("<br><br>");
	out.println("<a href='memberModify.jsp'>[회원정보 수정]</a>");

	out.println("<a href='memberWithdraw.jsp'>[회원 탈퇴]</a>");
	
}

%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
