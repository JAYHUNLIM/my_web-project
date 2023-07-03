package net.pds;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import net.bbs.BbsDTO;
import net.utility.DBClose;
import net.utility.DBOpen;
import net.utility.Utility;

public class PdsDAO {
	private DBOpen dbopen=null;
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	private StringBuilder sql=null;
	
	public PdsDAO() {
		dbopen=new DBOpen();
	}
	
	public ArrayList<PdsDTO> list(){
		ArrayList<PdsDTO> list=null;
		
		try {
		con=dbopen.getConnection();
		sql=new StringBuilder();
		sql.append(" select pdsno,wname,subject,filename,readcnt,regdate ");	
		sql.append(" from tb_pds ");
		sql.append(" order by regdate desc ");
		
		pstmt=con.prepareStatement(sql.toString());
		rs=pstmt.executeQuery();
		
		if (rs.next()) {
			list= new ArrayList<PdsDTO>();
			do {
				PdsDTO dto=new PdsDTO();
				dto.setPdsno(rs.getInt("pdsno"));
				dto.setWname(rs.getString("wname"));
				dto.setSubject(rs.getString("subject"));
				dto.setFilename(rs.getString("filename"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setRegdate(rs.getString("regdate"));
				list.add(dto);
			}while(rs.next());
		}
		
		
		} catch (Exception e) {
			System.out.println("포토 갤러리 목록 실패"+e);
		}finally {
			DBClose.close(con, pstmt, rs);
		}
		return list;
	}
	
	
	public int create(PdsDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" insert into tb_pds(pdsno,wname,subject,passwd,filename,filesize,regdate) ");
			sql.append(" values(bbs_seq.nextval,?,?,?,?,?,sysdate) ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3, dto.getPasswd());
			pstmt.setString(4, dto.getFilename());
			pstmt.setLong(5, dto.getFilesize());
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("포토 갤러리추가 실패"+e);
		}finally {
			DBClose.close(con,pstmt);
		}
		return cnt;
	}
	
	
	public PdsDTO read(int pdsno) {
		PdsDTO dto=null;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" select pdsno, wname, subject,passwd,readcnt,regdate,filename,filesize  ");
			sql.append(" from tb_pds ");
			sql.append(" where pdsno=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			
			rs=pstmt.executeQuery();
			if(rs.next()){
				dto=new PdsDTO();
				dto.setPdsno(rs.getInt("pdsno"));
				dto.setWname(rs.getString("wname"));
				dto.setSubject(rs.getString("subject"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setReadcnt(rs.getInt("readcnt"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setFilename(rs.getString("filename"));
				dto.setFilesize(rs.getLong("filesize"));
				
			}
		}catch (Exception e) {
			System.out.println("상세보기 실패"+e);
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return dto;
	}
	
	public void incrementCnt(int pdsno) {
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" update tb_pds ");
			sql.append(" set readcnt=readcnt+1 ");
			sql.append(" where pdsno=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			
			rs=pstmt.executeQuery();
			
		}catch (Exception e) {
			System.out.println("조회수 증가 실패"+e);
		}finally {
			DBClose.close(con,pstmt);
		}
	}
	
	public int delete(int pdsno,String passwd,String saveDir) {
		int cnt=0;
		try {
			//테이블의 삭제하기 전에, 삭제하고자 하는 파일명을 가져와야 한다
			String filename="";
			PdsDTO oldDTO=read(pdsno);
			if(oldDTO !=null) {
				filename=oldDTO.getFilename();
			}
			
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" delete ");
			sql.append(" from tb_pds ");
			sql.append(" where pdsno=? and passwd=? ");			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, pdsno);
			pstmt.setString(2, passwd);
			
			cnt=pstmt.executeUpdate();
			
			if(cnt==1) {
				//테이블에서 행삭제 성공시 첨부한 파일도 같이 삭제
				//utility 클래스 이용
				Utility.deleteFile(saveDir, filename);				
			}
			
			
	}catch (Exception e) {
		System.out.println("삭제 실패"+e);
	}finally {
		DBClose.close(con,pstmt);
	}
		return cnt;
}
	
	public int updatepro(PdsDTO dto,String saveDirectory) {
		int cnt=0;
		
			try {
				String filename="";
				PdsDTO oldDTO=read(dto.getPdsno());
				if(oldDTO !=null) {
					filename=oldDTO.getFilename();
				}
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" update tb_pds ");
			sql.append(" set wname=?,subject=?,filename=?, filesize=? ");
			sql.append(" where pdsno=? and passwd=? ");
			
			pstmt= con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getWname());
			pstmt.setString(2, dto.getSubject());
			pstmt.setString(3,dto.getFilename());
			pstmt.setLong(4, dto.getFilesize());
			pstmt.setInt(5, dto.getPdsno());
			pstmt.setString(6, dto.getPasswd());
			
			cnt=pstmt.executeUpdate();
			
			if(cnt==1) {
				//테이블에서 업데이트 성공시 첨부한 이전파일도 같이 삭제
				//utility 클래스 이용
				Utility.deleteFile(saveDirectory, filename);				
			}
			
		} catch (Exception e) {
			
			System.out.println("업데이트 실패"+e);
			
		}finally {
			DBClose.close(con,pstmt);
		}
		return cnt;
	}
	
	
	
}
