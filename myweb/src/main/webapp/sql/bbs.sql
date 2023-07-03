--bbs.sql
--답변형 및 댓글형 게시판


--테이블 삭제
drop table tb_bbs;

--테이블 생성 

create table tb_bbs(
  bbsno    number(5)       not null -- 일련번호 -99999~99999
 ,wname    varchar2(20)    not null -- 작성자
 ,subject  varchar2(100)   not null -- 글제목
 ,content  varchar2(2000)  not null -- 글내용
 ,passwd   varchar2(10)    not null -- 글비밀번호
,readcnt  number(5)       default 0 not null -- 글조회수
 ,regdt    date            default  sysdate   -- 글작성일
 ,grpno    number(5)       not null  -- 글 그룹번호
 ,indent   number(5)       default 0 -- 들여쓰기
 ,ansnum   number(5)       default 0 -- 글순서
 ,ip       varchar2(15)    not null  -- 사용자 요청 PC의 IP
 ,primary key(bbsno)                 --bbsno 기본키 
);

----cmd 창 간소화

set linesize 1000;
col bbsno for a10;
col wname for a10;
col passwd for a10;
col subjct for a10;
col content for a10;




--일련번호는 시퀀스로 생성
create sequence bbs_seq;
--시퀀스 삭제
drop sequence bbs_seq;

--새글쓰기
wname, subject, content, passwd: 사용자가 입력
readcnt, regdt, indet, ansnum: default 값
ip: 요청 pc의 ip 저장
grpno:max(bbsno)+1 

--행추가
insert into tb_bbs(bbsno,wname,subject,content,passwd,ip,grpno)
values(bbs_seq.nextval, ?, ?, ?, ?, ?, select nvl(max(bbsno),0)+1 from tb_bbs);
--그룹번호 만들기
--null값 계산 불가능
select max(bbsno) from tb_bbs;
select max(bbsno)+1 from tb_bbs;

-- nvl 함수를 이용
select nvl(max(bbsno),0) from tb_bbs;
select nvl(max(bbsno),0)+1 from tb_bbs;

-------------------------------------------------
--목록 페이지 만들기
--그룹번호를 내림차순 최신글이 가장 위로 올라온다
select bbsno, wname, subject, readcnt, regdt, indent
from tb_bbs
order by grpno desc, ansnum asc;

--상세보기
select * from tb_bbs where bbsno=?

--조회수 증가
update tb_bbs
set readcnt=readcnt+1
where bbsno=?
--비밀번호는 입력받아서 처리
--삭제 버튼을 누르는 순간 비밀번호 입력 폼이 나와야한다
delete from tb_bbs
where bbsno=? and passwd=?


--행수정 
update tb_bbs set wname=?,subject=?,content=?ip=?
where bbsno=? and passwd=?

--답변쓰기 알고리즘

---쓰기 
새글 쓰기: 부모글
-답변 쓰기: 자식글 insert 


그룹번호 grpno	: 부모글 그룹번호와 동일
들여쓰기 indent	: 부모글 들여쓰기 +1
글순서 ansnum		: 부모글 글순서+1한 후, 글순서 재조정

번호   	 제목		그룹번호	 	들여쓰기	 		글순서
bbs_seq	 제주도		1			0(default)		0(default)
					1			1				1
bbs_seq	 서울시		2			0(default)		0(default)
		→마포구		2			1				1
		→→신촌		2			2				2
답변		→종로구		2			1(default)		3	1(default)
답변		→강남구		2			1(default)		4	2(default)
답변		→→역삼동		2			2(default)		5	3(default)
답변		→→→역삼~		2			3(default)		6	3(default)
			
--특정값을 공유해야 답변글로 보여줄수 있다.
bbs_seq	 부산시		3			0(default)		0(default)

--글순서 조정
UPDATE  tb_bbs
SET ansnum=ansnum+1
WHERE (ansnum>=2) and grpno=2;



UPDATE  tb_bbs
SET (indent=indent+1)
WHERE (grpno='');

과제 제목과 댓글(자식글)의 갯수를 조회하시오(indent)
~~~(3)
~~-~(5)
select count(*) as cnt
from tb_bbs
where indent > 0 ;

select AA.grpno,AA.cnt, TB.subject, TB.indent
from(select grpno, count(grpno)-1 as cnt
from tb_bbs
group by grpno)AA JOIN tb_bbs TB
ON AA.grpno=TB.grpno
where TB.indent=0;
order by AA.grpno desc,indent asc;

------------------
부모 자식글 갯수 구하기
1.
select subject, grpno, indent from tb_bbs order by grpno desc;

2.
select grpno, count(*)
from tb_bbs
group by grpno, indent asc;
3.
select BB.subject,BB.indent, AA.grpno, AA.reply
from(select grpno, count(*)-1 as reply
from tb_bbs
group by grpno)AA join tb_bbs BB
ON AA.grpno=BB.grpno
where BB.indent=0
order by BB.grpno desc, BB.indent asc;
------------
select subject, grpno, indent 
from tb_bbs 
order by grpno desc, indent asc;
-----------------------------------------
select grpno, count(*)     
from tb_bbs
group by grpno
order by grpno desc;
----------------------------------------
select grpno, count(*)-1     
from tb_bbs
group by grpno
order by grpno desc;
------------------------------------------
select BB.subject, BB.indent, AA.grpno, AA.reply
from(     
        select grpno, count(*)-1 as reply     
        from tb_bbs
        group by grpno
     ) AA join tb_bbs BB
on AA.grpno=BB.grpno
order by BB.grpno desc, BB.indent asc;
-----------------------------------------------
select BB.subject, BB.indent, AA.grpno, AA.reply
from(     
        select grpno, count(*)-1 as reply     
        from tb_bbs
        group by grpno
     ) AA join tb_bbs BB
on AA.grpno=BB.grpno
where BB.indent=0
order by BB.grpno desc, BB.indent asc;

select bbsno, wname, concat(subject, '(' ||AA.reply || ')') as subject,readcnt,regdt, AA.reply
from(     
        select grpno, count(*)-1 as reply     
        from tb_bbs
        group by grpno
     ) AA join tb_bbs BB
on AA.grpno=BB.grpno
where BB.indent=0
order by BB.grpno desc, BB.indent asc

////////////////////////////////////////////////////
[검색]
--제목+내용에서 '파스타'가 있는지 검색
select subject from tb_bbs where subject like '%파스타%' or like '%파스타%';
select subject from tb_bbs where subject like '%파스타%';
select content from tb_bbs where content like '%파스타%';
select wname from tb_bbs where wname like '%파스타%';

페이징

-rownum 줄번호 활용
select bbsno,wname, readcnt, indent, regdt
from tb_bbs
order by grpno desc, ansnum asc;

2.
select bbsno,wname, readcnt, indent, regdt,rownum
from tb_bbs
order by grpno desc, ansnum asc;

3. 셀프조인 후,rownum
select bbsno,wname, readcnt, indent, regdt,rownum
from(
select bbsno,wname, readcnt, indent, regdt
from tb_bbs
order by grpno desc, ansnum asc);

----글 5개를 기준으로 자름
4.
select bbsno,wname, readcnt, indent, regdt,rownum
from(
select bbsno,wname, readcnt, indent, regdt
from tb_bbs
order by grpno desc, ansnum asc)
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
	select bbsno,wname, readcnt, indent, regdt,rownum as r
	from(
		select bbsno,wname, readcnt, indent, regdt
		from tb_bbs
		order by grpno desc, ansnum asc))
where r>=6 and r<=10;

--페이징 + 검색7.
파스타가 있는 행을 검색해서 2페이지 조회하시오
select *
from(
	select bbsno,wname, readcnt, indent, regdt,rownum as r
	from(
		select bbsno,wname, readcnt, indent, regdt
		from tb_bbs
		where subject like '%파스타%'
		order by grpno desc, ansnum asc))
where r>=6 and r<=10;