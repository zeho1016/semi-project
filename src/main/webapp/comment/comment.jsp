<%@page import="dao2.DiabloBoardDao"%>
<%@page import="vo.Board"%>
<%@page import="vo.Comment"%>
<%@page import="vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	String content = request.getParameter("content");

	User loginUserInfo = (User) session.getAttribute("LOGIN_USER_INFO");
	
	if (loginUserInfo == null) {
		response.sendRedirect("../index.jsp?error=noLogin");
		return;
	}

	if(content == null || content.isBlank()){
		response.sendRedirect("../2/detail.jsp?no="+boardNo+"&error=comcont");
		return;
	}

	DiabloBoardDao boardDao = DiabloBoardDao.getInstance();
	Board board = boardDao.getBoardDetail(boardNo);

	Comment comment = new Comment();
	
	comment.setBoard(board);
	comment.setWriter(loginUserInfo);
	comment.setContent(content);
	
	boardDao.insertComment(comment);
	
	board.setCommentCount(board.getCommentCount() + 1);
	boardDao.updateBoard(board);
	
	response.sendRedirect("../2/detail.jsp?no="+boardNo);
%>