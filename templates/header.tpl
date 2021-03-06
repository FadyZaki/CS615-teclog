<html>
<head>
    <title>{$title} - {$Name}</title>
    <link rel="stylesheet" lang="text/css" href="styles.css"/>
 <!--The text editor functionality is provided as a cloud service by the Tinymce web servers
This text editor contain plugins for different functionalites such as formatting texts, adding images and many other functionalities-->
  	<script src="http://cloud.tinymce.com/stable/tinymce.min.js?apiKey=q1lpm4a6u4z67u8gnkeb14y8etcg9gw680shbcot7bmswssc"></script>
  	<script>
  	tinymce.init({
  selector: 'textarea',
  height: 300,
  min_height: 100,
  max_height: 350,
  width: 700,
  theme: 'modern',
  plugins: [
    'advlist autolink lists link image charmap print preview hr anchor pagebreak',
    'searchreplace wordcount visualblocks visualchars code fullscreen',
    'insertdatetime media nonbreaking save table contextmenu directionality',
    'emoticons template paste textcolor colorpicker textpattern imagetools codesample toc'
  ],
  toolbar1: 'undo redo | insert | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image',
  toolbar2: 'print preview media | forecolor backcolor emoticons | codesample',
  content_css: [
    '//fonts.googleapis.com/css?family=Lato:300,300i,400,400i',
    '//www.tinymce.com/css/codepen.min.css'
  ]
 });</script>

</head>
<body>
