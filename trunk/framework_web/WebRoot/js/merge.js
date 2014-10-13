/**
*只支持行合并，合并同一列中，相邻td中sign属性相同的td
**/
var Merge = {
	merge : function (tableId){//过滤出同一列相邻td中sign属性相同的td	
		var tdLeng  = 0;
		if($("#"+ tableId +" tr:eq(0) td")[0] == null){
			tdLeng  = $("#"+ tableId +" tr:eq(0) th").length
		}else{
			tdLeng  = $("#"+ tableId +" tr:eq(0) td").length
		}
		
		var $tableTr = $("#"+ tableId +" tr");
		//var $oldTd, $newTd, $firstTd ="";
		var arrayTd = [];
		//var num = 0;
		
		for(var c = 0 ; c < tdLeng;c++){
			//循环比较同一列的td
			$.each($tableTr,function(i,item){
				var $obj = $(item).children("td:eq("+c+")");
				//如果td有sign属性
				if($obj.attr("sign") != null){
					arrayTd.push($obj);//记录相邻并且相同sign的td
					//如果当前td是最后一个进行合并处理
					if(i == $tableTr.length-1){
						Merge.doMerge(arrayTd);
					}
				//如果td没有sign属性，则合并上面记录的arrayTd
				}else if($obj.attr("sign") == null){
					Merge.doMerge(arrayTd);
					arrayTd = [];
				}
	
			});
		}
	},
	doMerge : function (arrayTd){//将过滤出来的td合并
		var oldTd, newTd, $firstTd ="";
		var num = 0;
		$.each(arrayTd,function(m,item){
			if(m == 0) {
				oldTd = $(item).attr("sign");
				$firstTd = $(item);
			}
			newTd = $(item).attr("sign");
			if( oldTd == newTd) {
				num ++;
				m == 0 ? "" : $(item).hide();
				m == arrayTd.length-1 ? $firstTd.attr("rowspan",num) : "";
			} else {
				oldTd = newTd;
				$firstTd.attr("rowspan",num);
				$firstTd = $(item);
				num = 1;
			}
		});
	}

};