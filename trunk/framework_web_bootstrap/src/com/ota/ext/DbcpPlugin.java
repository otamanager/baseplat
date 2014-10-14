package com.ota.ext;

//package com.demo.common;
//
//import java.sql.SQLException;
//
//import javax.sql.DataSource;
//
//import org.apache.commons.dbcp.BasicDataSource;
//
//import com.jfinal.plugin.IPlugin;
//import com.jfinal.plugin.activerecord.IDataSourceProvider;
//
//public final class DbcpPlugin implements IPlugin, IDataSourceProvider
//{
//	private String jdbcUrl;
//	private String user;
//	private String password;
//	private String driverClass = "com.mysql.jdbc.Driver";
//	private int maxPoolSize = 100;
//	private int minPoolSize = 10;
//	private int initialPoolSize = 10;
//	private int maxIdleTime = 20;
//	
//	private static DataSource dataSource;
//	
//	
//
//	public String getJdbcUrl()
//	{
//		return jdbcUrl;
//	}
//
//	public void setJdbcUrl(String jdbcUrl)
//	{
//		this.jdbcUrl = jdbcUrl;
//	}
//
//	public String getUser()
//	{
//		return user;
//	}
//
//	public void setUser(String user)
//	{
//		this.user = user;
//	}
//
//	public String getPassword()
//	{
//		return password;
//	}
//
//	public void setPassword(String password)
//	{
//		this.password = password;
//	}
//
//	public String getDriverClass()
//	{
//		return driverClass;
//	}
//
//	public void setDriverClass(String driverClass)
//	{
//		this.driverClass = driverClass;
//	}
//
//	public int getMaxPoolSize()
//	{
//		return maxPoolSize;
//	}
//
//	public void setMaxPoolSize(int maxPoolSize)
//	{
//		this.maxPoolSize = maxPoolSize;
//	}
//
//	public int getMinPoolSize()
//	{
//		return minPoolSize;
//	}
//
//	public void setMinPoolSize(int minPoolSize)
//	{
//		this.minPoolSize = minPoolSize;
//	}
//
//	public int getInitialPoolSize()
//	{
//		return initialPoolSize;
//	}
//
//	public void setInitialPoolSize(int initialPoolSize)
//	{
//		this.initialPoolSize = initialPoolSize;
//	}
//
//	public int getMaxIdleTime()
//	{
//		return maxIdleTime;
//	}
//
//	public void setMaxIdleTime(int maxIdleTime)
//	{
//		this.maxIdleTime = maxIdleTime;
//	}
//
//
//	public static void setDataSource(DataSource dataSource)
//	{
//		DbcpPlugin.dataSource = dataSource;
//	}
//
//	@Override
//	public DataSource getDataSource()
//	{
//		return dataSource;
//	}
//	
//	
//	public DbcpPlugin(String jdbcUrl, String username, String pwd)
//	{
//		this.jdbcUrl =jdbcUrl;
//		this.user=username;
//		this.password=pwd;
//	}
//
//	public DbcpPlugin(String jdbcUrl, String username, String pwd, String driverClass, int initialSize, int maxPoolSize, int maxIdleTime)
//	{
//		this.jdbcUrl =jdbcUrl;
//		this.user=username;
//		this.password=pwd;
//		this.driverClass=driverClass;
//		this.initialPoolSize=initialSize;
//		this.maxPoolSize=maxPoolSize;
//		this.maxIdleTime =maxIdleTime;
//		
//	}
//
//	public DbcpPlugin(String jdbcUrl, String user, String password, String driverClass) {
//		this.jdbcUrl = jdbcUrl;
//		this.user = user;
//		this.password = password;
//		this.driverClass = driverClass != null ? driverClass : this.driverClass;
//	}
//	@Override
//	public boolean start()
//	{
//		BasicDataSource ds = new BasicDataSource();  
//        ds.setDriverClassName(driverClass);  
//        ds.setUsername(user);  
//        ds.setPassword(password);  
//        ds.setUrl(jdbcUrl);  
//        ds.setInitialSize(initialPoolSize); // 初始的连接数；  
//        ds.setMaxActive(maxPoolSize);  
//        ds.setMaxIdle(minPoolSize);
//        
//        ds.setMaxWait(10000);
//        dataSource = ds;  
//		
//		return true;
//	}
//
//	@Override
//	public boolean stop()
//	{
//		try
//		{
//			((BasicDataSource) dataSource).close();
//		} catch (SQLException e)
//		{
//			e.printStackTrace();
//		}
//
//		return true;
//	}
//
// }
