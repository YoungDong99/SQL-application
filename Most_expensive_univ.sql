/* 우리나라에서 대학 등록금이 가장 높은 학교 */


-- 대학별 입학금과 등록금 데이터를 입력하기 위한 테이블 생성
DROP TABLE UNIVERSITY_FEE;

CREATE TABLE UNIVERSITY_FEE
(DIVISION       VARCHAR2(20),
 TYPE           VARCHAR2(20),
 UNIVERSITY     VARCHAR2(60),
 LOC            VARCHAR2(40),
 ADMISSION_CNT  NUMBER(20),
 ADMISSION_FEE   NUMBER(20),
 TUITION_FEE      NUMBER(20) ) ;

-- 테이블에서 등록금이 가장 높은 학교 순으로 순위를 부여해 출력
 SELECT *
 FROM ( 
   SELECT UNIVERSITY, TUITION_FEE , 
             RANK() OVER (ORDER BY TUITION_FEE DESC NULLS LAST) 순위
      FROM UNIVERSITY_FEE
      )
 WHERE 순위 =1 ;

/*
    결과
    UNIVERSITY          UNITION_FEE   순위
    한국산업기술대학교    8995          1
*/

