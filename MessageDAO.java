package com.webjjang.message.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.webjjang.message.vo.MessageVO;
import com.webjjang.util.PageObject;
import com.webjjang.util.db.DBInfo;
import com.webjjang.util.db.DBSQL;

public class MessageDAO {

	   Connection con = null;
	   PreparedStatement pstmt = null;
	   ResultSet rs = null;
	
	   
	   public List<MessageVO>list(PageObject pageObject) throws Exception{
	      List<MessageVO> list=null;
	      
	      try {
	         con = DBInfo.getConnection();
	         System.out.println(DBSQL.MESSAGE_LIST);
	         pstmt = con.prepareStatement(DBSQL.MESSAGE_LIST);
	         pstmt.setString(1, pageObject.getAccepter());
	         pstmt.setString(2, pageObject.getAccepter());
	         pstmt.setLong(3, pageObject.getStartRow());
	         pstmt.setLong(4, pageObject.getEndRow());
	         
	         rs=pstmt.executeQuery();
	         
	         if(rs!=null) {
	        	 while(rs.next()) {
	        		 if(list==null) list = new ArrayList<>();
	        		 MessageVO vo = new MessageVO();
	        		 vo.setNo(rs.getLong("no"));
	        		 vo.setSender(rs.getString("sender"));
	        		 vo.setSendDate(rs.getString("sendDate"));
	        		 vo.setAccepter(rs.getString("accepter"));
	        		 vo.setAcceptDate(rs.getString("acceptDate"));
	        		 
	        		 list.add(vo);
	        	 }
	         }
	         
	      } catch (Exception e) {
	         // TODO: handle exception
	         e.printStackTrace();
	         throw new Exception("메세지 목록 DB처리중 오류");
	      }finally {
	         DBInfo.close(con, pstmt, rs);
	      }
	      
	      
	      return list;
	}//end of list
	   
	   
	   public long getTotalRow() throws Exception{
		   long result = 0;
		   
		   try {
			   	con = DBInfo.getConnection();
		        pstmt = con.prepareStatement(DBSQL.MESSAGE_GET_TOTALROW);
		        rs = pstmt.executeQuery();
		        if(rs !=null && rs.next()) {
		        	result = rs.getLong(1);
		        }
			   
		} catch (Exception e) {
			// TODO: handle exception
			 e.printStackTrace();
	         throw new Exception("메세지 데이터 DB처리중 오류");
		}finally {
			DBInfo.close(con, pstmt, rs);
		}
		   
		   return result;
		   
	   }//end of getTotalRow
	   
	   public MessageVO view(long no) throws Exception {
		   MessageVO vo = null;
		   
		   try {
			   con=DBInfo.getConnection();
			   pstmt=con.prepareStatement(DBSQL.MESSAGE_VIEW);
			   pstmt.setLong(1, no);
			   rs=pstmt.executeQuery();
			   
			   if(rs != null && rs.next()) {
				   vo = new MessageVO();
				   vo.setNo(rs.getLong("no"));
				   vo.setSender(rs.getString("sender"));
				   vo.setSendDate(rs.getString("sendDate"));
				   vo.setContent(rs.getString("content"));
				   vo.setAccepter(rs.getString("accepter"));
				   vo.setAcceptDate(rs.getString("acceptDate"));
			   }
		} catch (Exception e) {
			// TODO: handle exception
			 e.printStackTrace();
	         throw new Exception("메세지 보기 DB처리중 오류");
		}finally {
			DBInfo.close(con, pstmt, rs);
		}
		return vo;
		   
	   }
	   
	   public int write(MessageVO vo) throws Exception {
		   int result=0;
		   
		   try {
			   con=DBInfo.getConnection();
			   System.out.println(DBSQL.MESSAGE_WRITE);
			   pstmt=con.prepareStatement(DBSQL.MESSAGE_WRITE);
			   pstmt.setString(1,vo.getSender());
			   pstmt.setString(2,vo.getContent());
			   pstmt.setString(3,vo.getAccepter());
			   result = pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
	         throw new Exception("메세지 데이터 DB처리중 오류");
		}finally {
			DBInfo.close(con, pstmt);
		}
		   
		   return result;
		   
	   }
}
