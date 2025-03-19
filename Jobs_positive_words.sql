/* 스티브 잡스 연설문에는 긍정 단어가 많은가 부정 단어가 많은가 */


-- 긍정, 부정 단어들을 입력하기 위한 테이블 생성
CREATE TABLE POSITIVE ( P_NEXT  VARCHAR2(2000) );
CREATE TABLE NEGATIVE ( N_NEXT  VARCHAR2(2000) );


/* 단어를 잘라내는 뷰 생성 */
CREATE VIEW SPEECH_VIEW
AS
SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
        FROM speech, ( SELECT level a
                                  FROM dual
                                  CONNECT BY level <= 52);


-- 긍정 단어의 개수 출력
SELECT count(word) as "긍정 단어"
    FROM speech_view
    WHERE word IS NOT NULL AND lower(word) IN ( SELECT lower(p_next)
                                        FROM positive );


-- 부정 단어의 개수 출력
SELECT count(word) as "부정 단어"
    FROM speech_view
    WHERE word IS NOT NULL AND lower(word) IN ( SELECT lower(n_next)
                                        FROM negative );

-- 결과 : 긍정 단어가 부정 단어보다 2배 이상 많이 사용되고 있음






