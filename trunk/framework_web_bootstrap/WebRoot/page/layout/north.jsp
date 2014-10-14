<%@ page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


  
<link href="${pageContext.request.contextPath}/js/jquery.weather/images/default/julying-weather.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/js/jquery.weather/css/main.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/jquery.weather/js/jquery.weather.js"></script> 
 
 
  
<script type="text/javascript">

;var jQueryWeatherConfig = {
	lang : {
		day : '白天',
		night : '夜晚',
		temp : '°C',
		wind : '级风',
		wangzimo : '12shu'
	},
	convert : function(sky){
		var weatherInfo = {
				cloudy 		: ['多云','多云转阴','晴转多云','阴转多云'],
				overcast	: ['阴','雾','沙尘暴','浮尘','扬沙','强沙尘暴'],
				rainy		: ['多云转小雨','小雨转多云','小雨','中雨','大雨','暴雨','大暴雨','特大暴雨','冻雨','小雨转中雨','中雨转大雨','大雨转暴雨','暴雨转大暴雨','大暴雨转特大暴雨','阵雨','雷阵雨','雷阵雨伴有冰雹'],
				sleet		: ['雨夹雪'],
				snow		: ['阵雪','小雪','中雪','大雪','暴雪','小雪转中雪','中雪转大雪','大雪转暴雪','中雪转小雪','大雪转中雪','暴雪转大雪'],
				sunshine	: ['晴']
			},
			weather = '',
			state = '';
		for( state in weatherInfo ){
			if( $.inArray( sky , weatherInfo[state] ) > -1 ){
				weather = state;
				break;
			}
		} 
		return weather || state || 'sunshine'  ;
	}
};




 
$(function(){
	
	
	$.getScript('http://php.weather.sina.com.cn/iframe/index/w_cl.php?code=js&day=0&city=&charset=utf-8', function(){
		//window.SWther 这是返回的天气情况
		var city, dataInfo = window.SWther.w ;
		for( var city in dataInfo ); //获取 天气
		dataInfo = dataInfo[city][0];
		//jQueryWeatherConfig 
		var weatherData = {
			city : city ,
			date : SWther.add.now.split(' ')[0] || '',
			day_weather: dataInfo.s1,
			night_weather :dataInfo.s2,
			day_temp: dataInfo.t1,
			night_temp: dataInfo.t2,
			day_wind:dataInfo.p1,
			night_wind: dataInfo.p2
		};
		
		var hour = (new Date( SWther.add.now )).getHours();
		var sky = hour > 18 ? weatherData.day_weather : weatherData.night_weather ;
		var weatherBox = $('#debug').weather({ sky : jQueryWeatherConfig.convert( sky ), weatherData : weatherData , config : jQueryWeatherConfig });
		  
		//weatherBox 是 整个天气图标的跟节点的 jQuery ，所以可以直接操作，可以自己随意扩展效果。

	});
	
});

</script>


 

<script type="text/javascript" charset="utf-8">
	/**
	 * 
	 * @requires jQuery,EasyUI,jQuery cookie plugin
	 * 
	 * 更换EasyUI主题的方法
	 * 
	 * @param themeName
	 *            主题名称
	 */
	function changeThemeFun(themeName) {
		
		if ($.cookie('easyuiThemeName')) {
			
			$('#layout_north_pfMenu').menu(
					'setIcon',
					{
						target : $('#layout_north_pfMenu div[title='
								+ $.cookie('easyuiThemeName') + ']')[0],
						iconCls : 'emptyIcon'
					});
		}
		
		
		$('#layout_north_pfMenu').menu('setIcon', {
			target : $('#layout_north_pfMenu div[title=' + themeName + ']')[0],
			iconCls : 'tick'
		});
		var $easyuiTheme = $('#easyuiTheme');
		var url = $easyuiTheme.attr('href');
		var href = url.substring(0, url.indexOf('themes')) + 'themes/'
				+ themeName + '/easyui.css';
		$easyuiTheme.attr('href', href);

		var $iframe = $('iframe');
		if ($iframe.length > 0) {
			for ( var i = 0; i < $iframe.length; i++) {
				var ifr = $iframe[i];
				try {
					$(ifr).contents().find('#easyuiTheme').attr('href', href);
				} catch (e) {
					try {
						ifr.contentWindow.document
								.getElementById('easyuiTheme').href = href;
					} catch (e) {
					}
				}
			}
		}

		$.cookie('easyuiThemeName', themeName, {
			expires : 7
		});

	};

	function logoutFun() {
			location.replace('${pageContext.request.contextPath}/loginOut');
	}
	
	
</script>



<!-- -
<div id="sessionInfoDiv"
	style="position: absolute; right: 0px; top: 0px;"
	class="alert alert-info">
    
	<c:if test="${ipAddress!=null&&ipAddress!=''}"> [<strong>${user.name}</strong>]，欢迎你！
	 您使用 [<strong>${ipAddress}</strong>]IP登录!</c:if>

</div>
 -->

<div id="debug"  style="float:right;height:200px  width:300px; margin-right:300px;  position:relative; z-index: 1"></div> 


  

<div style="position: absolute; right: 0px; bottom: 0px;">
    
	<a href="javascript:void(0);" class="easyui-menubutton"
		data-options="menu:'#layout_north_pfMenu',iconCls:'cog'">更换皮肤</a> 
		
		<a
		href="javascript:void(0);" class="easyui-menubutton"
		data-options="menu:'#layout_north_zxMenu',iconCls:'cog'">注销</a>
</div>


<div id="layout_north_pfMenu" style="width: 120px; display: none;">
	<div onclick="changeThemeFun('default');" title="default">default</div>
	<div onclick="changeThemeFun('gray');" title="gray">gray</div>
	<div onclick="changeThemeFun('metro');" title="metro">metro</div>
	<div onclick="changeThemeFun('bootstrap');" title="bootstrap">bootstrap</div>
	<div onclick="changeThemeFun('black');" title="black">black</div>
	
</div>
<div id="layout_north_zxMenu" style="width: 100px; display: none;">
	<div onclick="logoutFun();">重新登录</div>
	<div onclick="logoutFun();">退出系统</div>
</div>