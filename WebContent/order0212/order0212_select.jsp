<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 27 -</title>
	<style>
		#s_table tr{
			height: 30px;
		}#s_table th{
			height: 50px;
		}#s_table td{
			text-align: center;
		}p{
			padding: 0 !important;
			display: block;
			width: 1400px;
			margin: 0 auto;
		}
		#btn{
			display: block;
			color: white; background-color: black;
			margin: 10px auto;
			width: 100px; height: 30px; 
		}
	</style>
	<script>
		function notry() {
			location.href = "/HRD_0212/order0212/order0212_insert.jsp";
		}
	</script>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%
		int no = 0;
		try{
			String sql = "select count(*) from order0212";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()){
				no = rs.getInt(1);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
	<section>
		<h2>상품 목록</h2>
		<p>총 <%=no %>개의 주문이 있습니다.</p><hr>
		<table id="s_table">
			<tr>
				<th width="100">상품코드</th>
				<th width="100">주문자 이름</th>
				<th width="100">주문 날짜</th>
				<th width="300">배달 주소</th>
				<th width="200">전화번호</th>
				<th width="100">결제방법</th>
				<th width="100">카드번호</th>
				<th width="100">주문상품수</th>
				<th width="100">판매가격</th>
				<th width="100">총금액</th>
				<th width="100">구분</th>
			</tr>
			<% 
			try{
				String sql = "select a.id,a.name,a.orderdate,a.addr,a.tel,a.pay,a.cardno,a.prodcount,b.price,a.total from order0212 a, product0212 b where a.id=b.id order by id asc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
					String id = rs.getString(1);
					String name = rs.getString(2);
					String orderdate = rs.getString(3);
					String addr = rs.getString(4);
					String tel = rs.getString(5);
					String pay = rs.getString(6);
					String cardno = rs.getString(7);
					String prodcount = rs.getString(8);
					String price = rs.getString(9);
					String total = rs.getString(10);
					%>
					<tr>
						<td><%=id %></td>
						<td><%=name %></td>
						<td><%=orderdate %></td>
						<td><%=addr %></td>
						<td><%=tel %></td>
						<td><%=pay %></td>
						<td><%=cardno %></td>
						<td><%=prodcount %></td>
						<td><%=price %></td>
						<td><%=total %></td>
						<td>
							<a href="order0212_update.jsp?send_id=<%=id%>&send_name=<%=name%>">수정</a>
							<span>/</span>
							<a href="order0212_delete.jsp?send_id=<%=id%>&send_name=<%=name%>"
							onclick="if(!confirm('정말로 삭제하시겠습니까?')){ return false; }">삭제</a>
						</td>
					</tr>
					<%
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
			%>
		</table>
		<button id="btn" type="button" onclick="notry()">작성</button>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>