--Cerin?e obligatorii pentru a lua în considerare proiectul:
--######################################################################################################################################################################
--######################################################################################################################################################################
--1. Prezenta?i pe scurt baza de date (utilitatea ei).
-- In aceasta baza de date simulam/modelam o baza de date folosita de CNAS (Casa Nationala de Asigurari de Sanatate) pentru cabinetele stomatologice ce au contracte cu diferite
-- case judetene.
--######################################################################################################################################################################
--2. Realiza?i diagrama entitate-rela?ie (ERD).
-- Am folosit DrawIO
--######################################################################################################################################################################
--3. Pornind de la diagrama entitate-rela?ie realiza?i diagrama conceptual? a modelului propus, integrând
--toate atributele necesare.
--Aceasta diagrama a fost determinata in Oracle SQL Developer.
--######################################################################################################################################################################
--4. Implementa?i în Oracle diagrama conceptual? realizat?: defini?i toate tabelele, implementând toate
--constrângerile de integritate necesare (chei primare, cheile externe etc).


/*
DROP TABLE detalii_reteta_sen;
DROP TABLE medicament_sen;
DROP TABLE reteta_sen;
DROP TABLE istoric_pacient_sen;
DROP TABLE pacient_sen;
DROP TABLE medic_stomatolog_sen;
DROP TABLE casa_asigurari_sen;
DROP TABLE audit_medicament_sen;
DROP TABLE test_ldd_sen; 
DROP TABLE ldd_audit_sen;
*/



/
CREATE TABLE casa_asigurari_sen (id_casa_asigurari NUMBER PRIMARY KEY,
                                 nume_casa_asigurari VARCHAR2(50));
/

CREATE TABLE medic_stomatolog_sen (id_medic NUMBER PRIMARY KEY,
                                  nume_medic VARCHAR2(50),
                                  prenume_medic VARCHAR2(50),
                                  specializare VARCHAR2(50),
                                  grad_profesional VARCHAR2(50),
                                  id_casa_asigurari NUMBER REFERENCES casa_asigurari_sen(id_casa_asigurari));
/

CREATE TABLE pacient_sen (id_pacient NUMBER PRIMARY KEY,
                         nume_pacient VARCHAR2(50),
                         prenume_pacient VARCHAR2(50),
                         alergic_la_anestezic VARCHAR2(1) DEFAULT 'N',
                         data_inscrierii DATE DEFAULT SYSDATE,
                         CONSTRAINT check_alergic_la_anestezic CHECK (alergic_la_anestezic IN ('Y','N')),
                         id_medic NUMBER REFERENCES medic_stomatolog_sen(id_medic));
/

CREATE TABLE istoric_pacient_sen(id_istoric NUMBER PRIMARY KEY, 
                                 id_medic NUMBER,
                                 id_pacient NUMBER,
                                 data_inscrierii DATE,
                                 data_plecarii DATE);
/

CREATE TABLE reteta_sen (id_reteta NUMBER PRIMARY KEY,
                         data DATE DEFAULT SYSDATE,
                         id_pacient NUMBER REFERENCES pacient_sen(id_pacient));
/

CREATE TABLE medicament_sen (id_medicament NUMBER PRIMARY KEY,
                             nume_medicament VARCHAR2(50),
                             reactii_adverse VARCHAR2(4000));
/

CREATE TABLE detalii_reteta_sen (id_detalii_reteta NUMBER PRIMARY KEY,
                                 id_reteta NUMBER REFERENCES reteta_sen(id_reteta),
                                 id_medicament NUMBER REFERENCES medicament_sen(id_medicament));

-- ######################################################################################################################################################################
--5. Ad?uga?i informa?ii coerente în tabelele create (minim 5 înregistr?ri pentru fiecare entitate
--independent?; minim 10 înregistr?ri pentru tabela asociativ?).

/
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (1, 'CASMB');   
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (2, 'OPSNAJ');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (3, 'CJASIS');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (4, 'CASALBA');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (5, 'CASAR');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (6, 'CASBC');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (7, 'CASBH');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (8, 'CASBN');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (9, 'CASBT');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (10, 'CASBR');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (11, 'CASBV');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (12, 'CASBZ');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (13, 'CASCL');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (14, 'CAS-CS');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (15, 'CASCLUJ');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (16, 'CASCT');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (17, 'CASCOV');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (18, 'CASDB');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (19, 'CASDJ');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (20, 'CASGL');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (21, 'CASGR');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (22, 'CASGORJ');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (23, 'CASHR');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (24, 'CASHD');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (25, 'CASIL');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (26, 'CASILFOV');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (27, 'CASMM');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (28, 'CASMH');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (29, 'CASMURES');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (30, 'CASNT');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (31, 'CASOT');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (32, 'CASPH');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (33, 'CASSALAJ');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (34, 'CASSAM');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (35, 'CASSB');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (36, 'CASSV');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (37, 'CASTR');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (38, 'CASNT');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (39, 'CJASTM');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (40, 'CASTL');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (41, 'CASVL');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (42, 'CJASVS');
INSERT INTO "CASA_ASIGURARI_SEN" (ID_CASA_ASIGURARI, NUME_CASA_ASIGURARI) VALUES (43, 'CASVN');

/
INSERT INTO "MEDICAMENT_SEN" (ID_MEDICAMENT, NUME_MEDICAMENT, REACTII_ADVERSE) VALUES (1, 'apirina', 'nu');
INSERT INTO "MEDICAMENT_SEN" (ID_MEDICAMENT, NUME_MEDICAMENT, REACTII_ADVERSE) VALUES (2, 'paracetamol', 'nu');
INSERT INTO "MEDICAMENT_SEN" (ID_MEDICAMENT, NUME_MEDICAMENT, REACTII_ADVERSE) VALUES (3, 'Nurofen', 'slabe');
INSERT INTO "MEDICAMENT_SEN" (ID_MEDICAMENT, NUME_MEDICAMENT, REACTII_ADVERSE) VALUES (4, 'Diclofenac', 'puternice');
INSERT INTO "MEDICAMENT_SEN" (ID_MEDICAMENT, NUME_MEDICAMENT, REACTII_ADVERSE) VALUES (5, 'Ibuprofen', 'medii');
INSERT INTO "MEDICAMENT_SEN" (ID_MEDICAMENT, NUME_MEDICAMENT, REACTII_ADVERSE) VALUES (6, 'Naproxen', 'nu');
INSERT INTO "MEDICAMENT_SEN" (ID_MEDICAMENT, NUME_MEDICAMENT, REACTII_ADVERSE) VALUES (7, 'Ketoprofen', 'combinatie cu aspirina');
INSERT INTO "MEDICAMENT_SEN" (ID_MEDICAMENT, NUME_MEDICAMENT, REACTII_ADVERSE) VALUES (8, 'Piroxicam', 'nu');
INSERT INTO "MEDICAMENT_SEN" (ID_MEDICAMENT, NUME_MEDICAMENT, REACTII_ADVERSE) VALUES (9, 'Oxicami', 'slabe');
INSERT INTO "MEDICAMENT_SEN" (ID_MEDICAMENT, NUME_MEDICAMENT, REACTII_ADVERSE) VALUES (10, 'Fenoxicam', 'medii');
INSERT INTO "MEDICAMENT_SEN" (ID_MEDICAMENT, NUME_MEDICAMENT, REACTII_ADVERSE) VALUES (11, 'Penicilina', 'slabe')

/
INSERT INTO "MEDIC_STOMATOLOG_SEN" (ID_MEDIC, NUME_MEDIC, PRENUME_MEDIC, SPECIALIZARE, GRAD_PROFESIONAL, ID_CASA_ASIGURARI) VALUES (1, 'Enache', 'Daniel', 'chirurgie maxilo faciala', 'rezident', 1);
INSERT INTO "MEDIC_STOMATOLOG_SEN" (ID_MEDIC, NUME_MEDIC, PRENUME_MEDIC, SPECIALIZARE, ID_CASA_ASIGURARI) VALUES (2, 'Grigore', 'Stefania', 'generalist', 2);
INSERT INTO "MEDIC_STOMATOLOG_SEN" (ID_MEDIC, NUME_MEDIC, PRENUME_MEDIC, SPECIALIZARE, GRAD_PROFESIONAL, ID_CASA_ASIGURARI) VALUES (3, 'Iordache', 'Darius', 'ortodontie', 'specialist', 3);
INSERT INTO "MEDIC_STOMATOLOG_SEN" (ID_MEDIC, NUME_MEDIC, PRENUME_MEDIC, SPECIALIZARE, GRAD_PROFESIONAL, ID_CASA_ASIGURARI) VALUES (4, 'Petre', 'Gabriela', 'endodontie', 'specialist', 1);
INSERT INTO "MEDIC_STOMATOLOG_SEN" (ID_MEDIC, NUME_MEDIC, PRENUME_MEDIC, SPECIALIZARE, GRAD_PROFESIONAL, ID_CASA_ASIGURARI) VALUES (5, 'Voicu', 'Cristian', 'pedodont', 'rezident', 2);
INSERT INTO "MEDIC_STOMATOLOG_SEN" (ID_MEDIC, NUME_MEDIC, PRENUME_MEDIC, SPECIALIZARE, GRAD_PROFESIONAL, ID_CASA_ASIGURARI) VALUES (6, 'Lupu', 'Daria', 'parodontolog', 'specialist', 3);
INSERT INTO "MEDIC_STOMATOLOG_SEN" (ID_MEDIC, NUME_MEDIC, PRENUME_MEDIC, SPECIALIZARE, ID_CASA_ASIGURARI) VALUES (7, 'Balan', 'Mihai', 'generalist', 1);
INSERT INTO "MEDIC_STOMATOLOG_SEN" (ID_MEDIC, NUME_MEDIC, PRENUME_MEDIC, SPECIALIZARE, GRAD_PROFESIONAL, ID_CASA_ASIGURARI) VALUES (8, 'Dobre', 'Antonia', 'ortodontie', 'primar', 1);
INSERT INTO "MEDIC_STOMATOLOG_SEN" (ID_MEDIC, NUME_MEDIC, PRENUME_MEDIC, SPECIALIZARE, ID_CASA_ASIGURARI) VALUES (9, 'Nicolae', 'Ionut', 'generalist', 1);
INSERT INTO "MEDIC_STOMATOLOG_SEN" (ID_MEDIC, NUME_MEDIC, PRENUME_MEDIC, SPECIALIZARE, GRAD_PROFESIONAL, ID_CASA_ASIGURARI) VALUES (10, 'Badea', 'Ana', 'chirurgie maxilo faciala', 'primar', 1);
INSERT INTO "MEDIC_STOMATOLOG_SEN" (ID_MEDIC, NUME_MEDIC, PRENUME_MEDIC, SPECIALIZARE, ID_CASA_ASIGURARI) VALUES (11, 'Lupu', 'Ioan', 'generalist', 1)

/
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (1,'Ionescu','Andrei','N',to_date('08-JAN-20','DD-MON-RR'),1);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (2,'Dumitru','Maria','N',to_date('22-MAR-16','DD-MON-RR'),2);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (3,'Stoica','David','N',to_date('05-MAY-21','DD-MON-RR'),3);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (4,'Stan','Andreea','N',to_date('05-JAN-16','DD-MON-RR'),4);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (5,'Gheorghe','Alexandru','Y',to_date('19-APR-19','DD-MON-RR'),5);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (6,'Rusu','Elena','N',to_date('17-JUL-19','DD-MON-RR'),6);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (7,'Munteanu','Gabriel','N',to_date('14-SEP-20','DD-MON-RR'),7);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (8,'Matei','Ioana','N',to_date('15-DEC-20','DD-MON-RR'),8);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (9,'Constantin','Stefan','N',to_date('03-OCT-19','DD-MON-RR'),9);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (10,'Moldovan','Alexandra','N',to_date('10-MAR-20','DD-MON-RR'),10);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (11,'Ionescu','Andreea','N',to_date('08-FEB-20','DD-MON-RR'),10);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (12,'Dumitru','Marian','N',to_date('22-APR-16','DD-MON-RR'),9);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (13,'Stoica','Aida','N',to_date('05-JUN-21','DD-MON-RR'),8);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (14,'Stan','Andrei','N',to_date('05-FEB-16','DD-MON-RR'),7);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (15,'Gheorghe','Alexandra','Y',to_date('19-MAY-19','DD-MON-RR'),6);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (16,'Rusu','Constantin','Y',to_date('17-AUG-19','DD-MON-RR'),5);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (17,'Munteanu','Gabriela','N',to_date('14-OCT-20','DD-MON-RR'),4);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (18,'Matei','Ioan','N',to_date('15-NOV-20','DD-MON-RR'),3);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (19,'Constantin','Stefania','N',to_date('03-NOV-19','DD-MON-RR'),2);
INSERT INTO PACIENT_SEN (ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC) VALUES (20,'Moldovan','Alexandru','N',to_date('10-APR-20','DD-MON-RR'),1);

/
INSERT INTO "RETETA_SEN" (ID_RETETA, DATA, ID_PACIENT) VALUES (1, TO_DATE('2020-01-07 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 1);
INSERT INTO "RETETA_SEN" (ID_RETETA, DATA, ID_PACIENT) VALUES (2, TO_DATE('2016-03-22 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 2);
INSERT INTO "RETETA_SEN" (ID_RETETA, DATA, ID_PACIENT) VALUES (3, TO_DATE('2021-05-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 3);
INSERT INTO "RETETA_SEN" (ID_RETETA, DATA, ID_PACIENT) VALUES (4, TO_DATE('2016-01-05 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 4);
INSERT INTO "RETETA_SEN" (ID_RETETA, DATA, ID_PACIENT) VALUES (5, TO_DATE('2019-04-19 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 5);
INSERT INTO "RETETA_SEN" (ID_RETETA, DATA, ID_PACIENT) VALUES (6, TO_DATE('2019-07-17 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 6);
INSERT INTO "RETETA_SEN" (ID_RETETA, DATA, ID_PACIENT) VALUES (7, TO_DATE('2020-09-14 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 7);
INSERT INTO "RETETA_SEN" (ID_RETETA, DATA, ID_PACIENT) VALUES (8, TO_DATE('2020-12-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 8);
INSERT INTO "RETETA_SEN" (ID_RETETA, DATA, ID_PACIENT) VALUES (9, TO_DATE('2019-10-03 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 9);
INSERT INTO "RETETA_SEN" (ID_RETETA, DATA, ID_PACIENT) VALUES (10, TO_DATE('2020-03-10 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 10);

/
INSERT INTO "DETALII_RETETA_SEN" (ID_DETALII_RETETA, ID_RETETA, ID_MEDICAMENT) VALUES (1, 1, 10);
INSERT INTO "DETALII_RETETA_SEN" (ID_DETALII_RETETA, ID_RETETA, ID_MEDICAMENT) VALUES (2, 2, 9);
INSERT INTO "DETALII_RETETA_SEN" (ID_DETALII_RETETA, ID_RETETA, ID_MEDICAMENT) VALUES (3, 3, 8);
INSERT INTO "DETALII_RETETA_SEN" (ID_DETALII_RETETA, ID_RETETA, ID_MEDICAMENT) VALUES (4, 4, 7);
INSERT INTO "DETALII_RETETA_SEN" (ID_DETALII_RETETA, ID_RETETA, ID_MEDICAMENT) VALUES (5, 5, 6);
INSERT INTO "DETALII_RETETA_SEN" (ID_DETALII_RETETA, ID_RETETA, ID_MEDICAMENT) VALUES (6, 6, 5);
INSERT INTO "DETALII_RETETA_SEN" (ID_DETALII_RETETA, ID_RETETA, ID_MEDICAMENT) VALUES (7, 7, 4);
INSERT INTO "DETALII_RETETA_SEN" (ID_DETALII_RETETA, ID_RETETA, ID_MEDICAMENT) VALUES (8, 8, 3);
INSERT INTO "DETALII_RETETA_SEN" (ID_DETALII_RETETA, ID_RETETA, ID_MEDICAMENT) VALUES (9, 9, 2);
INSERT INTO "DETALII_RETETA_SEN" (ID_DETALII_RETETA, ID_RETETA, ID_MEDICAMENT) VALUES (10, 10, 1);
INSERT INTO "DETALII_RETETA_SEN" (ID_DETALII_RETETA, ID_RETETA, ID_MEDICAMENT) VALUES (11, 10, 2);
INSERT INTO "DETALII_RETETA_SEN" (ID_DETALII_RETETA, ID_RETETA, ID_MEDICAMENT) VALUES (12, 10, 3);

-- ######################################################################################################################################################################
--6. Formula?i în limbaj natural o problem? pe care s? o rezolva?i folosind un subprogram stocat care s?
--utilizeze dou? tipuri de colec?ie studiate. Apela?i subprogramul.

--> Utilizand tablouri imbricate, afisati lista medicilor inscrisi in  baza de date. 
--Apoi, folosind tabele asociative, afisati lista medicamentelor inregistrate in baza de date.

SET SERVEROUTPUT ON
/

DECLARE
  TYPE refc IS REF CURSOR;
  cursor_medic refc;
  
  TYPE t_id IS TABLE OF NUMBER;
  TYPE t_full_name IS TABLE OF VARCHAR2(50);
  
  v_id_medic t_id;
  v_full_name_medic t_full_name;
  
  TYPE asoc_table_type IS TABLE OF VARCHAR2(200) INDEX BY BINARY_INTEGER;
  v_tab asoc_table_type;
  v_idx  NUMBER;
  
BEGIN
  -- folosind un tablou impricat afisam lista medicilor inregistrati in aplicatie
  OPEN  cursor_medic FOR 'SELECT id_medic, prenume_medic || '' '' || nume_medic 
                     AS full_name_medic 
                     FROM medic_stomatolog_sen
                     ORDER BY id_medic';
  FETCH cursor_medic BULK COLLECT INTO v_id_medic,v_full_name_medic;
  CLOSE cursor_medic;
  
  DBMS_OUTPUT.PUT_LINE('Lista medicilor:');
  FOR i IN v_id_medic.FIRST..v_id_medic.LAST
  LOOP
     DBMS_OUTPUT.PUT_LINE ('Medicul cu id-ul ' || v_id_medic(i)|| ' se numeste ' || v_full_name_medic(i));
  END LOOP;
  DBMS_OUTPUT.NEW_LINE;
  
  -- folosind o tabela asociativa afisam medicamentele inregistrate in aplicatie
  DBMS_OUTPUT.PUT_LINE ('Lista medicamentelor: ');
   FOR j IN (SELECT id_medicament, nume_medicament 
             FROM medicament_sen 
             ORDER BY id_medicament)
   -- incarcam tabela asociativa
   LOOP
     v_tab(j.id_medicament) := j.nume_medicament;
   END LOOP;
   -- arata pacienti
   v_idx := v_tab.FIRST;  
   WHILE v_idx IS NOT NULL
   LOOP
     DBMS_OUTPUT.PUT_LINE(v_tab(v_idx));
     v_idx := v_tab.NEXT(v_idx);
  END LOOP;  
  
END;
/

-- ######################################################################################################################################################################
--7. Formula?i în limbaj natural o problem? pe care s? o rezolva?i folosind un subprogram stocat care s?
--utilizeze un tip de cursor studiat. Apela?i subprogramul.

-->. Pentru fiecare medic inregistrat in aplicatie afisati numarul de pacienti cu alergii la anestezic
CREATE OR REPLACE PROCEDURE p_ex7_sen
IS
CURSOR c_medic_nr_alergici IS 
      SELECT id_medic,nume_medic,prenume_medic,
             COUNT(*) AS numar_alergici
             FROM  (SELECT m.id_medic,m.nume_medic,m.prenume_medic,p.id_pacient 
                    FROM   pacient_sen p, medic_stomatolog_sen m
                    WHERE  p.id_medic = m.id_medic
                    AND    p.alergic_la_anestezic = 'Y')
             GROUP BY id_medic,nume_medic,prenume_medic;
BEGIN
FOR i IN c_medic_nr_alergici
LOOP
    DBMS_OUTPUT.PUT_LINE('Medicul ' || i.nume_medic || ' ' || i.prenume_medic || ' are ' || i.numar_alergici || ' pacienti alergici la anestezic.');
END LOOP;
END p_ex7_sen;
/

--apelarea procedurii p_ex7_sen
SET SERVEROUTPUT ON
BEGIN
  p_ex7_sen;
END;
/


-- ######################################################################################################################################################################
--8. Formula?i în limbaj natural o problem? pe care s? o rezolva?i folosind un subprogram stocat de tip
--func?ie care s? utilizeze într-o singur? comand? SQL 3 dintre tabelele definite. Trata?i toate excep?iile
--care pot ap?rea. Apela?i subprogramul astfel încât s? eviden?ia?i toate cazurile tratate.

--> Realizati o functie care sa intoarca numarul de retete emise pentru o casa de asigurari data ca parametru;

CREATE OR REPLACE FUNCTION f_ex8_sen (p_nume_casa_asigurari IN VARCHAR2)
RETURN NUMBER
IS
  v_id NUMBER;
  v_result NUMBER;
  --
  v_cnt NUMBER;
  v_exception EXCEPTION;
BEGIN

  SELECT COUNT(1)
  INTO   v_cnt
  FROM   casa_asigurari_sen
  WHERE  nume_casa_asigurari = p_nume_casa_asigurari;
  
  IF v_cnt = 0
  THEN
    RAISE v_exception;
  END IF;

  SELECT id_casa_asigurari,
         COUNT(*) AS nr_retete
  INTO   v_id,v_result
  FROM  (SELECT ca.id_casa_asigurari,ca.nume_casa_asigurari,r.id_reteta
         FROM   casa_asigurari_sen ca,
                pacient_sen p,
                medic_stomatolog_sen m,
                reteta_sen r
         WHERE  ca.id_casa_asigurari = m.id_casa_asigurari
         AND    p.id_medic = m.id_medic
         AND    p.id_pacient = r.id_pacient
         AND    ca.nume_casa_asigurari = p_nume_casa_asigurari)
  GROUP BY id_casa_asigurari;

RETURN v_result;
EXCEPTION
WHEN v_exception
THEN
  RETURN -1;
WHEN no_data_found 
THEN
  RETURN 0;
END f_ex8_sen;

--apelarea functiei f_ex8_sen
BEGIN
  DBMS_OUTPUT.PUT_LINE(f_ex8_sen('CASMB')); -- exista, are retete
  DBMS_OUTPUT.PUT_LINE(f_ex8_sen('OPSNAJ')); -- exista, nu are retete
  DBMS_OUTPUT.PUT_LINE(f_ex8_sen('CASMBBBBB')); -- nu exista
END;
/

-- ######################################################################################################################################################################
--9. Formula?i în limbaj natural o problem? pe care s? o rezolva?i folosind un subprogram stocat de tip
--procedur? care s? utilizeze într-o singur? comand? SQL 5 dintre tabelele definite. Trata?i toate
--excep?iile care pot ap?rea, incluzând excep?iile NO_DATA_FOUND ?i TOO_MANY_ROWS. Apela?i
--subprogramul astfel încât s? eviden?ia?i toate cazurile tratate.

--> Realizati o procedura care sa afiseze medicamentele recomandate de un medic al carui nume de familie este dat ca parametru,
--  afisate in ordinea preferintei;
CREATE OR REPLACE PROCEDURE p_ex9_sen(p_nume_medic IN VARCHAR2)
IS
  v_id_medic NUMBER;
BEGIN

SELECT id_medic
INTO   v_id_medic
FROM   medic_stomatolog_sen
WHERE  nume_medic = p_nume_medic;

DBMS_OUTPUT.PUT_LINE('Medicul ' || p_nume_medic || ' are id-ul ' || v_id_medic || '.');

FOR i IN (SELECT id_medic,nume_medicament,
          COUNT(*) nr_utilizari_in_retete
          FROM  (SELECT m.id_medic,p.id_pacient,med.nume_medicament
                 FROM   medic_stomatolog_sen m,
                        pacient_sen p,
                        reteta_sen r,
                        detalii_reteta_sen dr,
                        medicament_sen med
                 WHERE  p.id_medic = m.id_medic
                 AND    p.id_pacient = r.id_pacient
                 AND    r.id_reteta = dr.id_reteta
                 AND    dr.id_medicament = med.id_medicament
                 AND    p.id_medic = v_id_medic)
          GROUP BY id_medic,nume_medicament
          ORDER BY 1,3 DESC)
  LOOP
      DBMS_OUTPUT.PUT_LINE(i.nume_medicament || ' a fost recomandat de ' || i.nr_utilizari_in_retete || ' ori.');
  END LOOP;
  
EXCEPTION
WHEN NO_DATA_FOUND
        THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista');
WHEN TOO_MANY_ROWS
        THEN
            DBMS_OUTPUT.PUT_LINE('Mai multi medici cu acelasi nume');
END p_ex9_sen;
/

--apelarea prcedurii p_ex9_sen
BEGIN
  p_ex9_sen('Andrei');
  p_ex9_sen('Lupu');

END; 
/

-- ######################################################################################################################################################################
--10. Defini?i un trigger de tip LMD la nivel de comand?. Declan?a?i trigger-ul.
--> Vom dezvolta un trigger care sa auditeze momentul in timp in care lista de medicamente aprobata s-a schimbat. 
--  Fie ca se introduc multiple medicamente noi, se sterg sau se actualizeaza inregistrari existente 
--  (ex: apar noi efecte adverse), vom audita modificarea intr-o tabela dedicata

-- cream tabela dedicata
CREATE TABLE audit_medicament_sen(data_actualizarii DATE,
                              observatii VARCHAR2(200));
/

CREATE OR REPLACE TRIGGER trg_audit_medicament_sen
AFTER INSERT OR UPDATE OR DELETE-- operatii LMD
ON medicament_sen
--FOR EACH ROW
BEGIN
    IF INSERTING THEN
      INSERT INTO audit_medicament_sen(data_actualizarii,observatii)  VALUES(SYSDATE,'Lista cu medicament(e) nou/(i).');
    ELSIF UPDATING THEN 
      INSERT INTO audit_medicament_sen(data_actualizarii,observatii)  VALUES(SYSDATE,'Lista actualizata.');
    ELSIF DELETING THEN
      INSERT INTO audit_medicament_sen(data_actualizarii,observatii)  VALUES(SYSDATE,'Lista cu medicament(e) retras(e).');
    END IF;
END;

--CREATE SEQUENCE seq_medicament_sen START WITH 12 INCREMENT BY 1 NOCACHE NOCYCLE;
-- inseram 3 noi medicamente
INSERT INTO medicament_sen(ID_MEDICAMENT,NUME_MEDICAMENT,REACTII_ADVERSE) VALUES (seq_medicament_sen.NEXTVAL,'Ibuprofen Maxi',NULL);
INSERT INTO medicament_sen(ID_MEDICAMENT,NUME_MEDICAMENT,REACTII_ADVERSE) VALUES (seq_medicament_sen.NEXTVAL,'Nurofen Plus',NULL);
INSERT INTO medicament_sen(ID_MEDICAMENT,NUME_MEDICAMENT,REACTII_ADVERSE) VALUES (seq_medicament_sen.NEXTVAL,'Vitamina B6',NULL);

-- verificam tabela de audit
SELECT * FROM audit_medicament_sen;
-- 3 noi inregistrari

-- stergem medicamentele
DELETE FROM medicament_sen WHERE id_medicament IN(11,12,13);

-- verificam tabela de audit
SELECT * FROM audit_medicament_sen;
-- 1 noua inregistrare desi am sters 3 medicamente
-- Ca proba, am putea recrea trigger-ul, adaugand sintaxa "FOR EACH ROW". (triggerul va fi la nivel de linie, in loc de comanda)
-- Repetand actiunile de mai sus, observam ca in varianta ce contine "FOR EACH ROW", 
-- la stergerea a 3 inregistrari din medicament_sen, trigger-ul se declanseaza de 3 ori. 
-- Fara aceasta sintaxa, trigger-ul este declansat o singura data.


-- ######################################################################################################################################################################
--> 11. Defini?i un trigger de tip LMD la nivel de linie. Declan?a?i trigger-ul.
--Trigger ce populeaza istoric_pacienti_sen

--CREATE SEQUENCE istoric_pacient_seq_sen START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE OR REPLACE TRIGGER trg_audit_pacient_history_sen
  AFTER INSERT OR UPDATE OR DELETE
  ON pacient_sen
  FOR EACH ROW
BEGIN
  IF INSERTING 
        -- La introducerea unui nou pacient in aplicatie, informatiile acestuia vor fi inregistrare in tabela de audit, 
        --cu data_inscrierii = acum si data_plecarii NULL
    THEN          
        INSERT INTO istoric_pacient_sen(id_istoric,id_medic,id_pacient,data_inscrierii,data_plecarii)
        VALUES (istoric_pacient_seq_sen.NEXTVAL, :NEW.id_medic, :NEW.id_pacient, SYSDATE,NULL);
  ELSIF UPDATING
    -- Daca datele unui pacient sunt actualizate, mai precis se schimba medicul (id_medic), atunci:
    THEN
    IF :NEW.id_medic <> :OLD.id_medic
       THEN
         -- 1. vom actualiza inregistrarea existenta in tabela de audit de la inscrierea pacientului respectiv: vom actualiza data_plecarii cu acum
        UPDATE istoric_pacient_sen
        SET    data_plecarii = sysdate
        WHERE  id_pacient = :OLD.id_pacient -- old / new, nu prea conteaza, cheia primara nu se schimba niciodata. e la fel si inainte si dupa update
        AND    id_medic = :OLD.id_medic
        AND    data_plecarii IS NULL;
      
         -- 2. vom introduce o noua inregistrare in tabela de audit cu data_inscrierii = acum, care sa reflecte relatia pacientului cu noul medic
         INSERT INTO istoric_pacient_sen(id_istoric,id_medic,id_pacient,data_inscrierii,data_plecarii)
         VALUES (istoric_pacient_seq_sen.NEXTVAL,:NEW.id_medic,:NEW.id_pacient,sysdate,NULL);
    END IF;
  ELSIF DELETING
    THEN
    -- In cazul in care un pacient este sters din baza de date, consideram ca a plecat de la medicul actual. 
    -- La momentul stergerii inregistrarii din tabela, vom actualiza si inregistrarea de audit, mai precis, completam campul data_plecarii
    UPDATE istoric_pacient_sen
    SET    data_plecarii = SYSDATE
    WHERE  id_medic = :OLD.id_medic
    AND    id_pacient = :OLD.id_pacient
    AND    data_plecarii IS NULL;
  END IF;
END;
/
-- ##### Verificare trigger trg_audit_pacient_history_sen
--CREATE SEQUENCE pacient_seq_sen START WITH 21 INCREMENT BY 1 NOCACHE NOCYCLE;

-- Inregistram un nou pacient
INSERT INTO pacient_sen(ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC)
VALUES (pacient_seq_sen.NEXTVAL,'Magda','Calin','N',SYSDATE,1);

-- Verificam istoricul
SELECT * FROM istoric_pacient_sen;
-- pacientul a fost inregistrat in audit

-- Mutam pacientul nou la alt medic
UPDATE pacient_sen SET id_medic = 2 WHERE nume_pacient ='Magda' AND prenume_pacient= 'Calin';

-- Verificam istoricul
SELECT * FROM istoric_pacient_sen;
-- inregistrarea initiala este actualizata. Campul data_plecarii este populat cu ACUM. 
--De asemenea, avem o noua inregistrare ce reflecta legatura noua dintre medicul 2 si pacientul in cauza.

-- stergem pacientul
DELETE FROM pacient_sen WHERE  nume_pacient ='Magda' AND prenume_pacient= 'Calin';

-- Verificam istoricul
SELECT * FROM istoric_pacient_sen;
-- Inregistrarea deschisa este actualizata. Campul data_plecarii este populat cu ACUM.

-- Testul 2: introducem un nou pacient, pe care il stergem direct

INSERT INTO pacient_sen(ID_PACIENT,NUME_PACIENT,PRENUME_PACIENT,ALERGIC_LA_ANESTEZIC,DATA_INSCRIERII,ID_MEDIC)
VALUES (pacient_seq_sen.NEXTVAL,'Mircea','Radu','N',SYSDATE,1);

SELECT * FROM istoric_pacient_sen;

DELETE FROM pacient_sen WHERE nume_pacient ='Mircea' AND prenume_pacient='Radu';

SELECT * FROM istoric_pacient_sen;


-- ######################################################################################################################################################################
-- 12. Defini?i un trigger de tip LDD. Declan?a?i trigger-ul.
--> Un trigger care sa auditeze operatiile LDD din schema curenta

DROP TABLE ldd_audit_sen;
CREATE TABLE ldd_audit_sen  (ldd_date       DATE,
                         ldd_user       VARCHAR2(30),
                         object_created VARCHAR2(30),
                         object_name    VARCHAR2(30),
                         ldd_operation  VARCHAR2(30));


CREATE OR REPLACE TRIGGER trg_audit_ldd_sen 
AFTER DDL ON SCHEMA
BEGIN
    INSERT INTO ldd_audit_sen VALUES(SYSDATE, 
                                 SYS_CONTEXT('USERENV','CURRENT_USER'), 
                                 ORA_DICT_OBJ_TYPE, 
                                 ORA_DICT_OBJ_NAME, 
                                 ORA_SYSEVENT);
END;
/

-- verificare
-- Realizam o operatie LDD pentru declansarea trigger-ului
CREATE TABLE test_ldd_sen (col1 NUMBER);

-- verificam rezultatul
SELECT * FROM ldd_audit_sen;
DROP TRIGGER trg_audit_ldd_sen;

-- ######################################################################################################################################################################
--13. Defini?i un pachet care s? con?in? toate obiectele definite în cadrul proiectului.

CREATE OR REPLACE PACKAGE pachet_stoma_sen
AS
  PROCEDURE p_ex7_sen;
  FUNCTION f_ex8_sen (p_nume_casa_asigurari in VARCHAR2) RETURN NUMBER;
  PROCEDURE p_ex9_sen(p_nume_medic IN VARCHAR2);
END pachet_stoma_sen;
/

CREATE OR REPLACE PACKAGE BODY pachet_stoma_sen
AS
  ---------------------------------
  PROCEDURE p_ex7_sen IS
    CURSOR c_medic_nr_alergici IS 
        SELECT id_medic,nume_medic,prenume_medic,
        COUNT(*) AS numar_alergici
        FROM  (SELECT m.id_medic,m.nume_medic,m.prenume_medic,p.id_pacient 
               FROM   pacient_sen p,
                      medic_stomatolog_sen m
               WHERE  p.id_medic = m.id_medic
               AND    p.alergic_la_anestezic = 'Y')
        GROUP BY id_medic,nume_medic,prenume_medic;
  BEGIN
    FOR i IN c_medic_nr_alergici
         LOOP
             DBMS_OUTPUT.PUT_LINE('Medicul ' || i.nume_medic || ' ' || i.prenume_medic || ' are ' || i.numar_alergici || ' pacienti alergici la anestezic.');
        END LOOP;
  END p_ex7_sen;
  ---------------------------------
  FUNCTION f_ex8_sen (p_nume_casa_asigurari IN VARCHAR2)
  RETURN NUMBER
  IS
    v_id NUMBER;
    v_result NUMBER;
    --
    v_cnt NUMBER;
    v_exception EXCEPTION;
  BEGIN
    SELECT COUNT(1)
    INTO   v_cnt
    FROM   casa_asigurari_sen
    WHERE  nume_casa_asigurari = p_nume_casa_asigurari;
    IF v_cnt = 0
    THEN
        RAISE v_exception;
    END IF;

    SELECT id_casa_asigurari,
    COUNT(*) AS nr_retete
    INTO   v_id,v_result
    FROM  (SELECT ca.id_casa_asigurari,ca.nume_casa_asigurari,r.id_reteta
           FROM   casa_asigurari_sen ca,
                  pacient_sen p,
                  medic_stomatolog_sen m,
                  reteta_sen r
           WHERE  ca.id_casa_asigurari = m.id_casa_asigurari
           AND    p.id_medic = m.id_medic
           AND    p.id_pacient = r.id_pacient
           AND    ca.nume_casa_asigurari = p_nume_casa_asigurari)
    GROUP BY id_casa_asigurari;
  RETURN v_result;
  
  EXCEPTION
  WHEN V_EXCEPTION
     THEN
        RETURN -1;
  WHEN NO_DATA_FOUND 
    THEN
        RETURN 0;
  END f_ex8_sen;
  ---------------------------------
  PROCEDURE p_ex9_sen(p_nume_medic IN VARCHAR2)
  IS
    v_id_medic NUMBER;
  BEGIN
  
  SELECT id_medic
  INTO   v_id_medic
  FROM   medic_stomatolog_sen
  WHERE  nume_medic = p_nume_medic;
  
  DBMS_OUTPUT.PUT_LINE('Medicul ' || p_nume_medic || ' are id-ul ' || v_id_medic);
  
  FOR i IN (SELECT id_medic,nume_medicament,
            COUNT(*) nr_utilizari_in_retete
            FROM  (SELECT m.id_medic,p.id_pacient,med.nume_medicament
                   FROM   medic_stomatolog_sen m,
                          pacient_sen p,
                          reteta_sen r,
                          detalii_reteta_sen dr,
                          medicament_sen med
                   WHERE  p.id_medic = m.id_medic
                   AND    p.id_pacient = r.id_pacient
                   AND    r.id_reteta = dr.id_reteta
                   AND    dr.id_medicament = med.id_medicament
                   AND    p.id_medic = v_id_medic)
            GROUP BY id_medic, nume_medicament
            ORDER BY 1,3 desc)
      LOOP
          DBMS_OUTPUT.PUT_LINE(i.nume_medicament || ' a fost recomandat de ' || i.nr_utilizari_in_retete || ' ori.');
      END LOOP;  
  END p_ex9_sen;
  ---------------------------------
END pachet_stoma_sen;
/

-- ######################################################################################################################################################################
-- 14. Defini?i un pachet care s? includ? tipuri de date complexe ?i obiecte necesare unui flux de ac?iuni
-- integrate, specifice bazei de date definite (minim 2 tipuri de date, minim 2 func?ii, minim 2 proceduri).
-->  Functie care sa verifice daca tabelul de audit exista deja, procedura care sa creeze tabelul de audit daca nu a fost deja creat,
-- functie care sa determine daca reportul de audit a fost generat pentru anul curent, procedura ce ruleaza operatiunile definite mai sus,
-- procedura ce ce arata continutul raportului.
CREATE OR REPLACE PACKAGE pkg_flux_sen
IS
 
  FUNCTION table_already_exists RETURN BOOLEAN;  
  PROCEDURE create_audit_table(p_table_not_yet_created IN BOOLEAN);
  FUNCTION report_ran_this_year RETURN BOOLEAN;
  PROCEDURE run_report;
  PROCEDURE display_report(p_year IN NUMBER DEFAULT EXTRACT(YEAR FROM SYSDATE));
  
END pkg_flux_sen;
/
------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY pkg_flux_sen
IS
    ------------------------------------------------------------
  FUNCTION table_already_exists
  RETURN BOOLEAN
  IS
    v_cnt NUMBER := 0;
    v_ret BOOLEAN;
  BEGIN
    SELECT COUNT(*)
    INTO   v_cnt
    FROM   USER_TABLES
    WHERE  table_name = 'audit_flux_sen';
  
    IF v_cnt > 0
    THEN
        v_ret := TRUE;
    END IF;

    RETURN v_ret;
  
  END table_already_exists;
  
  
    ------------------------------------------------------------
  PROCEDURE create_audit_table(p_table_not_yet_created IN BOOLEAN)
  IS
  BEGIN
  
    IF NOT(table_already_exists)
    THEN
      EXECUTE IMMEDIATE 'CREATE TABLE audit_flux_sen(an_raport NUMBER,data_rularii DATE,total_medici NUMBER,total_pacienti NUMBER,total_medicamente NUMBER,total_retete NUMBER)';    
    END IF;
  
  END create_audit_table;
    ------------------------------------------------------------
  FUNCTION report_ran_this_year RETURN BOOLEAN
  --ca sa nu apara de doua ori acelasi raport/sa fie modificat
  IS
    v_year NUMBER;
    v_ret BOOLEAN DEFAULT FALSE;
  BEGIN
    IF table_already_exists
    THEN
      EXECUTE IMMEDIATE 'SELECT MAX(an_raport) FROM audit_flux_sen' INTO v_year;
      IF v_year = EXTRACT(YEAR FROM SYSDATE)
      THEN
        v_ret := TRUE;
      END IF;
    END IF;
    
    RETURN v_ret;
    
  END report_ran_this_year;
    ------------------------------------------------------------

  PROCEDURE run_report
  IS
    TYPE audit_rec IS RECORD(an_raport NUMBER, 
                             data_rularii DATE,
                             total_medici NUMBER,
                             total_pacienti NUMBER,
                             total_medicamente NUMBER,
                             total_retete NUMBER);
    
    v_audit_rec audit_rec;
  BEGIN
  
    create_audit_table(table_already_exists);
    IF NOT(report_ran_this_year)
    THEN
      SELECT EXTRACT(YEAR FROM SYSDATE) AS an,
             SYSDATE data_raport,
             (SELECT COUNT(*) FROM medic_stomatolog_sen) cnt_medic,
             (SELECT COUNT(*) FROM pacient_sen) cnt_pacient,
             (SELECT COUNT(*) FROM medicament_sen) cnt_medicament,
             (SELECT COUNT(*) FROM reteta_sen) cnt_reteta
      INTO   v_audit_rec.an_raport,
             v_audit_rec.data_rularii,
             v_audit_rec.total_medici,
             v_audit_rec.total_pacienti,
             v_audit_rec.total_medicamente,
             v_audit_rec.total_retete
      FROM   DUAL;
    
      EXECUTE IMMEDIATE 'INSERT INTO audit_flux_sen(an_raport,data_rularii,total_medici,total_pacienti,total_medicamente,total_retete) 
                        VALUES (' || v_audit_rec.an_raport || ',' ||
                         'SYSDATE,' ||
                         v_audit_rec.total_medici || ',' ||
                         v_audit_rec.total_pacienti || ',' ||
                         v_audit_rec.total_medicamente || ',' ||
                         v_audit_rec.total_retete || ')';
                         DBMS_OUTPUT.PUT_LINE('Raportul s-a rulat cu succes!');
      COMMIT;
    END IF;  
  END;
  
  ------------------------------------------------------------
  PROCEDURE display_report(p_year IN NUMBER DEFAULT EXTRACT(YEAR FROM SYSDATE))
  IS
    v_an_raport NUMBER;
    v_data_rularii DATE;
    v_total_medici NUMBER;
    v_total_pacienti NUMBER;
    v_total_medicamente NUMBER;
    v_total_retete NUMBER;
  
  BEGIN
    IF report_ran_this_year
    THEN
      EXECUTE IMMEDIATE 'SELECT an_raport, data_rularii, total_medici, total_pacienti, total_medicamente, total_retete FROM audit_flux_sen WHERE an_raport = 2022'
      INTO    v_an_raport,
              v_data_rularii,
              v_total_medici,
              v_total_pacienti,
              v_total_medicamente,
              v_total_retete;
    
      DBMS_OUTPUT.PUT_LINE('Raportul pentru anul ' || v_an_raport || ' este urmatorul:');
      DBMS_OUTPUT.PUT_LINE('Numar total medici ' || v_total_medici);
      DBMS_OUTPUT.PUT_LINE('Numar total pacienti ' || v_total_pacienti);
      DBMS_OUTPUT.PUT_LINE('Numar total medicamente ' || v_total_medicamente);
      DBMS_OUTPUT.PUT_LINE('Numar total retete ' || v_total_retete);
    END IF;
  END;

END pkg_flux_sen;
/
------------------------------------------------------------
BEGIN
  pkg_flux_sen.run_report;
END;

SELECT * FROM audit_flux_sen;

BEGIN
  pkg_flux_sen.display_report;
END;



--################################################   END    #############################################################################################################