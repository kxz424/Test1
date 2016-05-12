package com.kgs7276.board.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import com.kgs7276.board.domain.BoardVO;
import com.kgs7276.board.domain.SearchCriteria;
import com.kgs7276.board.persistence.BoardDAO;

@Service
public class BoardServiceImpl implements BoardService {

	@Inject
	private BoardDAO dao;	

	@Override
	public void regist(BoardVO board) throws Exception {

		dao.create(board);

	}

	//페이징 처리 유, SearchCriteria 객체 사용
	@Override
	public List<BoardVO> list(SearchCriteria criteria) throws Exception {

		return dao.list(criteria);

	}
	
	//검색 게시물 개수, SearchCriteria 객체 사용
	@Override
	public int listCount(SearchCriteria criteria) throws Exception {
		
		return dao.listCount(criteria);
		
	}

	//게시글 조회
	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public BoardVO read(Integer bno) throws Exception {

		dao.updateViewCut(bno);
		return dao.read(bno);

	}
	
	//게시글 조회
	@Transactional(isolation=Isolation.READ_COMMITTED)
	@Override
	public BoardVO readForModify(Integer bno) throws Exception {

		return dao.read(bno);

	}

	//게시글 수정
	@Override
	public void modify(BoardVO board) throws Exception {

		dao.update(board);

	}
	
	//게시글 삭제
	@Override
	public void remove(Integer bno) throws Exception {

		dao.delete(bno);

	}

}