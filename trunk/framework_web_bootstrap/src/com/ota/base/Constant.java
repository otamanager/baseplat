package com.ota.base;

public class Constant {
	public static final String SESSION_USER = "user";

	public static final String ERROR_MSG = "msg";

	public static final boolean SAE = true;
	public static boolean SHIRO_OPEN = true;

	public static boolean ALIYUN_DB = false;
	public static boolean SAE_DB = true;

	public class URL {
		public static final String SAE_BASE = "/jfinalauthority";
		public static final String LOGIN = "/loginView";
		public static final String BASE = "/page";
		// 子模块
		public static final String COMMON = BASE + "/common";
		public static final String SYSTEM = BASE + "/system";
		public static final String ERROR = BASE + "/error";
		public static final String INDEX = BASE + "/index";

		public static final String VIEW_COMMON_LOGIN = COMMON + "/login.jsp";
		public static final String VIEW_COMMON_INIT = COMMON + "/init.html";
		public static final String VIEW_COMMON_JUMP = COMMON + "/jump.html";

		public static final String VIEW_INDEX = INDEX + "/index.jsp";
		public static final String VIEW_INDEX_MSG = INDEX + "/msg.jsp";

		public static final String VIEW_ERROR_401 = ERROR + "/401.html";
	}
}
