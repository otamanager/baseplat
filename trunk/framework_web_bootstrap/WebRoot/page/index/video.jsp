<%@ page language="java" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<!-- Title and other stuffs -->

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link href="http://vjs.zencdn.net/4.4/video-js.css" rel="stylesheet">
<script src="http://vjs.zencdn.net/4.4/video.js"></script>
<script>
  videojs.options.flash.swf = "http://example.com/path/to/video-js.swf" ;
</script>
</head>

<body >

<video id="example_video_1" class="video-js vjs-default-skin"
  controls preload="auto"
  height="100%" width="100%"
  poster="http://video-js.zencoder.com/oceans-clip.png"
  data-setup='{"example_option":true}'>
 <source src="http://video-js.zencoder.com/oceans-clip.mp4" type='video/mp4' />
 <source src="http://video-js.zencoder.com/oceans-clip.webm" type='video/webm' />
 <source src="http://video-js.zencoder.com/oceans-clip.ogv" type='video/ogg' />
</video>
</body>

</html>
