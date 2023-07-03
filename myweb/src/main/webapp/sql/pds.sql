--포토갤러리

--테이블 생성
CREATE TABLE tb_pds (
   pdsno      NUMBER         NOT NULL
  ,wname      VARCHAR2(100)  NOT NULL
  ,subject    VARCHAR2(250)  NOT NULL
  ,regdate    DATE           NOT NULL
  ,passwd     VARCHAR2(15)   NOT NULL
  ,readcnt    NUMBER         DEFAULT 0
  ,filename   VARCHAR2(250)  NOT NULL   --파일명
  ,filesize   NUMBER         DEFAULT 0  --파일크기
  ,PRIMARY KEY(pdsno)
);
--시퀀스 생성
create sequence pds_seq;

--행추가
pdsno: 		시퀀스에서 일련번호 발생
wname,subject,passwd: 사용자한테서 입력받음.<form></form>
regdate:	오늘날짜 (sysdate)
filename, filesize :첨부파일 관련 정보

--
set linesize 1000;
col wname for a10;
col psdsno for a10;
col subject for a20;
col regdate for a20;
col passwd for a10;
col filename for a30;
col readcnt for a10;
col filesize for a50;

--행 삭제
--글번호와 비밀번호가 일치하면 행삭제 + /storage 폴더에 저장된 첨부파일 삭제
delete from tb_pds where pdsno=? and passwd=?
