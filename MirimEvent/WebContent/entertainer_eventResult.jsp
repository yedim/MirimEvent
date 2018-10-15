<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<title>Insert title here</title>
</head>
<style>
body{
	background-color:#FFDDDD;
}

.title{
	font-size:2em;
	text-align:center;
	padding:5%;
}

.title span { 
	display:inline-block; 
	animation:float .5s ease-in-out infinite; 
}

@keyframes float {
  0%,100%{ transform:none; }
  33%{ transform:translateY(-1px) rotate(-2deg); }
  66%{ transform:translateY(1px) rotate(2deg); }
}

@keyframes bounce {
  0%,100%{ transform:translate(0); }
  25%{ transform:rotateX(20deg) translateY(2px) rotate(-3deg); }
  50%{ transform:translateY(-20px) rotate(3deg) scale(1.1);  }
}

span:nth-child(3n) { color:hsl(21, 100%, 69%); text-shadow:1px 1px hsl(25, 81%, 47%), 2px 2px hsl(25, 81%, 47%), 3px 3px hsl(25, 81%, 47%), 4px 4px hsl(22, 81%, 47%); animation-delay:.15s;}
span:nth-child(3n-1) { color:hsl(21, 100%, 69%); text-shadow:1px 1px hsl(25, 81%, 47%), 2px 2px hsl(25, 81%, 47%), 3px 3px hsl(25, 81%, 47%), 4px 4px hsl(22, 81%, 47%);  animation-delay:.25s;}
span:nth-child(3n-2) { color:hsl(21, 100%, 69%); text-shadow:1px 1px hsl(25, 81%, 47%), 2px 2px hsl(25, 81%, 47%), 3px 3px hsl(25, 81%, 47%), 4px 4px hsl(22, 81%, 47%);  animation-delay:.35s;}

.submitBtn
{
	background-color: white;
    color: black;
    border: 2px solid grey;
    width:80%;
    height:40px;
    border-radius: 8px;
	margin-top:20px;
}
.submitBtn:hover{background-color: #fd999a;}


.reachImg {
  animation: shake 1s;
  animation-iteration-count: infinite;
}

@keyframes shake {
  0% { transform: translate(1px, 1px) rotate(0deg); }
  10% { transform: translate(-1px, -2px) rotate(-1.5deg); }
  20% { transform: translate(-3px, 0px) rotate(1.5deg); }
  30% { transform: translate(3px, 2px) rotate(0deg); }
  40% { transform: translate(1px, -1px) rotate(1.5deg); }
  50% { transform: translate(-1px, 2px) rotate(-1.5deg); }
  60% { transform: translate(-3px, 1px) rotate(0deg); }
  70% { transform: translate(3px, 1px) rotate(-1.5deg); }
  80% { transform: translate(-1px, -1px) rotate(1.5deg); }
  90% { transform: translate(1px, 2px) rotate(0deg); }
  100% { transform: translate(1px, -2px) rotate(-1.5deg); }
}

</style>

<body>

<%
					String checkName=null;
					String checkId=null;
					
					checkName=(String)session.getAttribute("s_Name");
					checkId=(String)session.getAttribute("s_ID");
					
					
					if(checkId==null || checkId.equals(""))//이름없거나null이면
					{
						%>
						<div id="msg"></div>
						<center><input type='button' onclick='closeSelf()' value='종료' class="submitBtn"/></center>
						<script>
							
						function closeSelf(){
						    self.close();   //자기자신창을 닫습니다.
						}

						
						var string = "회원만 가능합니다. 로그인하세요!";
						var str = string.split("");
						var el = document.getElementById('msg');
						(function animate() {
						str.length > 0 ? el.innerHTML += str.shift() : clearTimeout(running);
						var running = setTimeout(animate, 150);
						})();
						</script>
						<%
					}
					else
					{
						Connection conn=null;
						PreparedStatement pstmt=null;
						ResultSet rs=null;
						
						String user_id="";
						String user_pw="";
						String user_name="";
						int user_heart=0;
						
						try{
							String url = "jdbc:mysql://localhost:3306/eventDB?characterEncoding=UTF-8&serverTimezone=UTC";
							String db_id="root";
							String db_pass="1234";
							
							Class.forName("com.mysql.jdbc.Driver");
							conn=DriverManager.getConnection(url, db_id,db_pass);
							
							
						}catch(Exception e){
							System.out.println("db연결 실패");
						}
						
						
						%>
						
						


<%
	request.setCharacterEncoding("UTF-8");
	String radio_entertainer=request.getParameter("radio_entertainer");
	String correctAnswer = request.getParameter("correctAnswer");
	if(radio_entertainer!=null && correctAnswer!=null)
	{
		if(radio_entertainer.equals(correctAnswer))
		{
		
			String sql="select * from memberInfo where name=? and id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,checkName);
			pstmt.setString(2,checkId);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				user_id = rs.getString("id");
				user_pw = rs.getString("pw");
				user_name = rs.getString("name");
				user_heart=rs.getInt("heart");
				
			}
			user_heart++;
			
			
			String sql_update="update memberInfo set heart=? where id=?";
			pstmt=conn.prepareStatement(sql_update);
			pstmt.setInt(1,user_heart);
			pstmt.setString(2,user_id);
			pstmt.executeUpdate();

			%>
			<div style="text-align:right">
			
			<%
				for(int i=0; i<user_heart;i++)
				{
					%>
					<img src="like.png" width="40px" height="40px" style="margin-top:10px;">
					<%
				}
			%>
			</div>
			
			<div class="title"><span>정</span><span>답</span><span>입</span><span>니</span><span>다</span></div>
			<%
			if(user_heart==5){
				%>
				 <div class="w3-container w3-center w3-animate-top" >
				  <h4>하트 5개 달성</h4>
					<img src="assets/img/coupon_1.png" width="70%" height="auto"  class="reachImg">				
				</div>
				<%
			}
			else if(user_heart==7){
				%>
				 <div class="w3-container w3-center w3-animate-top" >
				  <h4>하트 7개 달성</h4>
					<img src="assets/img/coupon_2.png" width="70%" height="auto"  class="reachImg">				
				</div>
				<%
			}
			else if(user_heart==10){
				%>
				 <div class="w3-container w3-center w3-animate-top" >
				  <h4>하트 10개 달성</h4>
					<img src="assets/img/coupon_3.png" width="70%" height="auto"  class="reachImg">				
				</div>
				<%
			}
		}
		else
		{

			
			String sql="select * from memberInfo where name=? and id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,checkName);
			pstmt.setString(2,checkId);
			rs = pstmt.executeQuery();
			
			
			while(rs.next()){
				user_id = rs.getString("id");
				user_pw = rs.getString("pw");
				user_name = rs.getString("name");
				user_heart=rs.getInt("heart");
			}
			
			if(user_heart==0)
			{
				%>
				<div class="title" style="color:black; padding-top:100px;">하트가 하나도 없네용</div>

				<%
			}
			else
			{
				user_heart--;
				String sql_update="update memberInfo set heart=? where id=? and name=?";
				pstmt=conn.prepareStatement(sql_update);
				pstmt.setInt(1,user_heart);
				pstmt.setString(2,user_id);
				pstmt.setString(3,user_pw);
				pstmt.executeUpdate();
				
			}
			
			
			%>
			<div style="text-align:right">
			
			<%
				for(int i=0; i<user_heart;i++)
				{
					%>
					<img src="like.png" width="40px" height="40px" style="margin-top:10px;">
					<%
				}
			%>
			</div>
			<div class="title" style="color:black">실패입니다.</div>
			<script>
			document.body.style.backgroundImage  = "url('sad.gif')";
			</script>
			
			
			<%

		}
		
		%>
		<center><input type='button' onclick="location.href='entertainer_event.jsp'" value='다음' class="submitBtn"/></center>
		
		<%
		
		
		
	}

					}//else종료
%>
</body>
</html>