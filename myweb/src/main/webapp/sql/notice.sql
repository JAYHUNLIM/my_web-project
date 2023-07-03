
● 공지사항 개발환경 구축


1) 테이블 생성

   create table tb_notice(
     noticeno   number  NOT NULL AUTO_INCREMENT PRIMARY KEY  -- 일련번호
    ,subject    varchar2(255)    not null  -- 제목
    ,content    varchar2(4000)   not null  -- 내용
    ,regdt      datetime    	 not null   -- 작성일
   );

2) 일련번호 시퀀스 생성

   create sequence noticeno_seq;


3) JSP 작업폴더 : notice 생성


4) Package명    : net.notice


5) 자바빈즈 파일명
   net.notice.NoticeDTO
   net.notice.NoticeDAO

 
   create table tb_notice(
     noticeno   number           not null  -- 일련번호
    ,subject    varchar2(255)    not null  -- 제목
    ,content    varchar2(4000)   not null  -- 내용
    ,regdt      date    default  sysdate   -- 작성일
    ,primary key(noticeno)                 -- noticeno 기본키
   );
   
   
   
   
2. JSP 파일

1) 공지사항 입력폼   : noticeForm.jsp  
   - 제목, 내용에 빈 문자열이 입력되지 않도록 자바스크립트 유효성 검사 추가

2) 공지사항 추가     : noticeIns.jsp

3) 공지사항 리스트   : noticeList.jsp
   -제목, 작성일 출력

4) 공지사항 상세보기 : noticeRead.jsp

5) 공지사항 삭제     : noticeDel.jsp

6) 공지사항 수정     : noticeUpdate.jsp

 set linesize 1000;
col subjct for a10;
col content for a10;
col noticeno for a10;
※ 게시판 소스 참고

페이징

-rownum 줄번호 활용
select noticeno,subject,content,regdt,rownum
from tb_notice
order by noticeno desc;

2.
select bbsno,wname,readcnt,regdt,rownum
from tb_bbs
order by grpno desc, ansnum asc;

3. 셀프조인 후,rownum
select noticeno,subject,content,regdt,rownum
from(
select noticeno,subject,content,regdt,rownum
from tb_notice
order by noticeno desc);

----글 5개를 기준으로 자름
4.
select noticeno,subject,content,regdt,rownum as r
from(
select noticeno,subject,content,regdt,rownum
from tb_notice
order by noticeno desc)
where rownum<=5;
-- 선택된 레코드가 없음5
select bbsno,wname, readcnt, indent, regdt,rownum
from(
select bbsno,wname, readcnt, indent, regdt
from tb_bbs
order by grpno desc, ansnum asc)
where rownum>=6 and rownum<=10;
--한	번 더 검색해서 join 6
select *
from(
	select noticeno,subject,content,regdt,rownum as r
from(
select noticeno,subject,content,regdt,rownum
from tb_notice
order by noticeno asc))
where r>=6 and r<=10;

--페이징 + 검색7.
파스타가 있는 행을 검색해서 2페이지 조회하시오
select *
from(
	select bbsno,wname, readcnt, indent, regdt,rownum as r
	from(
		select bbsno,wname, readcnt, indent, regdt
		from tb_bbs
		
		order by grpno desc, ansnum asc))
where r>=6 and r<=10;

select *
from(
	select noticeno,subject,content,regdt,rownum as r
	from(
	select noticeno,subject,content,regdt,rownum
	from tb_notice
	where subject like '%파스타%'
	order by noticeno asc
	)
)
	where r>=6 and r<=10;

