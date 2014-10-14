<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

  
      <div id="main" style="height:300px;border:1px solid #ccc;padding:5px;"></div>
     <script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js"></script>
    <script src="${pageContext.request.contextPath}/js/echarts/echarts-plain.js"></script>
  
 <script type="text/javascript">
 
 var myChart = echarts.init(document.getElementById('main'));

 
 
	 $(function(){
		
		 
		 chart();
		 
	 });
 
 
 


 
function chart(url){
 
option = {
	    tooltip : {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['人数']
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
	    calculable : true,
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : ['周一','周二','周三','周四','周五','周六','周日']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value',
	            axisLabel : {
	                formatter: '{value} '
	            },
	            splitArea : {show : true}
	        }
	    ],
	    series : [
	        {
	            name:'人数',
	            type:'line',
	            itemStyle: {
	                normal: {
	                    lineStyle: {
	                        shadowColor : 'rgba(0,0,0,0.4)'
	                    }
	                }
	            },
	            data:[11, 11, 15, 13, 12, 13, 10],
	            markPoint : {
	                data : [
	                    {name : '周最高', value : 15, xAxis: '周三', yAxis: 15.5}
	                ]
	            }
	        }
	    ]
	};
   myChart.hideLoading();
   myChart.setOption(option, true);


// ajax
  $.get(url,function(data){
  
 },'json')}
 
 

      
    </script>
</html>
