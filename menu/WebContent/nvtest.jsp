<%@page import="naver.NSearch"%>
<%@ page language="java" contentType="application/json; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    request.setCharacterEncoding("utf-8");
    String search = request.getParameter("search");
    search = "경남대학교";
    System.out.println(search);
    String result = NSearch.getDate(search);
    out.println(result);
    %>
