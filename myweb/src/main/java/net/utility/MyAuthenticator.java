package net.utility;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MyAuthenticator extends Authenticator{
	//사용하고자 하는 메일 서버에서 인증받은 계정 +비번 등록

	private PasswordAuthentication pa;
	public MyAuthenticator() {
		pa=new PasswordAuthentication("이메일 아이디","이메일 비밀번호");

	}

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return pa;
	}
}
