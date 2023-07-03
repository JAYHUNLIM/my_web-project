<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>email 중복 확인</title>
</head>
<body>
	<div style="text-align: center">
		<h3>이메일 중복 확인</h3>
		<form action="emailCheckProc.jsp" onsubmit="return doubleCheck()">
			아이디: <input type="email" name="email" id="email" maxlength="50" autofocus>
			<input type="submit" value="중복확인">
		</form>
	</div>

<script>

	function doubleCheck() {
		let email = document.getElementById("email").value;
		email = email.trim();
		if (email.length< 5) {
			alert(" 이메일은 5글자 이상 입력해 주세요");
			return false;
		}
		return true;
	}
</script>

</body>
</html>