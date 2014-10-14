<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<script src="${pageContext.request.contextPath}/js/Highcharts-3.0.1/js/highcharts.js"></script>
<script src="${pageContext.request.contextPath}/js/Highcharts-3.0.1/js/modules/exporting.js"></script>


	<script type="text/javascript">
		
		$(function () {
			
			$.get('${CONTEXT_PATH}/system/log/getVisitCount',function(data){
	
			
		    $('#container').highcharts({
		        title: {
		            text: 'User line chart',
		            x: -20 //center
		        },
		        credits : {
					enabled : false
				},
		        xAxis: {
		            categories: data.categories
		        },
		        yAxis: {
		            plotLines: [{
		                value: 0,
		                width: 1,
		                color: '#808080'
		            }]
		        },
		        legend: {
		            layout: 'vertical',
		            align: 'right',
		            verticalAlign: 'middle',
		            borderWidth: 0
		        },
		        series: data.series
		        });
			
			} ,'json');
			
		});



</script>
	</head>
		<div id="container"
			style=" height: 300px;"></div>


