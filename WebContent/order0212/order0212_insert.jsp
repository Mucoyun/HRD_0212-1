<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>윤원태 - 실습 27 -</title>
	<script>
		function gotry() {
			var pay = document.getElementsByName("pay");
			
			if(document.iu_form.id.value == ""){
				alert("상품코드를 입력하지 않았습니다.");
				document.iu_form.id.focus();
			}else if(document.iu_form.name.value == ""){
				alert("주문자 이름을 입력하지 않았습니다.");
				document.iu_form.name.focus();
			}else if(document.iu_form.addr.value == ""){
				alert("배달 주소를 입력하지 않았습니다.");
				document.iu_form.addr.focus();
			}else if((pay[1].checked==true)&&(document.iu_form.cardno.value=="")){
				alert("카드번호를 입력하세요.");
				document.iu_form.cardno.focus();
			}else{
				document.iu_form.action = "order0212_insert_process.jsp";
				document.iu_form.submit();	
			}
		}
		function notry() {
			location.href = "/HRD_0212/order0212/order0212_select.jsp";
		}
		function idChk() {
			document.iu_form.submit();
		}
		function payChk() {
			var pay = document.getElementsByName("pay");
			var cardno = document.iu_form.cardno;
			
			if(pay[0].checked == true){
				cardno.value = "";
				cardno.readOnly = true;
			}else{
				cardno.value = "";
				cardno.readOnly = false;
			}
		}
	</script>
</head>
<body>
	<%@ include file="/DBConn.jsp" %>
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<%
		String id = request.getParameter("id");
	
		String name = request.getParameter("name");
		String orderdate = request.getParameter("orderdate");
		String tel = request.getParameter("tel");
		String addr = request.getParameter("addr");
		String pay = request.getParameter("pay");
		String cardno = request.getParameter("cardno");
		String prodcount = request.getParameter("prodcount");
		
		int total;
		int price = 0;
		int stock = 0;
		
		try{
			String sql = "select price,stock from product0212 where id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				price = rs.getInt(1);
				stock = rs.getInt(2);
			}else if(id == null || id.equals("")){
				id = "";
			}else{
				id = "";
				%><script>
					alert("등록되지 않은 코드입니다.");
					idChk();
				</script><%
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		if(name == null) { name = ""; }
		if(orderdate == null) { orderdate = ""; }
		if(tel == null) { tel = ""; }
		if(addr == null) { addr = ""; }
		if(pay == null) { pay = "1"; }
		if(cardno == null) { cardno = ""; }
		if(prodcount == null) { prodcount = "0"; }

		if(Integer.parseInt(prodcount) < 0){
			prodcount = "0";
		}
		if(Integer.parseInt(prodcount) > stock){
			prodcount = Integer.toString(stock);
			%><script>
				alert("보유한 재고수를 초과했습니다.");
			</script><%
		}
		
		total = price * Integer.parseInt(prodcount);
		
	%>
	<section>
		<h2>주문정보 등록</h2>
		<form name="iu_form" method="post" action="order0212_insert.jsp">
			<table id="iu_table">
				<tr>
					<th>상품 코드</th>
					<td><input type="text" name="id" value="<%=id %>" onchange="idChk()"></td>
					<th>주문자 이름</th>
					<td><input type="text" name="name" value="<%=name %>"></td>
				</tr>
				<tr>
					<th>주문 날짜</th>
					<td><input type="text" name="orderdate" value="<%=orderdate %>"></td>
					<th>전화 번호</th>
					<td><input type="text" name="tel" value="<%=tel %>"></td>
				</tr>
				<tr>
					<th>배달 주소</th>
					<td colspan="3"><input type="text" name="addr" value="<%=addr %>"></td>
				</tr>
				<tr>
					<th>결제방법</th>
					<td>
						<input type="radio" name="pay" value="1" <%if(pay.equals("1")){%> checked <%} %> onclick="payChk()"> 현금
						<input type="radio" name="pay" value="2" <%if(pay.equals("2")){%> checked <%} %> onclick="payChk()"> 카드
					</td>
					<th>카드번호</th>
					<td><input type="text" name="cardno" value="<%=cardno %>" readonly></td>
				</tr>
				<tr>
					<th>주문상품수</th>
					<td><input type="number" name="prodcount" value="<%=prodcount %>" onchange="idChk()"></td>
					<th>주문금액</th>
					<td><input type="text" name="total" value="<%=total %>" readonly></td>
				</tr>
				<tr>
					<td id="btntd" colspan="4">
						<button type="button" onclick="notry()">목록</button>
						<button type="button" onclick="gotry()">저장</button>
					</td>
				</tr>
			</table>
		</form>
	</section>
	<%@ include file="/footer.jsp" %>
</body>
</html>