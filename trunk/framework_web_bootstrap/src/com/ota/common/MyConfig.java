package com.ota.common;

import org.bee.tl.core.GroupTemplate;
import org.bee.tl.ext.jfinal.BeetlRenderFactory;

import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.ext.handler.FakeStaticHandler;
import com.jfinal.ext.interceptor.SessionInViewInterceptor;
import com.jfinal.ext.plugin.shiro.ShiroInterceptor;
import com.jfinal.ext.plugin.shiro.ShiroPlugin;
import com.jfinal.ext.plugin.sqlinxml.SqlInXmlPlugin;
import com.jfinal.ext.plugin.tablebind.AutoTableBindPlugin;
import com.jfinal.ext.route.AutoBindRoutes;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.plugin.ehcache.EhCachePlugin;
import com.jfinal.render.ViewType;
import com.ota.base.Constant;
import com.ota.common.shiro.SessionHandler;
import com.ota.ext.ShiroExt;

/**
 * API引导式配置
 */
public class MyConfig extends JFinalConfig {

	private Routes routes;

	private boolean isDev = isDevMode();

	private boolean isDevMode() {
		String osName = System.getProperty("os.name");
		return osName.indexOf("Windows") != -1;
	}

	/**
	 * 配置常量
	 */
	public void configConstant(Constants me) {

		me.setError404View("/page/error/404.html");
		me.setError401View("/page/error/401.html");
		me.setError403View("/page/error/403.html");

		// if (isDev) loadPropertyFile("classes/db.properties");
		// 加载少量必要配置，随后可用getProperty(...)获取值

		if (isDev)
			loadPropertyFile("classes/db.properties");
		else if (Constant.ALIYUN_DB)
			loadPropertyFile("classes/db-aliyun.properties");
		else if (Constant.SAE_DB)
			loadPropertyFile("classes/db-sae.properties");

		me.setDevMode(isDev);
		me.setViewType(ViewType.JSP); // 设置视图类型为Jsp，否则默认为FreeMarker

		// beel
		// me.setMainRenderFactory(new BeetlRenderFactory());

		GroupTemplate gt = BeetlRenderFactory.groupTemplate;
		gt.registerFunctionPackage("so", new ShiroExt());

	}

	/**
	 * 配置路由
	 */
	public void configRoute(Routes me) {
		this.routes = me;
		// 自动扫描 建议用注解
		me.add(new AutoBindRoutes(false));
	}

	/**
	 * 配置插件
	 */
	public void configPlugin(Plugins me) {
		// sae 好像不能用 druid
		// 配置Druid 数据库连接池插件
		// DruidPlugin dbPlugin = new DruidPlugin(getProperty("jdbcUrl"),
		// getProperty("user"), DruidUtil.decrypt(getProperty("password"),
		// getProperty("decrypt")));
		// // 设置 状态监听与 sql防御
		// WallFilter wall = new WallFilter();
		// wall.setDbType(getProperty("dbType"));
		// dbPlugin.addFilter(wall);
		// dbPlugin.addFilter(new StatFilter());

		C3p0Plugin dbPlugin = new C3p0Plugin(getProperty("jdbcUrl"), getProperty("user"), getProperty("password"));
		me.add(dbPlugin);

		// add EhCache
		me.add(new EhCachePlugin());
		// add sql xml plugin
		me.add(new SqlInXmlPlugin());
		// add shrio

		if (Constant.SHIRO_OPEN)
			me.add(new ShiroPlugin(this.routes));

		// 配置AutoTableBindPlugin插件
		AutoTableBindPlugin atbp = new AutoTableBindPlugin(dbPlugin);
		if (isDev)
			atbp.setShowSql(true);
		atbp.autoScan(false);
		me.add(atbp);

	}

	/**
	 * 配置全局拦截器
	 */
	public void configInterceptor(Interceptors me) {
		// shiro权限拦截器配置
		if (Constant.SHIRO_OPEN)
			me.add(new ShiroInterceptor());
		if (Constant.SHIRO_OPEN)
			me.add(new ShiroInterceptor());

		// 让 模版 可以使用session
		me.add(new SessionInViewInterceptor());
	}

	/**
	 * 配置处理器
	 */
	public void configHandler(Handlers me) {
		// 计算每个page 运行时间
		// me.add(new RenderingTimeHandler());

		// 伪静态处理
		me.add(new FakeStaticHandler());
		// 去掉 jsessionid 防止找不到action
		me.add(new SessionHandler());

		// me.add(new DruidStatViewHandler("/druid"));

		me.add(new ContextPathHandler());
	}

	/**
	 * 运行此 main 方法可以启动项目，此main方法可以放置在任意的Class类定义中，不一定要放于此
	 */
	public static void main(String[] args) {
		JFinal.start("WebRoot", 80, "/", 5);
	}

}
