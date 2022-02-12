<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 27 -</title>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%
		String send_id = request.getParameter("send_id");
		String send_name = request.getParameter("send_name");
		
		int stock = 0;
		int getprodcount = 0;
		
		try{
			String sql = "select a.stock,b.prodcount from product0212 a,order0212 b where a.id=b.id and b.id=? and b.name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_id);
			pstmt.setString(2, send_name);
			rs = pstmt.executeQuery();
			if(rs.next()){
				stock = rs.getInt(1);
				getprodcount = rs.getInt(2);
			}
			
			int result = stock+getprodcount;
			
			sql = "update product0212 set stock=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, result);
			pstmt.setString(2, send_id);
			pstmt.executeUpdate();
			
			sql = "delete from order0212 where id=? and name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_id);
			pstmt.setString(2, send_name);
			pstmt.executeUpdate();
			%><script>
				alert("삭제가 완료되었습니다.");
				location.href = "/HRD_0212/order0212/order0212_select.jsp";
			</script><%
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
</body>
</html>