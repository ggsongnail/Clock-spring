<%@ include file="/WEB-INF/jsp/include.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Hello</title>
</head>
<body>
<font size="5"><b>Hello World</b></font>
<c:forEach items="${accounts}" var="account">
	<p>${account.name}-${account.money}</p>
</c:forEach>
</body>
</html>