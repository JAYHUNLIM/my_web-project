--로그인 페이지 만들기
--멤버테이블

--회원등급으로 운영
A1: 관리자
B1: 중간 관리자
C1: 우수 사용자
D1: 일반 사용자 (기본)
E1: 비회원
F1: 탈퇴한 회원

--회원테이블
CREATE TABLE member (
    id       VARCHAR(10)  NOT NULL, -- 아이디, 중복 안됨.
    passwd   VARCHAR(10)  NOT NULL, -- 패스워드
    mname    VARCHAR(20)  NOT NULL, -- 성명
    tel      VARCHAR(14)  NULL,     -- 전화번호
    email    VARCHAR(50)  NOT NULL  UNIQUE, -- 전자우편 주소, 중복 안됨
zipcode  VARCHAR(7)   NULL,     -- 우편번호, 12345
    address1 VARCHAR(255) NULL,     -- 주소 1
    address2 VARCHAR(255) NULL,     -- 주소 2(나머지주소)
    job      VARCHAR(20)  NOT NULL, -- 직업
    mlevel   CHAR(2)      NOT NULL, -- 회원 등급, A1, B1, C1, D1, E1, F1
    mdate    DATE         NOT NULL, -- 가입일    
    PRIMARY KEY (id)
);
COMMIT;

drop TABLE member;
--행 삽입
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate)
values('webmaster', '12341234', '웹마스터', '123-4567', 'webmaster@itwill.com'
     , '12345', '서울시 강남구 역삼동', '삼원타워4층', 'A02', 'A1', sysdate );
     
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate)
values('itwill', '12341234', '웹마스터', '123-4567', 'itwill@itwill.com'
     , '12345', '서울시 강남구 역삼동', '삼원타워4층', 'A02', 'D1', sysdate );  
     
insert into member(id, passwd, mname, tel, email, zipcode, address1, address2, job, mlevel, mdate)
values('korea', '12341234', '웹마스터', '123-4567', 'user1@soldesk.com'
     , '12345', '서울시 종로구 관철동', '코아빌딩8층', 'A02', 'F1', sysdate );     
     
---
set linesize 1000;
col	id for a10;
col mname for a10;
col passwd for a20;
col tel for a30;
col email for a20;
col address1 for a20;
col address2 for a20;
col mdate for a30;
col job for a10;
col mlevel for a10;
col zipcode for a10;


--로그인
--아이디/비번이 일치하면 회원등급 가져오기
--비회원 탈퇴는 제외
select mlevel
from member
where id='webmaster' and passwd='12341234' and mlevel in('A1','B1','C1','D1');
    
 
select mlevel
from member
where id='korea' and passwd='12341234' and mlevel in('A1','B1','C1','D1');
    
--아이디 중복 확인
select count(id)
from member
where id=?;

---회원가입
insert into member(id,passwd,mname,tel,email,zipcode,address1,address2,job,mlevel,mdate)
values(? , ?, ?, ? , ?, ?, ?, ?,'D1',sysdate);

--아이디 비번찾기 연습용 데이터 행 추가
--확인 가능한 이메일 주소 정확히
insert into member(id, passwd, mname, tel, email,zipcode, address1,address2,job,mlevel,mdate)
values('kimkim','12341234','김연아','123-4567','jqrkp7077@naver.com','12345','서울시 종로구 인사동','역삼빌딩8층','A02','D1',sysdate);

----------
select id 
from member
where mname=? and email=?;
 --임시비밀번호 대소문자 +숫자 10자리 이메일로 전송
 

--임시 비밀번호를 발급해서 테이블에서 수정하기
update member
set passwd=?
where mname=? and email=?