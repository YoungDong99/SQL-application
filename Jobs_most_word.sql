/* 스티브 잡스 연설문에서 가장 많이 나오는 단어 */

-- 스티브 잡스 연설문을 담기 위한 테이블 생성
CREATE TABLE SPEECH
( SPEECH_TEXT  VARCHAR2(1000) );

-- 데이터 입력 건수 확인 : 143 문장
SELECT count(*) FROM speech;

-- 문장을 어절 단위로 나누기
SELECT REGEXP_SUBSTR('I never graduated from college', '[^ ]+', 1, 2) word FROM dual;


SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
FROM speech,  ( SELECT level a
                       FROM dual
                       CONNECT BY level <= 52);
                       
SELECT word, count(*)
FROM ( SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
           FROM speech,  ( SELECT level a
                                  FROM dual
                                  CONNECT BY level <= 52)
        )
WHERE word is not null
GROUP BY word
ORDER BY count(*) desc;
