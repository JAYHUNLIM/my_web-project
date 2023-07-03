<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>

<!-- 본문 시작 -->
<h3>사진 올리기 결과</h3>

<%

try{
	//1.첨부된 파일 저장하기
	String saveDirectory=application.getRealPath("/storage");
	int maxPostSize=1024*1024*30;
	String encoding="UTF-8";
	MultipartRequest mr=new MultipartRequest(request,saveDirectory,maxPostSize,encoding,new DefaultFileRenamePolicy()); 
	//파일크기는 알려주지 않음				    ( 요청방식,파일이있다면 저장,용량,	인코딩,기본적으로 제공해주는 파일 이름 사용)
	//smart editor ckeditor

	//2. 1단계에서 저장한 파일의 파일명, 파일크기 가져오기
	String fileName="";	//파일명
	long fileSize=0;	//파일크기
	//파일크기를 알려주는 클래스가 없으므로 새로 생성
	File file=null;	//실제파일
	String item="";	//name="filename"

	Enumeration files=mr.getFileNames(); //mr이 가진 파일 전부 긁어오기
	//파일을 하나씩 꺼내오기 반복문 사용
	while(files.hasMoreElements()){	//여러개의 파일을 첨부하는 경우 한개씩 처리
		item=(String)files.nextElement();	//name=filename
		fileName=mr.getFilesystemName(item);	//mr객체에서 item이 가지고 있는 실제 파일명
	if(fileName!=null){ //실제 파일 가져왔다면
		file=mr.getFile(item);	//파일 사이즈때문에 파일에 담는다
		if(file.exists()){			//파일 존재시
			fileSize=file.length();//파일 크기 가져오기
		}
		}
	}
	
	//3. tb_pds 테이블 저장하기
	String wname=mr.getParameter("wname").trim();
	String subject=mr.getParameter("subject").trim();
	String passwd=mr.getParameter("passwd").trim();
	
	dto.setWname(wname);
	dto.setSubject(subject);
	dto.setPasswd(passwd);
	dto.setFilename(fileName);
	dto.setFilesize(fileSize);
	
	int cnt=dao.create(dto);
	
	if(cnt==0){
		out.println("<p>사진 추가 실패</p>");
		out.println("<p><a href='javascript:history.back()'>재시도</a></p>");
	}else{
		out.println("<script>");
		out.println("    alert(' 사진 추가 성공');");
		out.println(" location.href='pdsList.jsp';");	//목록페이지 이동
		out.println("</script>");
	}
	
	
}catch(Exception e){
	out.print(e);
	out.println("<p>사진 추가 실패</p>");
	out.println("<p><a href='javascript:history.back()'>재시도</a></p>");
	
	
}


%>


<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>
