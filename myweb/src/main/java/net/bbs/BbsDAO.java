package net.bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


import net.utility.DBClose;
import net.utility.DBOpen;

public class BbsDAO {
//	DB관련된 작업 SQL문 CRUD
	private DBOpen dbopen=null;
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	private StringBuilder sql=null;
	
	public BbsDAO() {
		dbopen= new DBOpen();
	}
	
	
	public int create(BbsDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" insert into tb_bbs(bbsno,wname,subject,content,passwd,ip,grpno) ");
			sql.append(" values(bbs_seq.nextval, ?, ?, ?, ?, ?, (select nvl(max(bbsno),0)+1 from tb_bbs)) ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getIp());
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("행추가 실패"+e);
		}finally {
			DBClose.close(con,pstmt);
		}
		return cnt;
	}
	
	public ArrayList<BbsDTO> list() {
		ArrayList<BbsDTO> list= null;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" select bbsno, wname, subject, readcnt, regdt, indent ");
			sql.append(" from tb_bbs ");
			sql.append(" order by grpno desc, ansnum asc ");
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				list=new ArrayList<>();
				do {	//커서가 가리키는 한줄씩 sungjukDto에 저장
					BbsDTO dto=new BbsDTO();
					dto.setBbsno(rs.getInt("bbsno"));;
					dto.setWname(rs.getString("wname"));
					dto.setSubject(rs.getString("subject"));
					dto.setReadcnt(rs.getInt("readcnt"));
					dto.setRegdt(rs.getString("regdt"));
					dto.setIndent(rs.getInt("indent"));
					list.add(dto);//list에 저장
					
				}while(rs.next());
			}else{
				list=null;
			}
			
			
			
		}catch (Exception e) {
			System.out.println("목록 가져오기 실패"+e);
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return list;
	}
	
	
	public int count() {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" select count(*) as cnt ");
			sql.append(" from tb_bbs ");
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				cnt=rs.getInt("cnt");
			}
		}catch (Exception e) {
			System.out.println("갯수 세기 실패"+e);
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return cnt;
	}
	
	
	public BbsDTO read(int bbsno) {
		BbsDTO dto=null;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" select bbsno, wname, subject, content, readcnt, regdt, ip, grpno, indent, ansnum ");
			sql.append(" from tb_bbs ");
			sql.append(" where bbsno=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			rs=pstmt.executeQuery();
			if(rs.next()){
				dto=new BbsDTO();
				dto.setBbsno(rs.getInt("bbsno"));;
				dto.setWname(rs.getString("wname"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setRegdt(rs.getString("regdt"));
				dto.setIp(rs.getString("ip"));
				dto.setGrpno(rs.getInt("grpno"));
				dto.setIndent(rs.getInt("indent"));
				dto.setAnsnum(rs.getInt("ansnum"));
		
			}
		}catch (Exception e) {
			System.out.println("상세보기 실패"+e);
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return dto;
	}
	
	
	public void increment(int bbsno) {
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" update tb_bbs ");
			sql.append(" set readcnt=readcnt+1 ");
			sql.append(" where bbsno=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, bbsno);
			
			rs=pstmt.executeQuery();
			
		}catch (Exception e) {
			System.out.println("조회수 증가 실패"+e);
		}finally {
			DBClose.close(con,pstmt);
		}
	}
	

	public int delete(BbsDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" delete from tb_bbs ");
			sql.append(" where bbsno=? and passwd=? ");
	
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getBbsno());
			pstmt.setString(2,dto.getPasswd() );
			
			cnt=pstmt.executeUpdate();
			
		}catch (Exception e) {
			System.out.println("삭제 실패"+e);
		}finally {
			DBClose.close(con,pstmt);
		}
		return cnt;
	}
	
	
	public int updatepro(BbsDTO dto) {
		int cnt=0;
		
			try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" update tb_bbs ");
			sql.append(" set wname=?,subject=?,content=?,ip=? ");
			sql.append(" where bbsno=? and passwd=? ");
			
			pstmt= con.prepareStatement(sql.toString());
			pstmt.setString(1,dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getIp());
			pstmt.setInt(5, dto.getBbsno());
			pstmt.setString(6, dto.getPasswd());
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			
			System.out.println("업데이트 실패"+e);
			
		}finally {
			DBClose.close(con,pstmt);
		}
		return cnt;
	}
	
	
	public int reply(BbsDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			//1. 부모글 정보 가져오기 select
			//부모글의 그룹번호 들여쓰기 글순서
			int grpno=0;
			int indent=0;
			int ansnum=0;
			sql.append(" select grpno,indent,ansnum ");
			sql.append(" from tb_bbs ");
			sql.append(" where bbsno=? ");
			pstmt= con.prepareStatement(sql.toString());
			pstmt.setInt(1, dto.getBbsno());
			rs=pstmt.executeQuery();
			if(rs.next()) {
			// 그룹번호, 들여쓰기: 부모글 +1, 글순서: 부모글 +1
			grpno=rs.getInt("grpno");
			indent=rs.getInt("indent")+1;
			ansnum=rs.getInt("ansnum")+1;
			}
					
			
			//2.글 순서 재조정하기 update
			// 1단계에서 사용했던 sql값 지우기
			// sql문을 새로 선언하고 작성해도 무관함
			sql.delete(0,sql.length());
			sql.append(" UPDATE  tb_bbs ");
			sql.append(" SET ansnum=ansnum+1 ");
			sql.append(" WHERE (ansnum>=?) and grpno=? ");
			pstmt= con.prepareStatement(sql.toString());
			pstmt.setInt(1,ansnum);
			pstmt.setInt(2,grpno);
			pstmt.executeQuery();
			
			//3. 답변글 추가하기 
			sql.delete(0,sql.length());
			sql.append(" insert into tb_bbs(bbsno,wname,subject,content,passwd,ip,grpno,indent,ansnum) ");
			sql.append(" values(bbs_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?) ");

			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setString(5, dto.getIp());	
			pstmt.setInt(6, grpno);
			pstmt.setInt(7,indent);
			pstmt.setInt(8, ansnum);
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("답변 실패"+e);
		}finally {
			DBClose.close(con,pstmt,rs);;
		}
		return cnt;
	}
	
	
	
	
	
	public int count2(String col, String word) {
		
			int cnt=0;
			try {
				con=dbopen.getConnection();
				
				sql=new StringBuilder();
				sql.append(" select count(*) as cnt ");
				sql.append(" from tb_bbs ");
			
				if(word.length()>=1) {
					String search="";
					if(col.equals("subject_content")) {
						search+= " where subject like '%" +word+"%' ";
						search+= " or content like '%" +word+"%' ";
					}else if(col.equals("subject")) {
						search+= " where subject like '%" +word+"%' ";
					}else if(col.equals("content")) {
						search+= " where content like '%" +word+"%' ";
					}else if(col.equals("wname")) {
						search+= " where wname like '%" +word+"%' ";
					}
					
					sql.append(search);
				}
				
				
				pstmt=con.prepareStatement(sql.toString());
				rs=pstmt.executeQuery();
				
				if(rs.next()){
					cnt=rs.getInt("cnt");
				}
			}catch (Exception e) {
				System.out.println("갯수 세기 실패"+e);
			}finally {
				DBClose.close(con,pstmt,rs);
			}
			return cnt;
		
		
	}
	
	
	
	
	public ArrayList<BbsDTO> list2(String col, String word) {
		ArrayList<BbsDTO> list= null;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" select bbsno, wname, subject, readcnt, regdt, indent ");
			sql.append(" from tb_bbs ");
			

			if(word.length()>=1) {
				String search="";
				if(col.equals("subject_content")) {
					search+= " where subject like '%" +word+"%' ";
					search+= " or content like '%" +word+"%' ";
				}else if(col.equals("subject")) {
					search+= " where subject like '%" +word+"%' ";
				}else if(col.equals("content")) {
					search+= " where content like '%" +word+"%' ";
				}else if(col.equals("wname")) {
					search+= " where wname like '%" +word+"%' ";
				}
				
				sql.append(search);
			}
			sql.append(" order by grpno Desc, ansnum asc ");
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				list=new ArrayList<>();
				do {	//커서가 가리키는 한줄씩 sungjukDto에 저장
					BbsDTO dto=new BbsDTO();
					dto.setBbsno(rs.getInt("bbsno"));;
					dto.setWname(rs.getString("wname"));
					dto.setSubject(rs.getString("subject"));
					dto.setReadcnt(rs.getInt("readcnt"));
					dto.setRegdt(rs.getString("regdt"));
					dto.setIndent(rs.getInt("indent"));
					list.add(dto);//list에 저장
					
				}while(rs.next());
			}else{
				list=null;
			}
			
		}catch (Exception e) {
			System.out.println("목록 가져오기 실패"+e);
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return list;
	}
	
	public ArrayList<BbsDTO> list3(String col, String word, int nowPage, int recordPerPage){
		ArrayList<BbsDTO> list=null;
		
        //페이지당 출력할 행의 갯수(10개를 기준)
        //1 페이지 : WHERE r>=1  AND r<=10;
        //2 페이지 : WHERE r>=11 AND r<=20;
        //3 페이지 : WHERE r>=21 AND r<=30;
        int startRow = ((nowPage-1) * recordPerPage) + 1 ;
        int endRow   = nowPage * recordPerPage;
		
		try {
            con=dbopen.getConnection();            
            sql=new StringBuilder();
            
            word=word.trim(); //검색어 좌우 공백 제거
            
            if(word.length()==0) { //검색어가 존재하지 않는 경우 -> bbs.sql의 페이징에서 6)번 내용으로 쿼리문 작성
            	
                sql.append(" SELECT * ");
                sql.append(" FROM ( ");
                sql.append("         SELECT bbsno,subject,wname,readcnt,indent,regdt, rownum as r ");
                sql.append("         FROM ( ");
                sql.append("                 SELECT bbsno,subject,wname,readcnt,indent,regdt ");
                sql.append("                 FROM tb_bbs ");
                sql.append("                 ORDER BY grpno DESC, ansnum ASC ");
                sql.append("              ) ");
                sql.append("      ) ");
                sql.append(" WHERE r>=" + startRow + " AND r<=" + endRow) ;
                
            }else { //검색어가 존재하는 경우 -> bbs.sql의 페이징에서 7)번 내용으로 쿼리문 작성
                sql.append(" SELECT * ");
                sql.append(" FROM ( ");
                sql.append("         SELECT bbsno,subject,wname,readcnt,indent,regdt, rownum as r ");
                sql.append("         FROM ( ");
                sql.append("                 SELECT bbsno,subject,wname,readcnt,indent,regdt ");
                sql.append("                 FROM tb_bbs ");
                
                String search="";
                if(col.equals("subject_content")) {
                    search += " WHERE subject LIKE '%" + word + "%' ";
                    search += " OR    content LIKE '%" + word + "%' ";
                }else if(col.equals("subject")) {
                    search += " WHERE subject LIKE '%" + word + "%' ";
                }else if(col.equals("content")) {
                    search += " WHERE content LIKE '%" + word + "%' ";
                }else if(col.equals("wname")) {
                    search += " WHERE wname LIKE '%" + word + "%' ";
                }//if end 
                sql.append(search);
                
                sql.append("                 ORDER BY grpno DESC, ansnum ASC ");
                sql.append("              ) ");
                sql.append("      ) ");
                sql.append(" WHERE r>=" + startRow + " AND r<=" + endRow) ;
            }//if end
            
            
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			if(rs.next()) {
				list=new ArrayList<>();
				do {
					BbsDTO dto=new BbsDTO(); //한줄담기
					dto.setBbsno(rs.getInt("bbsno"));
                    dto.setWname(rs.getString("wname"));
                    dto.setSubject(rs.getString("subject"));
                    dto.setReadcnt(rs.getInt("readcnt"));
                    dto.setRegdt(rs.getString("regdt"));
                    dto.setIndent(rs.getInt("indent"));
                    list.add(dto);//list에 모으기
				}while(rs.next());
			}//if end
            
            
        }catch (Exception e) {
            System.out.println("목록 페이징 실패:"+e);
        }finally {
            DBClose.close(con, pstmt, rs);
        }//end
        return list;
	}//list3() end
		
}