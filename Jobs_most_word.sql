/* 스티브 잡스 연설문에서 가장 많이 나오는 단어 */

-- 스티브 잡스 연설문을 담기 위한 테이블 생성
CREATE TABLE SPEECH
( SPEECH_TEXT  VARCHAR2(1000) );

-- 데이터 입력 건수 확인 : 143 문장
SELECT count(*) FROM speech;

-- 문장을 어절 단위로 나누기
SELECT REGEXP_SUBSTR('I never graduated from college', '[^ ]+', 1, 2) word FROM dual;

/*
    REGEXP_SUBSTR : 정규표현식 함수 (좀 더 정교하게 문자열 추출 가능)
    '[^ ]+'  : 공백이 아니면서 철자가 여러 개가 있는 것을 뜻하는 것으로 문자열에서 어절을 의미
    문자열 바로 다음 숫자 1 : 첫 번째 어절부터라는 의미
    그 다음 숫자 2 : 두 번째 어절을 의미
    -> 첫 번째부터 읽어 두 번째로 만나는 어절을 출력하라는 것으로 단어 하나를 출력
*/

-- 연설문에서 가장 많이 나오는 단어를 알아내기 위해 어절로 잘라내기 작업
-- 가장 긴 어절 개수는 52개이므로 speech 테이블과 숫자 1부터 52까지 출력하는 숫자 집합과 
-- 조인 조건없이 전부 조인하면 143개의 문장을 모두 어절 단위로 출력한다.
SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
FROM speech,  ( SELECT level a
                       FROM dual
                       CONNECT BY level <= 52);

-- 어절 단위로 나눈 단어들을 카운트하여 가장 많이 나오는 단어순으로 정렬하는 쿼리  
SELECT word, count(*)
FROM ( SELECT REGEXP_SUBSTR(lower(speech_text), '[^ ]+', 1, a) word
           FROM speech,  ( SELECT level a
                                  FROM dual
                                  CONNECT BY level <= 52)
        )
WHERE word is not null
GROUP BY word
ORDER BY count(*) desc;
