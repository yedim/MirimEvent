<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	boolean isSignup=false;

	String id=request.getParameter("id");
	String pw=request.getParameter("pw");
	String name=request.getParameter("name");
	
	Connection conn=null;
	PreparedStatement pstmt=null;
	
	if(id!=null && pw!=null && name!=null)
	{
		
		try{
			String url = "jdbc:mysql://localhost:3306/eventDB?characterEncoding=UTF-8&serverTimezone=UTC";
			String db_id="root";
			String db_pass="1234";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(url, db_id,db_pass);
			
			String sql="insert into memberInfo values(?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,id);
			pstmt.setString(2,pw);
			pstmt.setString(3,name);
			pstmt.setInt(4, 0);
			pstmt.executeUpdate();
			
		}catch(Exception e){
			System.out.println("insert 실패");
		}finally{
			if(pstmt!=null)
				try{pstmt.close(); } catch(SQLException sqle){}
			if(conn!=null)
				try{pstmt.close(); } catch(SQLException sqle){}

		}
		isSignup=true;
	}
	
	if(isSignup==true)
	{%>
		<script>
		alert("가입성공");
		location.href="index.jsp";//이전페이지로
		</script>
		<%
	}
	else
	{%>
		<script>
		alert("가입 실패");
		history.go(-1);//이전페이지로
		</script>
	<%
		
	}
%>
</body>
</html>