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
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String orderdate = request.getParameter("orderdate");
		String addr = request.getParameter("addr");
		String tel = request.getParameter("tel");
		String pay = request.getParameter("pay");
		String cardno = request.getParameter("cardno");
		String prodcount = request.getParameter("prodcount");
		String total = request.getParameter("total");
		
		int stock = 0;
		int getprodcount = 0;
		
		try{
			String sql = "select a.stock,b.prodcount from product0212 a,order0212 b where a.id=b.id and b.id=? and b.name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			rs = pstmt.executeQuery();
			if(rs.next()){
				stock = rs.getInt(1);
				getprodcount = rs.getInt(2);
			}
			
			int result = (stock+getprodcount) - Integer.parseInt(prodcount);
			
			sql = "update product0212 set stock=? where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, result);
			pstmt.setString(2, id);
			pstmt.executeUpdate();
			
			sql = "update order0212 set orderdate=?,addr=?,tel=?,pay=?,cardno=?,prodcount=?,total=? where id=? and name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderdate);
			pstmt.setString(2, addr);
			pstmt.setString(3, tel);
			pstmt.setString(4, pay);
			pstmt.setString(5, cardno);
			pstmt.setString(6, prodcount);
			pstmt.setString(7, total);
			pstmt.setString(8, id);
			pstmt.setString(9, name);
			pstmt.executeUpdate();
			%><script>
				alert("수정이 완료되었습니다.");
				location.href = "/HRD_0212/order0212/order0212_select.jsp";
			</script><%
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
</body>
</html>