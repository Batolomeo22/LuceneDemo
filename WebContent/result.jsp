<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" 
	import="java.util.ArrayList"
	import="lucene.file.search.model.FileModel" 
	import="java.util.regex.*"
	import="lucene.file.search.service.RegexHtml"
	import="java.util.Iterator"
	import="java.net.URLEncoder"%>
<%
	String path = request.getContextPath();//获取工程根目录
	String basePath = request.getScheme() + "://" + request.getServerName() 
	                  + ":" + request.getServerPort()+ path + "/";
	String regEx_html = "<[^>]+>";
	// 创建 Pattern 对象
	Pattern r = Pattern.compile(regEx_html);
	// 现在创建 matcher 对象
	RegexHtml regexHtml = new RegexHtml();
	ArrayList<FileModel> hitsList = (ArrayList<FileModel>) request.getAttribute("hitsList");
	String queryback = (String) request.getAttribute("queryback");
%>
<%@ page language="java" import="com.zhuozhengsoft.pageoffice.*" %>
<%@ taglib uri="http://java.pageoffice.cn" prefix="po" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<base href="<%=basePath%>">
<title>搜索结果</title>
<link type="text/css" rel="stylesheet" href="css/result.css">
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="pageoffice.js" id="po_js_main"></script>
<!-- script type="text/javascript" src="js/jquery-1.10.2.js"></script>
<script type="text/javascript" src="${ctp}/pageoffice.js" id="po_js_main"></script-->

		<script type="text/javascript">
		    
		    function encodeFN(filename){
		        console.log(filename)
		        var encFileName = encodeURIComponent(filename);
		        var url = "FilePreviewServlet?filename="+encFileName+"";
		        console.log(url)
		    	POBrowser.openWindowModeless(url , 'width=1200px;height=800px;');
		    	 }
		</script>
</head>
<body>
	<div class="searchbox">
		<div class="logo">
			<a href="index.jsp"><img alt="文件检索" src="images/logo.png"></a>
		</div>
		<div class="searchform">
			<form action="SearchFile" method="get">
				<input type="text" name="query" value="<%=queryback%>"> <input
					type="submit" value="搜索">
			</form>
		</div>
	</div>
	<div class="result">
		<h4>
			共搜到<span style="color: red; font-weight: bold;"><%=hitsList.size()%></span>条结果
		</h4>
		<%
			if (hitsList.size() > 0) {
				Iterator<FileModel> iter = hitsList.iterator();
				FileModel fm;
				while (iter.hasNext()) {
					fm = iter.next();
		%>		
		<div class="item">
			<div class="itemtop">
				<h4>
					<img alt="pdf" src="images/<%=fm.getTitle().split("\\.")[1]%>.png"
						class="doclogo">
					<!-- %=fm.getTitle().split("\\.")[0]%-->
					<a href="javascript:encodeFN('<%=regexHtml.delHtmlTag(fm.getTitle())%>');" ><%=fm.getTitle().split("\\.")[0]%></a>
				</h4>
				<h3>
					<a href="FileDownloadServlet?filename=
					<%=regexHtml.delHtmlTag(fm.getTitle())%>">点击下载</a>
				</h3>
			</div>
			<div class="itembuttom">
				<p><%=fm.getContent().length() > 210 ? fm.getContent().substring(0, 210)
						: fm.getContent()%>...	</p>
			</div>
			<hr class="itemline">
		</div>
		<%
			}
			}
		%>
	</div>
	<div class="footer">
		<p>Lucene</p>
		<p>&copy;2019</p>
	</div>

</body>
</html>