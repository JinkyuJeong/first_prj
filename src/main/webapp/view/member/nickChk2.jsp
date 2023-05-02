<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<sql:setDataSource var="con" driver="org.mariadb.jdbc.Driver" url="jdbc:mariadb://14.36.141.71:20000/gdudb2" 
user="gdu2" password="0113" />
<sql:query var="rs" dataSource="${con}"> 
	select * from member where nickname=?
	<sql:param>${param.nickname }</sql:param> 
</sql:query>

<c:if test="${! empty rs.rows}">
	<font color=red size=1>사용중인 닉네임 입니다.</font><br>
	<script>	
		document.querySelector("#nickname").value= ""
	</script>	
</c:if>
<c:if test="${empty rs.rows}">
	<font color=green size=1>사용가능한 닉네임 입니다.</font><br>	
</c:if>