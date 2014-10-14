<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<style type="text/css">


</style>

<script type="text/javascript" src="${CONTEXT_PATH}/js/music.js"></script>

<script>
    $( function()
    {
        $( 'audio' ).audioPlayer();
    });
</script>
</head>

<body  >

<audio preload="auto"   controls loop style="width: 100%">
		<source src="${CONTEXT_PATH}/file/雨碎江南.mp3" />

</audio>

</body>
</html>



