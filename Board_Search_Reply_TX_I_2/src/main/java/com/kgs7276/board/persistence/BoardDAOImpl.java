package com.kgs7276.board.persistence;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kgs7276.board.domain.BoardVO;
import com.kgs7276.board.domain.SearchCriteria;

@Repository
public class BoardDAOImpl implements BoardDAO {

	private static final String namespace = "com.kgs7276.board.mapper.BoardMapper";

	@Inject
	private SqlSession session;

	//게시글 등록
	@Override
	public void create(BoardVO board) throws Exception {
		session.insert(namespace + ".create", board);
	}

	//검색 게시글 목록(페이징 적용 유, SearchCriteria 객체 사용)
	@Override
	public List<BoardVO> list(SearchCriteria criteria) throws Exception {

		return session.selectList(namespace + ".list", criteria) ;

	}

	//검색 게시글 개수
	@Override
	public int listCount(SearchCriteria criteria) throws Exception {

		return session.selectOne(namespace + ".listCount", criteria) ;

	}

	//게시글 조회
	@Override
	public BoardVO read(Integer bno) throws Exception {

		return session.selectOne(namespace + ".read", bno);

	}

	//게시글 수정
	@Override
	public void update(BoardVO board) throws Exception {

		session.update(namespace + ".update", board);

	}

	//게시물 삭제
	@Override
	public void delete(Integer bno) throws Exception {

		session.delete(namespace + ".delete", bno);

	}

	//게시글에 달린 댓글의 갯수
	@Override
	public void updateReplyCnt(Integer bno, int amount) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno", bno);
		map.put("amount", amount);
		
		session.update(namespace + ".updateReplyCnt", map);
		
	}

	@Override
	public void updateViewCut(Integer bno) throws Exception {
		
		session.update(namespace + ".updateViewCnt", bno);
		
	}	

}