/* 절도가 가장 많이 발생하는 요일 */


-- 범죄 발생 요일 데이터를 담기 위한 테이블 생성
CREATE TABLE CRIME_DAY
( CRIME_TYPE  VARCHAR2(50),
  SUN_CNT    NUMBER(10),
  MON_CNT   NUMBER(10),
  TUE_CNT    NUMBER(10),
  WED_CNT   NUMBER(10),
  THU_CNT    NUMBER(10),
  FRI_CNT     NUMBER(10),
  SAT_CNT    NUMBER(10),
  UNKNOWN_CNT  NUMBER(10) );

-- 특정 범죄가 많이 발생한 요일을 출력하기 용이하도록 unpivot문을 이용해 요일 컬럼을 로우로 검색한 데이터 테이블 생성
CREATE TABLE CRIME_DAY_UNPIVOT
 AS
 SELECT *
   FROM CRIME_DAY
   UNPIVOT ( CNT FOR  DAY_CNT  IN ( SUN_CNT, MON_CNT, TUE_CNT, WED_CNT,
   THU_CNT, FRI_CNT, SAT_CNT) );

-- crime_type이 절도 범죄로만 행을 제한하고 rank 함수를 이용해 건수가 가장 많은 순으로 순위 부여, 1순위 출력
SELECT *
  FROM ( 
         SELECT DAY_CNT, CNT, RANK() OVER (ORDER BY CNT DESC) RNK
           FROM CRIME_DAY_UNPIVOT
           WHERE TRIM(CRIME_TYPE)='절도'
       )
WHERE  RNK = 1;

-- 출력 결과 : 금요일

