<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="ssi.jsp" %>
<%@ include file="../header.jsp" %>
<h3>회원 정보 수정</h3>

<%
String id= (String)session.getAttribute("s_id");
String passwd=(String)session.getAttribute("s_passwd");
dto=dao.read(id);
if(dto==null){
	out.println("해당 회원 없음!!");
}else{
%>
<span style="color:red; font-weight: bold"> * 필수입력</span>
<form name="modifyfrm" id="modifyfrm" method="post" action="memberModifyProc.jsp" onsubmit="return memberCheck()">
<table class="table">
<tr>
<th>*아이디</th>
<td style="text-align: left">
<input type="text" name="id" id="id" size="10" maxlength="10" value="<%=id%>" readonly>
</td>
</tr>

<tr>
<th>*비밀번호</th>
<td style="text-align: left">
<input type="password" name="passwd" id="passwd" size="10" maxlength="10" value="<%=passwd%>"required>
</td>
</tr>

<tr>
<th>*비밀번호 확인</th>
<td style="text-align: left">
<input type="password" name="passwd1" id="passwd1" size="10" maxlength="10"  value="<%=dto.getPasswd()%>" required>
</td>
</tr>

<tr>
<th>*이름</th>
<td style="text-align: left">
<input type="text" name="mname" id="mname" size="20" maxlength="20" value="<%=dto.getMname()%>" required>
</td>
</tr>

<tr>
<th>*이메일</th>
<td style="text-align: left">
<input type="email" name="email" id="email" size="10" maxlength="50" value="<%=dto.getEmail()%>" readonly>
<input type="button" value="Email중복확인" onclick="emailCheck()">
</td>
</tr>

<tr>
<th>전화번호</th>
<td style="text-align: left">
<input type="text" name="tel" id="tel" size="14" maxlength="15" value="<%=dto.getTel()%>">
</td>
</tr>

<tr>
<th>우편번호</th>
<td style="text-align: left">
<input type="text" name="zipcode" id="zipcode" size="7" readonly value="<%=dto.getZipcode()%>">
<input type="button" value="주소찾기" onclick="DaumPostcode()">
</td>
</tr>

<tr>
<th>주소</th>
<td style="text-align: left">
<input type="text" name="address1" id="address1" size="45" readonly value="<%=dto.getAddress1()%>">
</td>
</tr>

<tr>
<th>나머지 주소</th>
<td style="text-align: left">
<input type="text" name="address2" id="address2" size="45" value="<%=dto.getAddress2()%>">
</td>
</tr>

<tr>  
  <th>직업</th>
  <td style="text-align: left">
        <select name="job"  id="job">
          <option value="0">선택하세요.</option>
          <option value="A01" <%if(dto.getJob().equals("A01")){out.print("selected");}%>>회사원</option>
          <option value="A02" <%if(dto.getJob().equals("A02")){out.print("selected");}%>>IT관련직</option>
          <option value="A03" <%if(dto.getJob().equals("A03")){out.print("selected");}%>>학생</option>
          <option value="A04" <%if(dto.getJob().equals("A04")){out.print("selected");}%>>주부</option>
          <option value="A05" <%if(dto.getJob().equals("A05")){out.print("selected");}%>>기타</option>
        </select>
  </td>
</tr>
<tr>
<td colspan="2">
<input type="submit" value="수정하기" class="btn btn-primary">
<input type="reset" value="취소" class="btn btn-light">
</td>
</tr>
</table>
</form>

<!-- 우편번호 -->


<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:5px 0;position:relative">
<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
</div>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    // 우편번호 찾기 찾기 화면을 넣을 element
    var element_wrap = document.getElementById('wrap');

    function foldDaumPostcode() {
        // iframe을 넣은 element를 안보이게 한다.
        element_wrap.style.display = 'none';
    }

    function DaumPostcode() {
        // 현재 scroll 위치를 저장해놓는다.
        var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
        new daum.Postcode({
            oncomplete: function(data) {
                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("address2").value = extraAddr;
                
                } else {
                    document.getElementById("address2").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("address1").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address2").focus();

                // iframe을 넣은 element를 안보이게 한다.
                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
                element_wrap.style.display = 'none';

                // 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
                document.body.scrollTop = currentScroll;
            },
            // 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
            onresize : function(size) {
                element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);

        // iframe을 넣은 element를 보이게 한다.
        element_wrap.style.display = 'block';
    }
</script>
<%
}
%>
<!--우편번호  -->








<%@ include file="../footer.jsp" %>