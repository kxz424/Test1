use book_ex;

create table tbl_member (
	userid varchar(50) not null,
    userpw varchar(50) not null,
    username varchar(50) not null,
    email varchar(100),
    regdate timestamp default now(),
    updatedate timestamp default now(),
    primary key(userid)
);

create table tbl_board (
	bno int not null auto_increment,
    title varchar(200) not null,
    content text null,
    writer varchar(50) not null,
    regdate timestamp not null default now(),
    viewcnt int default 0,
    primary key (bno)
);

drop table tbl_reply;

create table tbl_reply(
	rno int not null auto_increment,
    bno int not null default 0,
    replytext varchar(1000) not null,
    replyer varchar(50) not null,
    regdate timestamp not null default now(),
    updatedate timestamp not null default now(),
    primary key (rno)
);

alter table tbl_reply add constraint fk_board
foreign key (bno) references tbl_board(bno)
on delete cascade on update cascade; -- 본글의 글번호가 삭제되거나, 수정되면 관련 댓글도 삭제 및 수정(댓글의 bno 값)하라

alter table tbl_board add replycnt int not null default 0;

select bno from tbl_board order by bno desc;

select * from tbl_reply where bno = 563;