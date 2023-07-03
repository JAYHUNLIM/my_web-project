<%@page import="javax.mail.Transport"%>
<%@page import="java.util.Date"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@page import="net.utility.*"%>

<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<h3>메일 보내기</h3>
<%
try{
	//1.사용하고자 하는 메일 서버에서 인증 받은 계정과 비번 등록하기
	// MyAuthenticator 클래스 생성 
	
	
	//2. 메일 서버 지정하기
	String mailServer="mw-002.cafe24.com"; //cafe24 메일 서버
	Properties props= new Properties();
	props.put("mail.smtp.host",mailServer);
	props.put("mail.smtp.auth",true);
	
	//3. 메일 서버에서 인증받은 계정 +비번
	Authenticator myAuth= new MyAuthenticator(); //다형성
	
	
	//4. 2와 3이 유효한지 검증
	Session sess=Session.getInstance(props,myAuth);
	out.print("메일서버 인증 성공");

	
	//5.메일 보내기
	request.setCharacterEncoding("UTF-8");
	String to =request.getParameter("to").trim();
	String from =request.getParameter("from").trim();
	String subject=request.getParameter("subject").trim();
	String content=request.getParameter("content").trim();

	//엔터및 특수문자 변경
	content=Utility.convertChar(content);
	
	//테이블 출력하기
	content+="<hr>";
	content+="<table border='1'>";
	content+="<tr>";
	content+="<th>상품명</th>";
	content+="<th>상품가격</th>";
	content+="</tr>";
	content+="<tr>";
	content+="<td>운동화</td>";
	content+="<td><span style='color:red; font-weight:bold;'>15,000원</span></td>";
	content+="</tr>";
	content+="</table>";
	
	//이미지 출력하기
	content+="<hr>";
	content+="<img src='http://localhost:9090/myweb/images/devil.png'>";
	
	
	//받는사람 이메일 주소
	InternetAddress[] address={ new InternetAddress(to)};
	
	/* 
		수신인이 여러명인경우
		InternetAddress[] address={ new InternetAddress(to),
									new InternetAddress(to1),
									new InternetAddress(to2)
									};
	
	 */
	 //메일 관련 정보 작성
	Message msg=new MimeMessage(sess);
	 
	 //받는사람
	 msg.setRecipients(Message.RecipientType.TO, address);
	 
	 //참조	Message.RecipientType.CC
	 
	 //숨은 참조 Message.RecipientType.BCC
	 
	 //보낸 사람
	 msg.setFrom(new InternetAddress(from));
	 
	 //메일 제목
	 msg.setSubject(subject);
	 
	 //메일 내용
	 msg.setContent(content,"text/html; charset=UTF-8");
	 
	 //메일 보낸 날짜
	msg.setSentDate(new Date());
	 
	 //메일 전송
	 Transport.send(msg);
	
	 out.print(to+"님에게 메일 발송 완료!");
	
}catch(Exception e){
	out.println("<p>메일 전송 실패 + e + </p>");
	out.println("<p><a href='javascript:history.back();'>다시시도</a></p>");
}


%>


<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
