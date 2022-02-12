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
			location.href = "/HRD_0212/product0212/product0212_insert.jsp";
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
			String sql = "select count(*) from product0212";
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
		<p>총 <%=no %>개의 상품이 있습니다.</p><hr>
		<table id="s_table">
			<tr>
				<th width="100">상품코드</th>
				<th width="100">상품분류</th>
				<th width="100">작성자 이름</th>
				<th width="100">상품이름</th>
				<th width="100">제조사 이름</th>
				<th width="100">시중가격</th>
				<th width="100">판매가격</th>
				<th width="200">날짜</th>
				<th width="100">재고량</th>
				<th width="300">메모</th>
				<th width="100">구분</th>
			</tr>
			<% 
			try{
				String sql = "select id,category,wname,pname,sname,price,downprice,to_char(inputdate,'yyyy-mm-dd'),stock,description from product0212 order by id asc";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while(rs.next()){
					String id = rs.getString(1);
					String category = rs.getString(2);
					String wname = rs.getString(3);
					String pname = rs.getString(4);
					String sname = rs.getString(5);
					String price = rs.getString(6);
					String downprice = rs.getString(7);
					String inputdate = rs.getString(8);
					String stock = rs.getString(9);
					String description = rs.getString(10);
					%>
					<tr>
						<td><%=id %></td>
						<td><%=category %></td>
						<td><%=wname %></td>
						<td><%=pname %></td>
						<td><%=sname %></td>
						<td><%=price %></td>
						<td><%=downprice %></td>
						<td><%=inputdate %></td>
						<td><%=stock %></td>
						<td><%=description %></td>
						<td>
							<a href="product0212_update.jsp?send_id=<%=id%>">수정</a>
							<span>/</span>
							<a href="product0212_delete.jsp?send_id=<%=id%>"
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