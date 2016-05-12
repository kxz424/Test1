package com.kgs7276.board.persistence;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.kgs7276.board.domain.MessageVO;

@Repository
public class MessageDAOImpl implements MessageDAO {
	
	@Inject
	private SqlSession session;
	
	private static String namespace="com.kgs7276.board.mapper.MessageMapper";

	@Override
	public void create(MessageVO message) throws Exception {
		
		session.insert(namespace + ".create", message);

	}

	@Override
	public MessageVO read(Integer mid) throws Exception {
		
		return session.selectOne(namespace + ".read", mid);
	}

	@Override
	public void update(Integer mid) throws Exception {
		
		session.update(namespace + ".update", mid);

	}

}
