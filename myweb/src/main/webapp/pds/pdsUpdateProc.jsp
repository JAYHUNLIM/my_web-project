<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ include file="ssi.jsp" %>    
<%@ include file="../header.jsp" %>    
    
<!-- 본문시작 bbsUpdateProc.jsp -->
<!-- 수정 요청한 정보을 가져와서, DB에 가서 행 수정하기 -->

<%
try{
	
	//1.첨부된 파일 저장하기
		String saveDirectory=application.getRealPath("/storage");
		int maxPostSize=1024*1024*30;
		String encoding="UTF-8";
		MultipartRequest mr=new MultipartRequest(request,saveDirectory,maxPostSize,encoding,new DefaultFileRenamePolicy()); 

		String fileName="";	
		long fileSize=0;	
		File file=null;	
		String item="";	

		Enumeration files=mr.getFileNames(); //mr이 가진 파일 전부 긁어오기

		while(files.hasMoreElements()){	//여러개의 파일을 첨부하는 경우 한개씩 처리
			item=(String)files.nextElement();	
			fileName=mr.getFilesystemName(item);
			
		if(fileName!=null){ //실제 파일 가져왔다면
			file=mr.getFile(item);	
			if(file.exists()){		
				fileSize=file.length();
			}
			}
		}
	
	//수정 요청한 정보 가져오기
	int pdsno=Integer.parseInt(mr.getParameter("pdsno"));
	String wname=mr.getParameter("wname").trim();
	String subject=mr.getParameter("subject").trim();
	String passwd=mr.getParameter("passwd").trim();

	//dto에 담기
	dto.setPdsno(pdsno);
	dto.setWname(wname);
	dto.setPasswd(passwd);
	dto.setSubject(subject);
	dto.setFilename(fileName);
	dto.setFilesize(fileSize);

	int cnt=dao.updatepro(dto, saveDirectory);    
    if(cnt==0){
        out.println("<p>비밀번호가 일치하지 않습니다</p>");
        out.println("<p><a href='javascript:history.back()'>[다시시도]</a></p>");
    }else{
        out.println("<script>");
        out.println("    alert('게시글이 수정되었습니다');");
        out.println("    location.href='pdsList.jsp';");//목록페이지 이동
        out.println("</script>");
    }//if end	
    
}catch(Exception e){
	out.print(e);
	out.println("<p>게시글 수정 실패</p>");
	out.println("<p><a href='javascript:history.back()'>재시도</a></p>");
		
}    
%>
<!-- 본문 끝 -->

<%@ include file="../footer.jsp" %>