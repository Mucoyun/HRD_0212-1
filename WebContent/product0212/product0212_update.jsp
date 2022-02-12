<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 27 -</title>
	<script>
		function gotry() {
			if(document.iu_form.id.value == ""){
				alert("상품코드를 입력하지 않았습니다.");
				document.iu_form.id.focus();
			}else if(document.iu_form.wname.value == ""){
				alert("작성자 이름을 입력하지 않았습니다.");
				document.iu_form.wname.focus();
			}else if(document.iu_form.pname.value == ""){
				alert("상품이름을 입력하지 않았습니다.");
				document.iu_form.pname.focus();
			}else{
				document.iu_form.submit();	
			}
		}
		function notry() {
			location.href = "/HRD_0212/product0212/product0212_select.jsp";
		}
	</script>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%
		String send_id = request.getParameter("send_id");
	
		try{
			String sql = "select id,category,wname,pname,sname,price,downprice,to_char(inputdate,'yyyy-mm-dd'),stock,description from product0212 where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, send_id);
			rs = pstmt.executeQuery();
			if(rs.next()){
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
	<section>
		<h2>상품 수정</h2>
		<form name="iu_form" method="post" action="product0212_update_process.jsp">
			<table id="iu_table">
				<tr>
					<th>상품 코드</th>
					<td><input type="text" name="id" value="<%=id %>" readonly></td>
					<th>상품분류</th>
					<td>
						<select name="category">
							<option value="11">가구</option>
							<option value="22">전기/전지</option>
							<option value="33">부엌용품</option>
							<option value="44">의류</option>
							<option value="55">보석 및 액세서리</option>
							<option value="66">헬스기구</option>
							<option value="77">컴퓨터관련</option>
							<option value="88">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>작성자 이름</th>
					<td><input type= "text" name="wname" value="<%=wname %>"></td>
					<th>상품 이름</th>
					<td><input type="text" name="pname" value="<%=pname %>"></td>
				</tr>
				<tr>
					<th>제조사 이름</th>
					<td colspan="3"><input type="text" name="sname" value="<%=sname %>"></td>
				</tr>
				<tr>
					<th>시중가격</th>
					<td><input type="text" name="price" value="<%=price %>"></td>
					<th>판매가격</th>
					<td><input type="text" name="downprice" value="<%=downprice %>"></td>
				</tr>
				<tr>
					<th>날짜</th>
					<td><input type="text" name="inputdate" value="<%=inputdate %>"></td>
					<th>재고량</th>
					<td><input type="number" name="stock" value="<%=stock %>"></td>
				</tr>
				<tr>
					<th>메모</th>
					<td colspan="3">
						<textarea name="description" rows="5" cols="100"><%=description %></textarea>
					</td>
				</tr>
				<tr>
					<td id="btntd" colspan="4">
						<button type="button" onclick="notry()">목록</button>
						<button type="button" onclick="gotry()">수정</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
	%>
	<%@ include file="/footer.jsp" %>
</body>
</html>