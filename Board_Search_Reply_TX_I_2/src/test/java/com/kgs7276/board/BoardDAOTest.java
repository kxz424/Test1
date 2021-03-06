package com.kgs7276.board;

import java.util.List;
import java.util.Scanner;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.kgs7276.board.domain.BoardVO;
import com.kgs7276.board.domain.SearchCriteria;
import com.kgs7276.board.persistence.BoardDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(
		locations = {
				"file:src/main/webapp/WEB-INF/spring/**/*.xml"
		})
public class BoardDAOTest {

	private static final Logger logger = LoggerFactory.getLogger(BoardDAOTest.class);

	@Inject
	private BoardDAO dao;

	//게시물 등록 테스트
	@Test
	public void testCreate() throws Exception {

		BoardVO board = new BoardVO();
		board.setTitle("제목");
		board.setContent("내용");
		board.setWriter("김권식");

		dao.create(board);

		logger.info("게시물 등록 성공");

	}

	
	//게시물 목록 테스트(페이징 처리 유, SearchCriteria 객체 사용)
	@Test
	public void testList() throws Exception {

		Scanner scanner = new Scanner(System.in);
		System.out.println("조회할 페이지 번호를 입력하세요.");
		int page = scanner.nextInt();
		System.out.println("페이지별 표시할 게시글의 갯수를 입력하세요.");
		int perPageNum = scanner.nextInt();
		System.out.println("검색 타입을 입력하세요.");
		String searchType = scanner.next();
		System.out.println("키워드를 입력하세요.");
		String keyword = scanner.next();
		scanner.close();

		SearchCriteria criteria = new SearchCriteria();
		criteria.setPage(page);
		criteria.setPerPageNum(perPageNum);
		criteria.setSearchType(searchType);
		criteria.setKeyword(keyword);

		List<BoardVO> list = dao.list(criteria);
		
		logger.info("listSearchCount : " + dao.listCount(criteria));

		if(list == null) {
			logger.info("게시물이 하나도 없습니다.");
		} else {
			for(BoardVO board : list) {
				System.out.println(board.getBno() + "\t" + board.getTitle() + "\t" +
						board.getContent() + "\t" + board.getWriter() + "\t" + 
						board.getRegdate() + "\t" + board.getViewcnt());
			}
		}

	}

	//게시물 조회 테스트
	@Test
	public void testRead() throws Exception {

		Scanner scanner = new Scanner(System.in);
		System.out.println("조회할 게시글 번호를 입력하세요.");
		int bno = scanner.nextInt(); 
		scanner.close();

		BoardVO board = dao.read(bno);

		if(board == null) {
			logger.info("조회하신 게시글이 없습니다.");
		} else {
			System.out.println(board.getBno() + "\t" + board.getTitle() + "\t" +
					board.getContent() + "\t" + board.getWriter() + "\t" + 
					board.getRegdate() + "\t" + board.getViewcnt());
		}

	}

	//게시물 수정 테스트
	@Test
	public void testUpdate() throws Exception {

		Scanner scanner = new Scanner(System.in);
		System.out.println("수정할 게시글 번호를 입력하세요.");
		int bno = scanner.nextInt(); 
		scanner.close();

		BoardVO board = new BoardVO();
		board.setBno(bno);
		board.setTitle("수정 제목");
		board.setContent("수정 내용"); 
		board.setWriter("수정 김권식");

		dao.update(board);

	}

	//게시물 삭제 테스트
	@Test
	public void testDelete() throws Exception {

		Scanner scanner = new Scanner(System.in);
		System.out.println("삭제할 게시글 번호를 입력하세요.");
		int bno = scanner.nextInt(); 
		scanner.close();

		dao.delete(bno);

	}	

}