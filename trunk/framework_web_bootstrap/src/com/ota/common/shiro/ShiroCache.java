package com.ota.common.shiro;

import java.io.Serializable;

import org.apache.shiro.cache.Cache;
import org.apache.shiro.cache.CacheManager;

/**
 * @author Dylan
 * @time 2014年1月8日
 */
public class ShiroCache {

	private static CacheManager cacheManager;

	/**
	 * 清除用户的授权信息
	 * 
	 * @param username
	 */
	public static void clearAuthorizationInfo(String username) {

		Cache<Object, Object> cache = cacheManager.getCache("myRealm.authorizationCache");
		cache.remove(username);

	}

	public static void clearAuthorizationInfoAll() {
		Cache<Object, Object> cache = cacheManager.getCache("myRealm.authorizationCache");
		cache.clear();

	}

	/**
	 * 清除session(认证信息)
	 * 
	 * @param JSESSIONID
	 */
	public static void clearAuthenticationInfo(Serializable JSESSIONID) {
		Cache<Object, Object> cache = cacheManager.getCache("shiro-activeSessionCache");
		cache.remove(JSESSIONID);
	}

	public static CacheManager getCacheManager() {
		return cacheManager;
	}

	public static void setCacheManager(CacheManager cacheManager) {
		ShiroCache.cacheManager = cacheManager;
	}

}
