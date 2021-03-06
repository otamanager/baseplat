<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

  
      <div id="main" style="height:600px;border:1px solid #ccc;padding:5px;"></div>
     <script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    <script src="${pageContext.request.contextPath}/js/echarts/echarts-plain.js"></script>
  
 <script type="text/javascript">
 
 var myChart = echarts.init(document.getElementById('main'));
 
$(function(){
		 parent.$.messager.progress('close');
		 chart();
});
 
 

 
function chart(url){
 
	option = {
		    title : {
		        text: '动态数据',
		        subtext: '纯属虚构'
		    },
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		        data:['最新成交价', '预购队列']
		    },
		    toolbox: {
		        show : true,
		        feature : {
		            mark : true,
		            dataView : {readOnly: false},
		            magicType:['line', 'bar'],
		            restore : true,
		            saveAsImage : true
		        }
		    },
		    dataZoom : {
		        show : false,
		        realtime: true,
		        start : 50,
		        end : 100
		    },
		    xAxis : [
		        {
		            type : 'category',
		            boundaryGap : true,
		            data : (function(){
		                var now = new Date();
		                var res = [];
		                var len = 10;
		                while (len--) {
		                    res.unshift(now.toLocaleTimeString().replace(/^\D*/,''));
		                    now = new Date(now - 2000);
		                }
		                return res;
		            })()
		        },
		        {
		            type : 'category',
		            boundaryGap : true,
		            splitline : {show : false},
		            data : (function(){
		                var res = [];
		                var len = 10;
		                while (len--) {
		                    res.push(len + 1);
		                }
		                return res;
		            })()
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            scale: true,
		            precision:1,
		            power:1,
		            name : '价格',
		            boundaryGap: [0.2, 0.2],
		            splitArea : {show : true}
		        },
		        {
		            type : 'value',
		            scale: true,
		            name : '预购量',
		            boundaryGap: [0.2, 0.2]
		        }
		    ],
		    series : [
		        {
		            name:'预购队列',
		            type:'line',
		            xAxisIndex: 1,
		            yAxisIndex: 1,
		            itemStyle: {
		                normal: {
		                    color : 'rgba(135,206,205,0.4)'
		                }
		            },
		            data:(function(){
		                var res = [];
		                var len = 10;
		                while (len--) {
		                    res.push(Math.round(Math.random() * 1000));
		                }
		                return res;
		            })()
		        },
		        {
		            name:'最新成交价',
		            type:'line',
		            itemStyle: {
		                normal: {
		                    // areaStyle: {type: 'default'},
		                    lineStyle: {
		                        shadowColor : 'rgba(0,0,0,0.4)'
		                    }
		                }
		            },
		            data:(function(){
		                var res = [];
		                var len = 10;
		                while (len--) {
		                    res.push((Math.random()*10 + 5).toFixed(1) - 0);
		                }
		                return res;
		            })()
		        }
		    ]
		};
		var lastData = 11;
		var axisData;
		//clearInterval(timeTicket);
		timeTicket = setInterval(function(){
		    lastData += Math.random() * ((Math.round(Math.random() * 10) % 2) == 0 ? 1 : -1);
		    lastData = lastData.toFixed(1) - 0;
		    axisData = (new Date()).toLocaleTimeString().replace(/^\D*/,'');
		    
		    // 动态数据接口 addData
		    myChart.addData([
		        [
		            0,        // 系列索引
		            Math.round(Math.random() * 1000), // 新增数据
		            true,     // 新增数据是否从队列头部插入
		            false     // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
		        ],
		        [
		            1,        // 系列索引
		            lastData, // 新增数据
		            false,    // 新增数据是否从队列头部插入
		            false,    // 是否增加队列长度，false则自定删除原有数据，队头插入删队尾，队尾插入删队头
		            axisData  // 坐标轴标签
		        ]
		    ]);
		}, 2000);
	
	
	
   myChart.hideLoading();
   myChart.setOption(option, true);
   
} 


    </script>
</html>
