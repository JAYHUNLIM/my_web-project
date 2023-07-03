package net.notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


import net.utility.DBClose;
import net.utility.DBOpen;

public class NoticeDAO {
	private DBOpen dbopen=null;
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	private StringBuilder sql=null;

public NoticeDAO() {
	dbopen= new DBOpen();
}

public int create(NoticeDTO dto) {
	int cnt=0;
	try {
		con=dbopen.getConnection();
		
		sql=new StringBuilder();
		sql.append(" insert into tb_notice(noticeno,subject,content,regdt) ");
		sql.append(" values(noticeno_seq.nextval,?,?,now()) ");
		
		pstmt=con.prepareStatement(sql.toString());
		pstmt.setString(1, dto.getSubject());
		pstmt.setString(2, dto.getContent());
		
		cnt=pstmt.executeUpdate();
		
	} catch (Exception e) {
		System.out.println("행추가 실패"+e);
	}finally {
		DBClose.close(con,pstmt);
	}
	return cnt;
}

public ArrayList<NoticeDTO> nlist() {
	ArrayList<NoticeDTO> list= null;
	try {
		con=dbopen.getConnection();
		
		sql=new StringBuilder();
		sql.append(" select noticeno,subject,regdt ");
		sql.append(" from tb_notice ");
		sql.append(" order by noticeno desc ");
		
		pstmt=con.prepareStatement(sql.toString());
		rs=pstmt.executeQuery();
		
		if(rs.next()){
			list=new ArrayList<>();
			do {	//커서가 가리키는 한줄씩 sungjukDto에 저장
				NoticeDTO dto=new NoticeDTO();
				dto.setNoticeno(rs.getInt("noticeno"));;
				dto.setSubject(rs.getString("subject"));
				dto.setRegdt(rs.getString("regdt"));
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
/* list create------------------------------------  */
public int count() {
    int cnt=0;
    try {
        con=dbopen.getConnection();
        
        sql=new StringBuilder();
        sql.append(" SELECT COUNT(*) as cnt ");
        sql.append(" FROM tb_notice ");
        
        pstmt=con.prepareStatement(sql.toString());
        rs=pstmt.executeQuery();
        if(rs.next()) {
            cnt=rs.getInt("cnt");
        }//if end
        
    }catch (Exception e) {
        System.out.println("글갯수실패:"+e);
    }finally {
        DBClose.close(con, pstmt, rs);
    }//end
    return cnt;
}//count() end

//---------------------------
public NoticeDTO read(int noticeno) {
	NoticeDTO dto=null;
	try {
		con=dbopen.getConnection();
		
		sql=new StringBuilder();
		sql.append(" select noticeno,subject,content,regdt ");
		sql.append(" from tb_notice ");
		sql.append(" where noticeno=? ");
		
		pstmt=con.prepareStatement(sql.toString());
		pstmt.setInt(1, noticeno);
		
		rs=pstmt.executeQuery();
		if(rs.next()){
			dto=new NoticeDTO();
			dto.setNoticeno(rs.getInt("noticeno"));;
			dto.setSubject(rs.getString("subject"));
			dto.setContent(rs.getString("content"));
			dto.setRegdt(rs.getString("regdt"));
		}
	}catch (Exception e) {
		System.out.println("상세보기 실패"+e);
	}finally {
		DBClose.close(con,pstmt,rs);
	}
	return dto;
}


public int delete(NoticeDTO dto) {
	int cnt=0;
	try {
		con=dbopen.getConnection();
		
		sql=new StringBuilder();
		sql.append(" delete from tb_notice ");
		sql.append(" where noticeno=? ");

		
		pstmt=con.prepareStatement(sql.toString());
		pstmt.setInt(1, dto.getNoticeno());
		
		
		cnt=pstmt.executeUpdate();
		
	}catch (Exception e) {
		System.out.println("삭제 실패"+e);
	}finally {
		DBClose.close(con,pstmt);
	}
	return cnt;
}
//---------------------update
public int updatepro(NoticeDTO dto) {
	int cnt=0;
	
		try {
		con=dbopen.getConnection();
		
		sql=new StringBuilder();
		sql.append(" update tb_notice ");
		sql.append(" set subject=?,content=? ");
		sql.append(" where noticeno=?  ");
		
		pstmt= con.prepareStatement(sql.toString());
		pstmt.setString(1, dto.getSubject());
		pstmt.setString(2, dto.getContent());
		pstmt.setInt(3, dto.getNoticeno());
		
		
		cnt=pstmt.executeUpdate();
		
	} catch (Exception e) {
		
		System.out.println("업데이트 실패"+e);
		
	}finally {
		DBClose.close(con,pstmt);
	}
	return cnt;
}

//----------------------------------------------
public int count2(String col, String word) {
	
	int cnt=0;
	try {
		con=dbopen.getConnection();
		
		sql=new StringBuilder();
		sql.append(" select count(*) as cnt ");
		sql.append(" from tb_notice ");
	
		if(word.length()>=1) {
			String search="";
			if(col.equals("subject_content")) {
				search+= " where subject like '%" +word+"%' ";
				search+= " or content like '%" +word+"%' ";
			}else if(col.equals("subject")) {
				search+= " where subject like '%" +word+"%' ";
			}else if(col.equals("content")) {
				search+= " where content like '%" +word+"%' ";
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


public ArrayList<NoticeDTO> list3(String col, String word,int nowPage, int recordPerPage) {
	ArrayList<NoticeDTO> list= null;
	//페이지당 출력할 행의 갯수(10개를 기준)
    //1 페이지 : WHERE r>=1  AND r<=10;
    //2 페이지 : WHERE r>=11 AND r<=20;
    //3 페이지 : WHERE r>=21 AND r<=30;
	int startRow = ((nowPage-1) * recordPerPage) + 1 ;
    int endRow   = nowPage * recordPerPage;
	
	try {
		con=dbopen.getConnection();
		sql=new StringBuilder();
			
		word=word.trim();

		if(word.length()==0) {//검색어가 존재하지 않는 경우
			sql.append(" select * ");
			sql.append(" from( ");	
			sql.append("       select noticeno,subject,content,regdt,rownum as r ");	
			sql.append("       from( ");	
			sql.append("             select noticeno,subject,content,regdt,rownum ");	
			sql.append("             from tb_notice ");	
			sql.append("             order by noticeno asc)) ");	
			sql.append(" where r>=" + startRow +"and r<=" + endRow );	
			
		} else { //검색어가 존재하는 경우 
			sql.append(" select * ");
			sql.append(" from( ");	
			sql.append(" select noticeno,subject,content,regdt,rownum as r ");	
			sql.append(" from( ");	
			sql.append(" select noticeno,subject,content,regdt,rownum ");	
			sql.append(" from tb_notice ");	
		
			String search="";
			if(col.equals("subject_content")) {
				search+= " where subject like '%" +word+"%' ";
				search+= " or content like '%" +word+"%' ";
			}else if(col.equals("subject")) {
				search+= " where subject like '%" +word+"%' ";
			}else if(col.equals("content")) {
				search+= " where content like '%" +word+"%' ";
			}
			
			sql.append(search);
		
			sql.append("  order by noticeno asc)) ");	
			sql.append(" where r>=" + startRow +"and r<=" + endRow );	
		}//if end
			
			pstmt=con.prepareStatement(sql.toString());
			rs=pstmt.executeQuery();
			
			if(rs.next()){
				list=new ArrayList<>();
				do {	//커서가 가리키는 한줄씩 저장
					NoticeDTO dto=new NoticeDTO();
					dto.setNoticeno(rs.getInt("noticeno"));
					dto.setSubject(rs.getString("subject"));
					dto.setRegdt(rs.getString("regdt"));
					list.add(dto);//list에 저장
					
				}while(rs.next());
			}//if end
			
		
	}catch (Exception e) {
		System.out.println("목록 가져오기 실패"+e);
	}finally {
		DBClose.close(con,pstmt,rs);
	}
	return list;
}

}