package com.ota.common.shiro;

import org.apache.shiro.session.Session;
import org.apache.shiro.session.SessionListenerAdapter;

import com.ota.base.Constant;

public class WebSessionListener extends SessionListenerAdapter {

	@Override
	public void onExpiration(Session session) {
		super.onExpiration(session);

		System.out.println("---session过期处理");
		session.removeAttribute(Constant.SESSION_USER);

	}
}
