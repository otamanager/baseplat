package com.ota.common;

import java.security.interfaces.RSAPublicKey;

import org.apache.commons.codec.binary.Hex;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.ExcessiveAttemptsException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;

import com.jfinal.aop.Before;
import com.jfinal.ext.route.ControllerBind;
import com.ota.base.Constant;
import com.ota.common.validator.LoginValidator;
import com.ota.ext.Controller;
import com.ota.module.system.model.Log;
import com.ota.module.system.model.User;
import com.ota.util.RSA;
import com.ota.util.Sec;
import com.ota.util.Validate;

/***
 * 
 * 月落斜阳 灯火阑珊
 * 
 * @author 12
 * 
 */
@ControllerBind(controllerKey = "/")
public class CommonController extends Controller {
	public void index() {

		render(Constant.URL.VIEW_INDEX);
	}

	public void jump() {

		Log.dao.insert(this, Log.EVENT_VISIT);

		render(Constant.URL.VIEW_COMMON_JUMP);
	}

	public void loginView() {
		if (init())
			return;

		RSAPublicKey publicKey = RSA.getDefaultPublicKey();
		String modulus = new String(Hex.encodeHex(publicKey.getModulus().toByteArray()));
		String exponent = new String(Hex.encodeHex(publicKey.getPublicExponent().toByteArray()));

		setAttr("modulus", modulus);
		setAttr("exponent", exponent);

		render(Constant.URL.VIEW_COMMON_LOGIN);

	}

	private boolean init() {
		if (Constant.SAE)
			return false;

		String init = getCookie("init");

		if (init == null)
			setCookie("init", "init", 1000 * 60 * 60 * 24 * 365, "/jfinalauthority", null);

		render(Constant.URL.VIEW_COMMON_INIT);

		return Validate.isEmpty(init);
	}

	public void loginOut() {
		try {
			Subject subject = SecurityUtils.getSubject();
			subject.logout();

			renderTop(Constant.URL.LOGIN);

		} catch (AuthenticationException e) {
			e.printStackTrace();
			renderText("异常：" + e.getMessage());
		}
	}

	@Before(LoginValidator.class)
	public void login() {
		String[] result = RSA.decryptUsernameAndPwd(getPara("key"));

		try {
			User user = User.dao.findByName(result[0]);
			UsernamePasswordToken token = new UsernamePasswordToken(result[0], Sec.md5(result[1]));
			Subject subject = SecurityUtils.getSubject();
			if (!subject.isAuthenticated()) {
				token.setRememberMe(true);
				subject.login(token);
				subject.getSession(true).setAttribute(Constant.SESSION_USER, user);

			}

			Log.dao.insert(this, Log.EVENT_LOGIN);

			redirect("/");

		} catch (UnknownAccountException e) {

			forwardAction("用户名不存在", Constant.URL.LOGIN);

		} catch (IncorrectCredentialsException e) {
			// 密码错误
			forwardAction("密码错误", Constant.URL.LOGIN);

		} catch (LockedAccountException e) {
			// : 帐号锁定
			forwardAction("对不起 帐号被封了", Constant.URL.LOGIN);
		} catch (ExcessiveAttemptsException e) {
			forwardAction("尝试次数过多 请明天再试", Constant.URL.LOGIN);
		} catch (AuthenticationException e) {
			forwardAction("对不起 没有权限 访问", Constant.URL.LOGIN);
		} catch (Exception e) {
			e.printStackTrace();
			forwardAction("请重新登录", Constant.URL.LOGIN);
		}

	}

	public void unauthorized() {

		render(Constant.URL.VIEW_ERROR_401);
	}

}
