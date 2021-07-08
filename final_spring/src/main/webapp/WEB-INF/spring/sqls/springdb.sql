-- MEMBER
DROP SEQUENCE MEMBERSEQ;
DROP TABLE MEMBER

CREATE SEQUENCE MEMBERSEQ;
CREATE TABLE MEMBER(
   MEMBER_NO NUMBER PRIMARY KEY,
   MEMBER_NAME VARCHAR2(20) NOT NULL,
   MEMBER_ID VARCHAR2(20) NOT NULL UNIQUE,
   MEMBER_PW VARCHAR2(20) NOT NULL,
   MEMBER_EMAIL VARCHAR2(50) NOT NULL,
   MEMBER_PHONE VARCHAR2(20) NOT NULL,
   MEMBER_ADDR VARCHAR2(300) NOT NULL,
   MEMBER_PIC VARCHAR2(3000),
   MEMBER_ROLE NUMBER NOT NULL CHECK(MEMBER_ROLE IN(0,1)), -- 관리자 0 , 회원 1
   MEMBER_DELETE NUMBER NOT NULL CHECK(MEMBER_DELETE IN(0,1)) -- 가입중 0 , 탈퇴 1
);

SELECT * FROM MEMBER;
VALUES(MEMBERSEQ.NEXTVAL,'관리자','admin','1234','admin@admin.com','010-1111-2222','서대문구','',0,0);
--
select * from event;
SELECT EVENT_NO, EVENT_TITLE, EVENT_CONTENT, EVENT_START,  EVENT_END, EVENT_FILTER
FROM ( SELECT EVENT_NO, EVENT_TITLE, EVENT_CONTENT, EVENT_START, EVENT_END, EVENT_FILTER, ROW_NUMBER() OVER(ORDER BY EVENT_NO DESC) AS RNUM 
		FROM EVENT WHERE 1=1 AND EVENT_FILTER like '%ㅋ%' AND EVENT_NO > 0) et	
	WHERE RNUM BETWEEN 1 AND 10
	ORDER BY EVENT_NO DESC
	
	
	

-- BOARD
DROP SEQUENCE BOARDSEQ;
DROP TABLE BOARD;

CREATE SEQUENCE BOARDSEQ;
CREATE TABLE BOARD(
    BOARD_NO NUMBER PRIMARY KEY,
    BOARD_CATEGORY VARCHAR2(30) NOT NULL CHECK (BOARD_CATEGORY IN ('정보안내', '소모임', '공지문의', '상품판매', '상품후기')),
    BOARD_ID VARCHAR2(20) NOT NULL,
    BOARD_TITLE VARCHAR2(50) NOT NULL,
    BOARD_CONTENT LONG NOT NULL,
    BOARD_DATE DATE NOT NULL,
    BOARD_VIEWS NUMBER,
    BOARD_SECRET VARCHAR2(10),
    BOARD_INTEREST VARCHAR2(20),
    BOARD_PRODUCT VARCHAR2(20),
    BOARD_PRICE NUMBER,
    BOARD_PRODNO NUMBER,
    BOARD_GROUPNO NUMBER,
    BOARD_GROUP NUMBER,
    MEMBER_NO NUMBER NOT NULL,
    CONSTRAINT BOARD_FK FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO) ON DELETE CASCADE
);


   
SELECT * FROM BOARD;

INSERT INTO BOARD (BOARD_NO, BOARD_CATEGORY, BOARD_ID, BOARD_TITLE, BOARD_CONTENT, BOARD_VIEWS, BOARD_DATE, MEMBER_NO)
VALUES(BOARDSEQ.NEXTVAL, '소모임','ㅋㅋ', '테스트', '테스트', 0, SYSDATE, '5')
--

-- SEARCH
DROP SEQUENCE SEARCHSEQ;
DROP TABLE SEARCH;

CREATE SEQUENCE SEARCHSEQ;
CREATE TABLE SEARCH(
    SEARCH_NO NUMBER PRIMARY KEY,
    SEARCH_NAME VARCHAR2(100) NOT NULL,
    SEARCH_DATE DATE NOT NULL
);
--

-- REPLY
DROP SEQUENCE REPLYSEQ;
DROP TABLE REPLY;

CREATE SEQUENCE REPLYSEQ;
CREATE TABLE REPLY(
   REPLY_NO NUMBER NOT NULL PRIMARY KEY,                                 
   BOARD_NO NUMBER NOT NULL,              
   BOARD_CATEGORY VARCHAR2(30) NOT NULL CHECK (BOARD_CATEGORY IN ('정보안내', '소모임', '공지문의', '상품판매', '상품후기')), 
   REPLY_ID VARCHAR2(20) NOT NULL,     
   REPLY_CONTENT VARCHAR2(1000) NOT NULL,                                 
   REPLY_DATE DATE NOT NULL,
   CONSTRAINT REPLY_FK1 FOREIGN KEY(BOARD_NO) REFERENCES BOARD(BOARD_NO) ON DELETE CASCADE,
   CONSTRAINT REPLY_FK2 FOREIGN KEY(REPLY_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE
);

SELECT * FROM REPLY;
--

-- WISH
DROP SEQUENCE WISHSEQ;
DROP TABLE WISH;

CREATE SEQUENCE WISHSEQ;
CREATE TABLE WISH(
	WISH_NO NUMBER PRIMARY KEY,
	WISH_ID VARCHAR2(20) NOT NULL,
	WISH_PRODUCT VARCHAR2(50) NOT NULL,
	BOARD_NO NUMBER NOT NULL,
	CONSTRAINT WISH_FK1 FOREIGN KEY(WISH_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
	CONSTRAINT WISH_FK2 FOREIGN KEY(BOARD_NO) REFERENCES BOARD(BOARD_NO) ON DELETE CASCADE
);

SELECT * FROM WISH;
--

-- FUNDING
DROP SEQUENCE FUNDINGSEQ;
DROP TABLE FUNDING;

CREATE SEQUENCE FUNDINGSEQ;
CREATE TABLE FUNDING(
	FUNDING_NO NUMBER PRIMARY KEY,
	FUNDING_PIC VARCHAR2(3000) NOT NULL,
	FUNDING_TITLE VARCHAR2(50) NOT NULL,
	FUNDING_CONTENT LONG NOT NULL,
	FUNDING_FILTER VARCHAR2(100) NOT NULL,
	FUNDING_START VARCHAR2(30) NOT NULL,
	FUNDING_END VARCHAR2(30) NOT NULL,
	FUNDING_TA NUMBER NOT NULL,
	FUNDING_CA NUMBER NOT NULL,
	FUNDING_PAY VARCHAR2(30) NOT NULL,
	FUNDING_PAYDESC VARCHAR2(200) NOT NULL
);

INSERT INTO FUNDING
		VALUES(FUNDINGSEQ.NEXTVAL, '페이징테스트', '테스트2', '테스트입니다.', '환경보호', '2021-06-01', '2021-06-29', 30000000, 0, '10000,200000,40000', 'ㅋㅋ');
		
SELECT FUNDING_NO, FUNDING_PIC, FUNDING_TITLE, FUNDING_FILTER, FUNDING_START, FUNDING_END, FUNDING_TA, FUNDING_CA
FROM ( select rownum as rn, FUNDING_NO, FUNDING_PIC, FUNDING_TITLE, FUNDING_FILTER, FUNDING_START, FUNDING_END, FUNDING_TA, FUNDING_CA                
FROM FUNDING WHERE ROWNUM <= 2 * 20 ORDER BY FUNDING_END DESC, FUNDING_NO DESC)
WHERE rn > (2-1) * 20
ORDER BY FUNDING_END DESC, FUNDING_NO DESC        

UPDATE FUNDING SET FUNDING_CA = 1000000 WHERE FUNDING_TITLE = 'insert 테스트'
SET FUNDING_CA = 2000000;

SELECT * FROM FUNDING
--

-- EVENT
DROP SEQUENCE EVENTSEQ;
DROP TABLE EVENT;

CREATE SEQUENCE EVENTSEQ;
CREATE TABLE EVENT(
	EVENT_NO NUMBER PRIMARY KEY,
	EVENT_TITLE VARCHAR2(50) NOT NULL,
	EVENT_CONTENT LONG NOT NULL,
	EVENT_START VARCHAR2(50) NOT NULL,
	EVENT_END VARCHAR2(50) NOT NULL
);

INSERT INTO EVENT VALUES(EVENTSEQ.NEXTVAL, '페이징 테스트', '테스트', '2021-07-08', '2021-07-08');

SELECT * FROM EVENT;
--

-- CALENDAR
DROP SEQUENCE CALENDARSEQ;
DROP TABLE CALENDAR;

CREATE SEQUENCE CALENDARSEQ;
CREATE TABLE CALENDAR(
	CALENDAR_NO NUMBER PRIMARY KEY,
	CALENDAR_ID VARCHAR2(20) NOT NULL,
	CALENDAR_TITLE VARCHAR2(100) NOT NULL,
	CALENDAR_START VARCHAR2(50) NOT NULL,
	CALENDAR_END VARCHAR2(50) NOT NULL,
	FUNDING_NO NUMBER NOT NULL,
	EVENT_NO NUMBER NOT NULL,
	CONSTRAINT CAL_FK1 FOREIGN KEY(FUNDING_NO) REFERENCES FUNDING(FUNDING_NO) ON DELETE CASCADE,
	CONSTRAINT CAL_FK2 FOREIGN KEY(EVENT_NO) REFERENCES EVENT(EVENT_NO) ON DELETE CASCADE
);


SELECT * FROM CALENDAR;
--

-- PAYMENT
DROP SEQUENCE PAYMENTSEQ;
DROP TABLE PAYMENT;

CREATE SEQUENCE PAYMENTSEQ;
CREATE TABLE PAYMENT(
	PAY_NUM NUMBER PRIMARY KEY,
	PAY_PRODUCT VARCHAR2(50) NOT NULL,
	PAY_CATEGORY VARCHAR2(20) NOT NULL CHECK (PAY_CATEGORY IN ('상품판매', '회원거래', '펀딩')),
	PAY_STATUS VARCHAR2(20) NOT NULL CHECK (PAY_STATUS IN ('결제완료', '결제취소대기', '결제취소')),
	PAY_BUYER VARCHAR2(20) NOT NULL,
	PAY_PRODUCTER VARCHAR2(20) NOT NULL,
	PAY_DATE DATE NOT NULL,
	MEMBER_NO NUMBER NOT NULL,
	CONSTRAINT PAYMENT_FK FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO) ON DELETE CASCADE
);

SELECT * FROM PAYMENT;
--

-- MESSAGE
DROP SEQUENCE MESSAGESEQ;
DROP TABLE MESSAGE;

CREATE SEQUENCE MESSAGESEQ;
CREATE TABLE MESSAGE(
	MESSAGE_NO NUMBER PRIMARY KEY,	
	MESSAGE_SENDID VARCHAR2(20) NOT NULL,
	MESSAGE_RECVID VARCHAR2(20) NOT NULL,
	MESSAGE_CONTENT VARCHAR2(3000) NOT NULL,
	MESSAGE_SENDDATE DATE NOT NULL,
	MESSAGE_READDATE DATE,
	MESSAGE_TYPE VARCHAR2(20) NOT NULL,
	CONSTRAINT SENDID_FK FOREIGN KEY(MESSAGE_RECVID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE,
	CONSTRAINT RECVID_FK FOREIGN KEY(MESSAGE_SENDID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE
);

SELECT * FROM MESSAGE;

INSERT INTO MESSAGE VALUES (MESSAGESEQ.NEXTVAL, 'jihyeon', 'jihyeon', '시간 테스트', SYSDATE, SYSDATE, '발신');
INSERT INTO MESSAGE VALUES (MESSAGESEQ.NEXTVAL, 'jihyeon', 'jihyeon', '시간 테스트', SYSDATE, '9999-12-31', '수신');
INSERT INTO MESSAGE VALUES (MESSAGESEQ.NEXTVAL, 'jihyeon', 'jihyeon', '시간 테스트', SYSDATE, SYSDATE, '발신');
INSERT INTO MESSAGE VALUES (MESSAGESEQ.NEXTVAL, 'jihyeon', 'jihyeon', '시간 테스트', SYSDATE, '9999-12-31', '수신');
INSERT INTO MESSAGE VALUES (MESSAGESEQ.NEXTVAL, 'jihyeon', 'jihyeon', '시간 테스트', SYSDATE, SYSDATE, '발신');
INSERT INTO MESSAGE VALUES (MESSAGESEQ.NEXTVAL, 'jihyeon', 'jihyeon', '시간 테스트', SYSDATE, '9999-12-31', '수신');

SELECT MESSAGE_NO, MESSAGE_SENDID, MESSAGE_RECVID, MESSAGE_CONTENT, MESSAGE_SENDDATE, MESSAGE_READDATE, MESSAGE_TYPE, rn FROM 
(SELECT MESSAGE_NO, MESSAGE_SENDID, MESSAGE_RECVID, MESSAGE_CONTENT, MESSAGE_SENDDATE, MESSAGE_READDATE, MESSAGE_TYPE, ROW_NUMBER() OVER(ORDER BY MESSAGE_READDATE DESC, MESSAGE_NO DESC) AS rn FROM MESSAGE WHERE MESSAGE_TYPE='수신' AND MESSAGE_RECVID = 'jihyeon') msg 
WHERE rn BETWEEN 1 AND 10
ORDER BY MESSAGE_READDATE DESC, MESSAGE_NO DESC

SELECT MESSAGE_NO, MESSAGE_SENDID, MESSAGE_RECVID, MESSAGE_CONTENT, MESSAGE_SENDDATE, MESSAGE_READDATE, MESSAGE_TYPE, rn FROM 
(SELECT MESSAGE_NO, MESSAGE_SENDID, MESSAGE_RECVID, MESSAGE_CONTENT, MESSAGE_SENDDATE, MESSAGE_READDATE, MESSAGE_TYPE, ROW_NUMBER() OVER(ORDER BY MESSAGE_NO DESC) AS rn FROM MESSAGE WHERE MESSAGE_TYPE='발신' AND MESSAGE_SENDID = 'jihyeon') msg
WHERE rn BETWEEN 1 AND 10
ORDER BY MESSAGE_NO DESC 
 
-- CHATROOM
DROP SEQUENCE CHATROOMSEQ;
DROP TABLE CHATROOM;

CREATE SEQUENCE CHATROOMSEQ;
CREATE TABLE CHATROOM (
   CHAT_NO NUMBER NOT NULL,
   ROOM_ID VARCHAR2(1000) NOT NULL PRIMARY KEY,
   CREATOR_ID VARCHAR2(1000) NOT NULL,
   GUEST_ID VARCHAR2(1000) NOT NULL,
   CREATE_DATE DATE NOT NULL,
   MEMBER_NO NOT NULL,
   CONSTRAINT CHATROOM_FK FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO) ON DELETE CASCADE
);

SELECT * FROM CHATROOM;


-- CHATMESSAGE
DROP SEQUENCE CHARMESSAGESEQ;
DROP TABLE CHATMESSAGE;

CREATE SEQUENCE CHATMESSAGESEQ;
CREATE TABLE CHATMESSAGE (
   ROOM_SEQ NUMBER PRIMARY KEY,
   ROOM_ID VARCHAR2(1000) NOT NULL,
   FROM_ID VARCHAR2(1000) NOT NULL,
   TO_ID VARCHAR2(1000) NOT NULL,
   MESSAGE VARCHAR2(4000) NOT NULL,
   SEND_DATE DATE NOT NULL,
   CONSTRAINT CHATMESSAGE_FK FOREIGN KEY(ROOM_ID) REFERENCES CHATROOM(ROOM_ID) ON DELETE CASCADE
);


--
SELECT * FROM ALL_ALL_TABLES;