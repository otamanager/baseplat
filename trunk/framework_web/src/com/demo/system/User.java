/**
 * 
 */
package com.demo.system;

import java.util.List;

import org.apache.commons.lang.StringUtils;

import com.jfinal.plugin.activerecord.Model;
import com.jfinal.plugin.activerecord.Page;

/**
 * ('id', 'int(11)'), ('name', 'varchar(20)'), ('login_name', 'varchar(20)'),
 * ('mobile', 'varchar(20)'), ('email', 'varchar(20)'), ('create_time', 'date'),
 * ('create_by', 'int(11)')
 */
@SuppressWarnings("serial")
public class User extends Model<User> {
	public static final User dao = new User();

	public Page<User> queryPage(Integer pageNum, Integer pageSize) {
		StringBuffer sql = new StringBuffer("from user where 1=1 ");
		if (StringUtils.isNotEmpty(getStr("name"))) {
			sql.append(" and  name='").append(getStr("name")).append("' ");
		}
		if (StringUtils.isNotEmpty(getStr("login_name"))) {
			sql.append(" and login_name='").append(getStr("login_name")).append("' ");
		}
		if (StringUtils.isNotEmpty(getStr("mobile"))) {
			sql.append(" and mobile='").append(getStr("mobile")).append("' ");
		}

		return paginate(pageNum, pageSize, "select * ", sql.append(" order by create_time").toString());
	}

	public User queryBy() {
		List<User> userList = find("select * from user where login_name='" + getStr("login_name")
				+ "' and password = '" + getStr("password") + "' ");
		if (null == userList || 0 == userList.size()) {
			return null;
		} else {
			return userList.get(0);
		}
	}

	public void demo() {
		// 创建name属性为James,age属性为25的User对象并添加到数据库
		new User().set("name", "James").set("age", 25).save();
		// 删除id值为25的User
		User.dao.deleteById(25);
		// 查询id值为25的User将其name属性改为James并更新到数据库
		User.dao.findById(25).set("name", "James").update();
		// 查询id值为25的user, 且仅仅取name与age两个字段的值
		User user = User.dao.findById(25, "name, age");
		// 获取user的name属性
		String userName = user.getStr("name");
		// 获取user的age属性
		Integer userAge = user.getInt("age");
		// 查询所有年龄大于18岁的user
		List<User> users = User.dao.find("select * from user where age>18");
		// 分页查询年龄大于18的user,当前页号为1,每页10个user
		Page<User> userPage = User.dao.paginate(1, 10, "select *", "from user where age > ?", 18);
	}
}
