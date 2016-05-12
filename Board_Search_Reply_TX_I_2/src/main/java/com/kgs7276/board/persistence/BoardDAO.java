package com.kgs7276.board.persistence;

import java.util.List;

import com.kgs7276.board.domain.BoardVO;
import com.kgs7276.board.domain.SearchCriteria;

public interface BoardDAO {

	//게시글 등록
	public void create(BoardVO board) throws Exception;
	
	//게시글 목록(페이지 적용 유, SearchCriteria 객체<page, perPageNum, searchType, keyword> 사용 유)
	public List<BoardVO> list(SearchCriteria criteria) throws Exception;
	
	//검색 게시글 개수(SearchCriteria 객체<page, perPageNum, searchType, keyword> 사용 유)
	public int listCount(SearchCriteria criteria) throws Exception;
		
	//게시글 조회
	public BoardVO read(Integer bno) throws Exception;
	
	//게시글에 달린 댓글의 갯수
	public void updateReplyCnt(Integer bno, int amount) throws Exception;
	
	//게시물 조회수 보이기
	public void updateViewCut(Integer bno) throws Exception;
	
	//게시글 수정
	public void update(BoardVO board) throws Exception;
	
	//게시글 삭제
	public void delete(Integer bno) throws Exception;	
	
}