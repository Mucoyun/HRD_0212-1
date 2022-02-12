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
	<%@ include file="/header.jsp" %>
	<%@ include file="/nav.jsp" %>
	<section>
		<h2>상품 추가</h2>
		<form name="iu_form" method="post" action="product0212_insert_process.jsp">
			<table id="iu_table">
				<tr>
					<th>상품 코드</th>
					<td><input type="text" name="id"></td>
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
					<td><input type= "text" name="wname"></td>
					<th>상품 이름</th>
					<td><input type="text" name="pname"></td>
				</tr>
				<tr>
					<th>제조사 이름</th>
					<td colspan="3"><input type="text" name="sname"></td>
				</tr>
				<tr>
					<th>시중가격</th>
					<td><input type="text" name="price"></td>
					<th>판매가격</th>
					<td><input type="text" name="downprice"></td>
				</tr>
				<tr>
					<th>날짜</th>
					<td><input type="text" name="inputdate"></td>
					<th>재고량</th>
					<td><input type="number" name="stock"></td>
				</tr>
				<tr>
					<th>메모</th>
					<td colspan="3">
						<textarea name="description" rows="5" cols="100"></textarea>
					</td>
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