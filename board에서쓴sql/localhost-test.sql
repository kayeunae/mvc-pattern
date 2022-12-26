update board set views = (views +1) where board_no = 1;

drop table board CASCADE CONSTRAINTS;

CREATE TABLE BOARD (
    BOARD_NO NUMBER PRIMARY KEY,
    USER_ID  VARCHAR2(30) NOT NULL,
    TITLE    VARCHAR2(150) NOT NULL,
    CONTENT CLOB,   --���� �Է��ϴ� �κ�. varchar2�� �ִ� 4000����Ʈ. ������ �� �ֱ� ������ ��뷮 ���ڸ� �� �� �ִ� ������ clob�� ���.
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
values(board_seq.nextval, 'test1', '�ȳ��ϼ���.', '�̱� ������ �ܿ� Ȥ�Ѱ� ����ǳ�� �Ҿ��ġ�鼭 ���ۺ�� 4õ 5��� �� �̻��� �� ��ȭ ���࿡ Ÿ���� ���� ���̶� �������� �̾������ϴ�.', sysdate, 0);

INSERT INTO BOARD (BOARD_NO, USER_ID, TITLE, CONTENT, REG_DATE, VIEWS)
VALUES(BOARD_SEQ.nextval, 'test2', '������ ��׿�.', '������ ������ 1906�� ���� ���� �߿� ũ���������� �´� �� �̱� ������ ������ Ȥ���� ����ġ�鼭 ��κ� ��ȭ ������ ��� ���Ͽ� �ӹ� ������ �����˴ϴ�.', sysdate, 5);

INSERT INTO BOARD (BOARD_NO, USER_ID, TITLE, CONTENT, REG_DATE, VIEWS)
VALUES(BOARD_SEQ.nextval, 'test3', '������ ��׿�222', '������ ������ 1906�� ���� ���� �߿� ũ���������� �´� �� �̱� ������ ������ Ȥ���� ����ġ�鼭 ��κ� ��ȭ ������ ��� ���Ͽ� �ӹ� ������ �����˴ϴ�.', sysdate, 15);

INSERT INTO BOARD (BOARD_NO, USER_ID, TITLE, CONTENT, REG_DATE, VIEWS)
VALUES(BOARD_SEQ.nextval, 'test1', '�����Դϴ�.', '������ ������ 1906�� ���� ���� �߿� ũ���������� �´� �� �̱� ������ ������ Ȥ���� ����ġ�鼭 ��κ� ��ȭ ������ ��� ���Ͽ� �ӹ� ������ �����˴ϴ�.', sysdate, 0);

INSERT INTO BOARD (BOARD_NO, USER_ID, TITLE, CONTENT, REG_DATE, VIEWS)
VALUES(BOARD_SEQ.nextval, 'test2', 'ġ������ũ ������', '������ ������ 1906�� ���� ���� �߿� ũ���������� �´� �� �̱� ������ ������ Ȥ���� ����ġ�鼭 ��κ� ��ȭ ������ ��� ���Ͽ� �ӹ� ������ �����˴ϴ�.', sysdate, 2);

INSERT INTO BOARD (BOARD_NO, USER_ID, TITLE, CONTENT, REG_DATE, VIEWS)
VALUES(BOARD_SEQ.nextval, 'test3', '������ ���Գ�', '������ ������ 1906�� ���� ���� �߿� ũ���������� �´� �� �̱� ������ ������ Ȥ���� ����ġ�鼭 ��κ� ��ȭ ������ ��� ���Ͽ� �ӹ� ������ �����˴ϴ�.', sysdate, 1);

COMMIT;
