update board set views = (views +1) where board_no = 1;

drop table board CASCADE CONSTRAINTS;

CREATE TABLE BOARD (
    BOARD_NO NUMBER PRIMARY KEY,
    USER_ID  VARCHAR2(30) NOT NULL,
    TITLE    VARCHAR2(150) NOT NULL,
    CONTENT CLOB,   --글을 입력하는 부분. varchar2는 최대 4000바이트. 부족할 수 있기 때문에 대용량 글자를 쓸 수 있는 단위인 clob을 사용.
    REG_DATE DATE NOT NULL,
    VIEWS NUMBER NOT NULL,
    UPDATE_DATE DATE,
    FILE_NAME VARCHAR2(255)
);

CREATE SEQUENCE BOARD_SEQ
       INCREMENT BY 1
       START WITH 1
       MINVALUE 1
       MAXVALUE 9999
       NOCYCLE
       NOCACHE
       NOORDER;


insert into board (board_no, user_id, title, content, reg_date, views)
values(board_seq.nextval, 'test1', '안녕하세요.', '미국 곳곳에 겨울 혹한과 눈폭풍이 불어닥치면서 제작비로 4천 5백억 원 이상이 들어간 영화 흥행에 타격이 있을 것이란 보도들이 이어졌습니다.', sysdate, 0);

INSERT INTO BOARD (BOARD_NO, USER_ID, TITLE, CONTENT, REG_DATE, VIEWS)
VALUES(BOARD_SEQ.nextval, 'test2', '날씨가 춥네요.', '하지만 뉴욕이 1906년 이후 가장 추운 크리스마스를 맞는 등 미국 전역에 폭설과 혹한이 몰아치면서 대부분 영화 흥행이 기대 이하에 머물 것으로 전망됩니다.', sysdate, 5);

INSERT INTO BOARD (BOARD_NO, USER_ID, TITLE, CONTENT, REG_DATE, VIEWS)
VALUES(BOARD_SEQ.nextval, 'test3', '날씨가 춥네요222', '하지만 뉴욕이 1906년 이후 가장 추운 크리스마스를 맞는 등 미국 전역에 폭설과 혹한이 몰아치면서 대부분 영화 흥행이 기대 이하에 머물 것으로 전망됩니다.', sysdate, 15);

INSERT INTO BOARD (BOARD_NO, USER_ID, TITLE, CONTENT, REG_DATE, VIEWS)
VALUES(BOARD_SEQ.nextval, 'test1', '연말입니다.', '하지만 뉴욕이 1906년 이후 가장 추운 크리스마스를 맞는 등 미국 전역에 폭설과 혹한이 몰아치면서 대부분 영화 흥행이 기대 이하에 머물 것으로 전망됩니다.', sysdate, 0);

INSERT INTO BOARD (BOARD_NO, USER_ID, TITLE, CONTENT, REG_DATE, VIEWS)
VALUES(BOARD_SEQ.nextval, 'test2', '치즈케이크 맛있음', '하지만 뉴욕이 1906년 이후 가장 추운 크리스마스를 맞는 등 미국 전역에 폭설과 혹한이 몰아치면서 대부분 영화 흥행이 기대 이하에 머물 것으로 전망됩니다.', sysdate, 2);

INSERT INTO BOARD (BOARD_NO, USER_ID, TITLE, CONTENT, REG_DATE, VIEWS)
VALUES(BOARD_SEQ.nextval, 'test3', '저녁은 뭘먹나', '하지만 뉴욕이 1906년 이후 가장 추운 크리스마스를 맞는 등 미국 전역에 폭설과 혹한이 몰아치면서 대부분 영화 흥행이 기대 이하에 머물 것으로 전망됩니다.', sysdate, 1);

COMMIT;
