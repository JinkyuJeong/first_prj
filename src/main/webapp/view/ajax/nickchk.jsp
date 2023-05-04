<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${able }">
<span>사용가능한 닉네임 입니다.</span>
</c:if>
<c:if test="${!able }">
<span>중복된 닉네임 입니다.</span>
</c:if>