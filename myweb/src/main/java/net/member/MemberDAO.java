package net.member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import net.bbs.BbsDTO;
import net.notice.NoticeDTO;
import net.utility.DBClose;
import net.utility.DBOpen;
import net.utility.MyAuthenticator;

public class MemberDAO {

	private DBOpen dbopen=null;
	private Connection con=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	private StringBuilder sql=null;
	
	
	public MemberDAO() {
		dbopen=new DBOpen();
	}
	
	public String loginProc(MemberDTO dto) {
		String mlevel=null;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" select mlevel ");
			sql.append(" from member ");
			sql.append(" where id=? and passwd=? ");
			sql.append(" and mlevel in('A1','B1','C1','D1') ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			
			rs=pstmt.executeQuery();
			if (rs.next()) {
				mlevel=rs.getString("mlevel");
			}
			
		} catch (Exception e) {
			System.out.println("로그인 실패"+e);
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return mlevel;
	}
	
	public int duplecateId(String id) {
	    int cnt=0;
	    try {
	        con=dbopen.getConnection();
	        
	        sql=new StringBuilder();
	        sql.append(" select count(id) as cnt ");
	        sql.append(" from member ");
	        sql.append(" where id=? ");
	        
	        pstmt=con.prepareStatement(sql.toString());
	        pstmt.setString(1,id);
	        
	        rs=pstmt.executeQuery();
	        
	        if(rs.next()) {
	            cnt=rs.getInt("cnt");
	        }//if end
	        
	    }catch (Exception e) {
	        System.out.println("아이디 중복 확인:"+e);
	    }finally {
	        DBClose.close(con, pstmt, rs);
	    }//end
	    return cnt;
	}//count() end

	
	
	public int duplecateEmail(String email) {
	    int cnt=0;
	    try {
	        con=dbopen.getConnection();
	        
	        sql=new StringBuilder();
	        sql.append(" select count(email) as cnt ");
	        sql.append(" from member ");
	        sql.append(" where email=? ");
	        
	        pstmt=con.prepareStatement(sql.toString());
	        pstmt.setString(1,email);
	        
	        rs=pstmt.executeQuery();
	        
	        if(rs.next()) {
	            cnt=rs.getInt("cnt");
	        }//if end
	        
	    }catch (Exception e) {
	        System.out.println("이메일 중복 확인:"+e);
	    }finally {
	        DBClose.close(con, pstmt, rs);
	    }//end
	    return cnt;
	}//count() end
	
	
	public int create(MemberDTO dto) {
		int cnt=0;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" insert into member( ");
			sql.append(" id,passwd,mname,tel,email,zipcode, ");
			sql.append(" address1,address2,job,mlevel,mdate) ");
			sql.append(" values(?,?,?,?,?, ");
			sql.append(" ?,?,?,?,'D1',sysdate) ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getPasswd());
			pstmt.setString(3, dto.getMname());
			pstmt.setString(4, dto.getTel());
			pstmt.setString(5, dto.getEmail());
			pstmt.setString(6, dto.getZipcode());
			pstmt.setString(7, dto.getAddress1());
			pstmt.setString(8, dto.getAddress2());
			pstmt.setString(9, dto.getJob());
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("멤버 테이블 행추가 실패"+e);
		}finally {
			DBClose.close(con,pstmt);
		}
		return cnt;
	}
	
	
	
	
	
	
	
	
	
	public boolean findId(MemberDTO dto) {
		boolean flag= false;
		try {
con=dbopen.getConnection();
	        
	        sql=new StringBuilder();
	        sql.append(" select id  ");
	        sql.append(" from member ");
	        sql.append(" where mname=? and email=? ");
	        
	        pstmt=con.prepareStatement(sql.toString());
	        pstmt.setString(1,dto.getMname());
	        pstmt.setString(2,dto.getEmail());
	        
	        rs=pstmt.executeQuery();
	        
	        if(rs.next()) {
	        	String id=rs.getString("id");
	        	
	        	 char[] charSet = new char[] {
			                '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
			                'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J',
			                'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T',
			                'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd',
			                'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
			                'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
			        };

		            String str="";

		            // 문자 배열 길이의 값을 랜덤으로 10개를 뽑아 구문을 작성함
		            int idx = 0;
		            for (int i = 0; i < 10; i++) {
		                idx = (int) (charSet.length * Math.random());
		                str += charSet[idx];
		                
		            }
		            sql.delete(0,sql.length());
			        sql.append(" update member  ");
			        sql.append(" set passwd=? ");
			        sql.append(" where mname=? and email=? ");
			        
			        pstmt=con.prepareStatement(sql.toString());
			        pstmt.setString(1,str.toString());
			        pstmt.setString(2,dto.getMname());
			        pstmt.setString(3,dto.getEmail());
			        
			        int cnt=pstmt.executeUpdate();
			        if(cnt==1) {
				        String content=" 아이디와 임시 비밀번호를  보내드립니다 <br> ";
				        content +=" 추후 로그인하여 바꾸시길 바랍니다  <br>";  
				        content +="<br> 아이디:" + id;  
				        content+="<hr>";	  
				        content+="임시 발급된 비밀번호:"+str.toString();
				       
				        ///
				        String mailServer="mw-002.cafe24.com"; //cafe24 메일 서버
				    	Properties props= new Properties();
				    	props.put("mail.smtp.host",mailServer);
				    	props.put("mail.smtp.auth",true);
				    	
				    	//3. 메일 서버에서 인증받은 계정 +비번
				    	Authenticator myAuth= new MyAuthenticator(); //다형성
				    	
				    	//4. 2와 3이 유효한지 검증
				    	Session sess=Session.getInstance(props,myAuth);
				        
				    	
				    	//받는사람 이메일 주소
				    	InternetAddress[] address={ new InternetAddress(dto.getEmail())};
				    	
				    	Message msg=new MimeMessage(sess);
				    	msg.setRecipients(Message.RecipientType.TO, address);    
				    	 
				   	 //보낸 사람
				   	 msg.setFrom(new InternetAddress(dto.getEmail()));
				   	 
				   	 //메일 제목
				   	 msg.setSubject("요청하신 아이디와 비밀번호");
				   	 
				   	 //메일 내용
				   	 msg.setContent(content,"text/html; charset=UTF-8");
				   	 
				   	 //메일 보낸 날짜
				   	msg.setSentDate(new Date());
				   	 
				   	 //메일 전송
				   	 Transport.send(msg);
				   	 flag=true;
			        }     
	        }else {
	        flag=false;	
	        }
			
		} catch (Exception e) {
			System.out.println("이메일 발송 실패"+e);
		}finally {
			DBClose.close(con,pstmt);
		}
		return flag;
	
	}
	
	
	public boolean findid(MemberDTO dto) {
		boolean flag=false;
		try {
			con=dbopen.getConnection();
	        sql=new StringBuilder();
	        
	        sql.append(" select id  ");
	        sql.append(" from member ");
	        sql.append(" where mname=? and email=? ");
	        
	        pstmt=con.prepareStatement(sql.toString());
	        pstmt.setString(1,dto.getMname());
	        pstmt.setString(2,dto.getEmail());
	        
	        rs=pstmt.executeQuery();
			if(rs.next()) {
				String id=rs.getString("id");
				//임시 비밀번호
			String[] ch= {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9",
	                "A", "B", "C", "D", "E", "F", "G", "H", "I", "J",
	                "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T",
	                "U", "V", "W", "X", "Y", "Z", "a", "b", "c", "d",
	                "e", "f", "g", "h", "i", "j", "k", "l", "m", "n",
	                "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
					
			};
				//ch배열에서 랜덤하게 10글자 뽑아서 가져오기
			StringBuilder imsipw = new StringBuilder();
			for(int i=0;i<10;i++) {
				int num=(int)(Math.random()*ch.length);
				imsipw.append(ch[num]);
			}
			//2.	
			 sql=new StringBuilder();
			 sql.append(" update member  ");
		     sql.append(" set passwd=? ");
		     sql.append(" where mname=? and email=? ");
			
		     pstmt=con.prepareStatement(sql.toString());
		        pstmt.setString(1,imsipw.toString());
		        pstmt.setString(2,dto.getMname());
		        pstmt.setString(3,dto.getEmail());
		        
		     int cnt=pstmt.executeUpdate();
		     
		     if(cnt==1) {
		    	 //메일 전송
		    	 String content="임시 비번으로 로그인한 후, 회원 정보에서 수정";
		    	 content+="<hr>";
		    		content+="<table border='1'>";
		    		content+="<tr>";
		    		content+="<th>아이디</th>";
		    		content+="<td>"+ id+"</td>";
		    		content+="</tr>";
		    		content+="<tr>";
		    		content+="<th>운동화</th>";
		    		content+="<td><span style='color:red; font-weight:bold;'>"+imsipw.toString()+"</span></td>";
		    		content+="</tr>";
		    		content+="</table>";
		    		
		    		String mailServer="mw-002.cafe24.com"; //cafe24 메일 서버
		    		Properties props= new Properties();
		    		props.put("mail.smtp.host",mailServer);
		    		props.put("mail.smtp.auth",true);
		    		
		    		Authenticator myAuth= new MyAuthenticator(); //다형성
		    		Session sess=Session.getInstance(props,myAuth);
		    		
		    		InternetAddress[] address={ new InternetAddress(dto.getEmail())};
		    		Message msg=new MimeMessage(sess);
		    		msg.setRecipients(Message.RecipientType.TO, address);
		    		msg.setFrom(new InternetAddress("webmaseter@itwill.co.kr"));
		    		msg.setSubject("myweb 아이디 비번");
		    		msg.setContent(content,"text/html; charset=UTF-8");
		    		msg.setSentDate(new Date());
		    		Transport.send(msg);
		    		
		    		flag=true; //최종적으로 성공
		     }
			
			}else {
				flag=false;
			}
	        
	        
			
		}catch (Exception e) {
			System.out.println("아이디 찾기 실패"+e);
		}finally {
			DBClose.close(con,pstmt);
		}
		return flag;
	}
	
	////////////삭제
	
	public int withdraw(MemberDTO dto) {
		int cnt=0;
		
			try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" update member ");
			sql.append(" set mlevel='F1' ");
			sql.append(" where id=? and passwd=? ");
			
			pstmt= con.prepareStatement(sql.toString());
			pstmt.setString(1,dto.getId());
			pstmt.setString(2,dto.getPasswd());
			
			cnt=pstmt.executeUpdate();
			
		} catch (Exception e) {
			
			System.out.println("회원 삭제 실패"+e);
			
		}finally {
			DBClose.close(con,pstmt);
		}
		return cnt;
	}
	
	//// 값 가져오기 read
	
	public MemberDTO read(String id) {
		MemberDTO dto=null;
		try {
			con=dbopen.getConnection();
			
			sql=new StringBuilder();
			sql.append(" select id,mname,passwd,tel,email,zipcode,address1,address2,job");
			sql.append(" from member ");
			sql.append(" where id=? ");
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			if(rs.next()){
				dto=new MemberDTO();
				dto.setId(rs.getString("id"));
				dto.setMname(rs.getString("mname"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setTel(rs.getString("tel"));
				dto.setEmail(rs.getString("email"));
				dto.setZipcode(rs.getString("zipcode"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress2(rs.getString("address2"));
				dto.setJob(rs.getString("job"));
			}
		}catch (Exception e) {
			System.out.println("회원정보 읽어오기 실패"+e);
		}finally {
			DBClose.close(con,pstmt,rs);
		}
		return dto;
	}
	

	
	///update
		public int updatepro(MemberDTO dto) {
			int cnt=0;
				try {
				con=dbopen.getConnection();
				
				sql=new StringBuilder();
				sql.append(" update member ");
				sql.append(" 	set mname=?,passwd=?,tel=?,email=?, " );
				sql.append("  	zipcode=?,address1=?,address2=?,job=? ");
				sql.append(" where id=? ");
				
				pstmt= con.prepareStatement(sql.toString());
				pstmt.setString(1,dto.getMname());
				pstmt.setString(2, dto.getPasswd());
				pstmt.setString(3, dto.getTel());
				pstmt.setString(4, dto.getEmail());
				pstmt.setString(5, dto.getZipcode());
				pstmt.setString(6, dto.getAddress1());
				pstmt.setString(7, dto.getAddress2());
				pstmt.setString(8, dto.getJob());
				pstmt.setString(9, dto.getId());
				
		
				cnt=pstmt.executeUpdate();
				
			} catch (Exception e) {
				
				System.out.println("회원정보 수정 실패"+e);
				
			}finally {
				DBClose.close(con,pstmt);
			}
			return cnt;
		}
		
	
	
	
}//MemberDAO
