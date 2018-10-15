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
<style>
body {
	width: 100wh;
	height: 90vh;
	color: #fff;
	background: linear-gradient(270deg, #fc6262, #fcc1c1, #f25d86, #ffd5e0);
	background-size: 400% 400%;
	-webkit-animation: Gradient 15s ease infinite;
	-moz-animation: Gradient 15s ease infinite;
	animation: Gradient 15s ease infinite;
}

@-webkit-keyframes Gradient {
	0% {
		background-position: 0% 50%
	}
	50% {
		background-position: 100% 50%
	}
	100% {
		background-position: 0% 50%
	}
}

@-moz-keyframes Gradient {
	0% {
		background-position: 0% 50%
	}
	50% {
		background-position: 100% 50%
	}
	100% {
		background-position: 0% 50%
	}
}

@keyframes Gradient {
	0% {
		background-position: 0% 50%
	}
	50% {
		background-position: 100% 50%
	}
	100% {
		background-position: 0% 50%
	}
}


center img {
    border-radius: 8px;
}
#str {
	text-align:center;
	font-size:1.5em;
	padding:5%;
	color: black;
	font-weight: bold;
}

#msg {
	text-align:center;
	font-size:1.5em;
	padding:10%;
	padding-top:200px;
	color: black;
	font-weight: bold;
}


/* The container */
.container {
    display: block;
    position: relative;
    padding-left: 35px;
    margin-bottom: 12px;
    cursor: pointer;
    font-size: 22px;
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
}

/* Hide the browser's default radio button */
.container input {
    position: absolute;
    opacity: 0;
    cursor: pointer;
}

/* Create a custom radio button */
.checkmark {
    position: absolute;
    top: 0;
    left: 0;
    height: 25px;
    width: 25px;
    background-color: #eee;
    border-radius: 50%;
}

/* On mouse-over, add a grey background color */
.container:hover input ~ .checkmark {
    background-color: #ccc;
}

/* When the radio button is checked, add a blue background */
.container input:checked ~ .checkmark {
    background-color: #fd999a;
}

/* Create the indicator (the dot/circle - hidden when not checked) */
.checkmark:after {
    content: "";
    position: absolute;
    display: none;
}

/* Show the indicator (dot/circle) when checked */
.container input:checked ~ .checkmark:after {
    display: block;
}

/* Style the indicator (dot/circle) */
.container .checkmark:after {
 	top: 9px;
	left: 9px;
	width: 8px;
	height: 8px;
	border-radius: 50%;
	background: white;
}


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

.hintBtn
{
	background-color: white;
    color: black;
    border: 2px solid black;
    width:90px;
    height:40px;
    border-radius: 12px;
	margin-top:20px;
	position:absolute;
	right:20px;
	top:50px;
	font-size:0.9em;
}

.hintBtn:hover{background-color: black; color:white; }



</style>




</head>
<body >
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

			
			var string = "회원만 참여가능합니다. 로그인하세요!";
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
				
				String sql="select * from memberInfo where name=?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1,checkName);
				rs = pstmt.executeQuery();
				
				
				while(rs.next()){
					user_id = rs.getString("id");
					user_pw = rs.getString("pw");
					user_name = rs.getString("name");
					user_heart=rs.getInt("heart");
					
				}
			}catch(Exception e){
				System.out.println("select 실패");
			}finally{
				if(pstmt!=null)
					try{pstmt.close(); } catch(SQLException sqle){}
				if(conn!=null)
					try{pstmt.close(); } catch(SQLException sqle){}
			
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
<% 
					
	ArrayList<String> imgURl = new ArrayList<String>();
	imgURl.add(0, "고낙은");
	imgURl.add(1, "신혜정");
	imgURl.add(2, "유병석");
	imgURl.add(3, "이대형");
	imgURl.add(4, "이재민");
	imgURl.add(5, "이하얀");
	imgURl.add(6, "이형섭");
	imgURl.add(7, "임정훈");
	imgURl.add(8, "정우진");
	imgURl.add(9, "최규정");
	imgURl.add(10, "함기훈");

	
	Random rand = new Random();
	int randNum = rand.nextInt(11);//0-18
	
	String correct = imgURl.get(randNum);
	String imgSrc ="image/teacher/big/"+correct+".jpg";
	String orgin_imgSrc ="image/teacher/origin/"+correct+".jpg";

	//랜덤 숫자 저장
	int[] randRadioNum = new int[5];
	randRadioNum[0] = randNum;
	for(int i=1; i<randRadioNum.length; i++){
		
		randRadioNum[i]= (int)(Math.random()*11);
		if(randRadioNum[i]==randRadioNum[0]) { }
		
		for(int j=0; j<i;j++){
			if(randRadioNum[i]==randRadioNum[j] ){
				i--;
				break;
			}
		}
	}
	
	//셔플
	int n1,n2,nTemp;
	for(int i=0; i<10;i++)
	{
		n1=rand.nextInt(randRadioNum.length);
		n2=rand.nextInt(randRadioNum.length);
		
		nTemp = randRadioNum[n1];
		randRadioNum[n1] = randRadioNum[n2];
		randRadioNum[n2] = nTemp;
	}
	
%>
<div id="str"></div>

<input id="hintId" type="hidden" name="correctHint" value="<%=orgin_imgSrc%>" >
<button type="button" class="hintBtn" onclick="javascript:openChildWindow();" id="hintButton">힌트</button>
<button type="button" class="hintBtn" onclick="setChildText();" id="realHint" style="display:none">힌트보기</button>

<script type="text/javascript">
      // 자식창 window 객체를 저장할 변수
        var openWin;
      function openChildWindow(){
    	  window.name = "friend_event.jsp";
          openWin = window.open("hint.jsp","hint", "width=750, height=500, resizable = no, scrollbars = no"); 
          document.getElementById("hintButton").style.display='none';
          document.getElementById("realHint").style.display='block';

      }
      function setChildText()
      {
          openWin.document.getElementById("imgUrl").value = document.getElementById("hintId").value;
          openWin.document.getElementById("myimage").src=openWin.document.getElementById("imgUrl").value;
		  openWin.imageZoom("myimage", "myresult");
          document.getElementById("realHint").style.display='none';
          openWin.document.getElementById("msg").innerHTML="원본사진에 커서를 갖다놓고 줌사진을 확인하세요!";

      }
    </script>

  

<center><img src="<%=imgSrc %>" width="330px" height="330px" > </center>

<form method="post" action="teacher_eventResult.jsp">
<div style="margin-left:20%; margin-top:20px;">
<%
	String radioStr="";
	for(int i=0; i<randRadioNum.length;i++)
	{
		radioStr= imgURl.get(randRadioNum[i]);	
		%>
		<label class="container"><%=radioStr%>
		<input type="radio" name="radio_teacher" value="<%=radioStr%>"><span class="checkmark"></span>
		</label>
		<%
	}
	
%>
<input type="hidden" name="correctAnswer" value="<%=correct%>">
<input type="submit" value="선택" class="submitBtn">
</div>


	</form>
	<script>
		var string = "확대사진의 주인공은 누구일까요?";
		var str = string.split("");
		var el = document.getElementById('str');
		(function animate() {
		str.length > 0 ? el.innerHTML += str.shift() : clearTimeout(running);
		var running = setTimeout(animate, 150);
		})();
	</script>
	<%
	}//else종료
					
%>
</body>
</html>