-- ########## 11

-- Autoritatea nationala a cerut un raport cu numarul de retete mediu raportat la consultatii (La cate consultatii se acorda reteta compensata?).
-- Pentru a studia trendul, raportul trebuie sa fie grupat in functie de specializarea medicilor ce acorda reteta. 
-- De asemenea, rezultatul trebuie sa fie grupat in functie de pacient.alergic_la_anestezic
-- Raportul ia in considerare doar datele din ultimii 10 ani
SELECT NVL(grad_profesional,'Fara grad') grad_profesional,p.alergic_la_anestezic,ROUND(COUNT(r.id_reteta)/COUNT(c.id_consultatie),2), ms.nume_medic AS raport_retete_per_consult
FROM   medic_stomatolog_sen ms
JOIN pacient_sen p ON ms.id_medic = p.id_medic
Join reteta_sen r ON p.id_pacient = r.id_pacient
LEFT JOIN consultatie_sen c ON p.id_pacient = c.id_pacient
WHERE EXTRACT(YEAR FROM c.DATA_CONSULTATIE) IN (SELECT EXTRACT(YEAR FROM sysdate) - 10 + LEVEL FROM dual CONNECT BY LEVEL <= 10)
AND   EXTRACT(YEAR FROM NVL(r.DATA,sysdate)) IN (SELECT EXTRACT(YEAR FROM sysdate) - 10 + LEVEL FROM dual CONNECT BY LEVEL <= 10)
GROUP BY NVL(grad_profesional,'Fara grad'),p.alergic_la_anestezic, ms.nume_medic
ORDER BY 1,2;


-- rescriere interogare de mai sus pentru a nu repeta " (select extract(year from sysdate) - 10 + level from dual connect by level <= 10) ", folosind with

WITH years_drop_down_list AS (select extract(YEAR FROM sysdate) - 10 + LEVEL AS yr from dual CONNECT BY LEVEL <= 10)
SELECT NVL(grad_profesional,'Fara grad') grad_profesional,p.alergic_la_anestezic,ROUND(COUNT(r.id_reteta)/COUNT(c.id_consultatie),2) AS raport_retete_per_consult
FROM   medic_stomatolog_sen ms
JOIN pacient_sen p ON ms.id_medic = p.id_medic
LEFT JOIN reteta_sen r ON p.id_pacient = r.id_pacient
LEFT JOIN consultatie_sen c ON p.id_pacient = c.id_pacient
JOIN years_drop_down_list t ON EXTRACT(YEAR FROM c.DATA_CONSULTATIE) = t.yr
JOIN years_drop_down_list tt ON EXTRACT(YEAR FROM NVL(r.DATA,sysdate)) = tt.yr
GROUP BY NVL(grad_profesional,'Fara grad'),p.alergic_la_anestezic
ORDER BY 1,2;

--In incercarea de a identifica posibilele fraude, autoritatea nationala a cerut un raport cu medicii suspecti.
-- Se verifica top 3 medici ce ofera cele mai multe retete compensate. Apoi se verifica top 3 medici ce ofera cele mai multe concedii medicale.
-- Se vor calcula numarul de zile de cm oferite (un concediu de 2 zile = doua concedii de 1 zi)
-- Medicii care apar pe ambele liste vor fi afisati in raportul final
-- Obs: pentru ambele top-uri, se va folosi functia analitica RANK. De asemenea, daca avem 4 medici la egalitate, vor fi luati in considerare toti cei 4 medici.
-- La preferinta dezvoltatorului SQL, se poate folosi view-ul existent PACIENTI_DETALII_CONCEDII in interogare

SELECT id_medic,nume_medic,prenume_medic
FROM (
      SELECT id_medic,
             nume_medic,
             prenume_medic,
             RANK() OVER (ORDER BY zile_co_eliberate DESC) rnk_cm,
             RANK() OVER (ORDER BY cnt_retete DESC) rnk_retete
      FROM
          (
          SELECT id_medic,nume_medic,prenume_medic,SUM(nr_zile_co_luate_pana_in_prezent) AS zile_co_eliberate,SUM(cnt_retete) cnt_retete
          FROM (
                SELECT ms.id_medic,
                       ms.nume_medic,
                       ms.prenume_medic,
                       p.id_pacient,
                       pdc.nr_zile_co_luate_pana_in_prezent,
                       NVL(t.cnt,0) AS cnt_retete
                FROM   medic_stomatolog_sen ms
                JOIN   pacient_sen p ON ms.id_medic = p.id_medic
                JOIN   PACIENTI_DETALII_CONCEDII pdc ON p.id_pacient = pdc.id_pacient
                LEFT JOIN (SELECT id_pacient,COUNT(1) cnt FROM reteta_sen GROUP BY id_pacient) t ON p.id_pacient = t.id_pacient
          )
          GROUP BY id_medic,nume_medic,prenume_medic
      )
)
WHERE rnk_cm IN (1,2,3) AND rnk_retete IN (1,2,3);

-- O mare companie farmaceutica se pregateste sa lanseze un nou medicament.
-- Sa presupunem ca 
--   - Compania respectiva are acces la baza de date
--   - consideram ca numele medicamentului cantareste intr-o mica masura in alegerea medicului ce emite reteta
-- Afisati litera cu care incepe cel mai des intalnit medicament in retete. 
-- Folositi un CASE (cea mai des intalnita litera - 'FOARTE FOLOSIT', locul 2 - 'FOLOSIT', restul - 'EVITA'. Concatenati literele cu acelasi rank

SELECT outcome,
       LISTAGG(litera, ', ') WITHIN GROUP (ORDER BY NULL) AS letters
FROM (
      SELECT litera,
             CASE WHEN rnk = 1 THEN 'FOARTE FOLOSIT'
                  WHEN rnk = 2 THEN 'FOLOSIT'
                  ELSE 'EVITA'
             END AS outcome
      FROM (
             SELECT litera,cnt,RANK() OVER (ORDER BY cnt DESC) AS rnk
             FROM (
                   SELECT SUBSTR(LOWER(m.nume_medicament),1,1) litera,
                          COUNT(dr.ID_DETALII_RETETA) AS cnt
                   FROM   medicament_sen m
                   JOIN   detalii_reteta_sen dr ON M.id_medicament = dr.id_medicament
                   GROUP BY SUBSTR(LOWER(m.nume_medicament),1,1)
                   )
             )
      )
GROUP BY outcome;


-- ########## 12

-- S-a descoperit ca Dumitru Marian este alergic la anestezic. Actualizati fisa pacientului astfel incat sa reflecte acest lucru.

UPDATE pacient_sen
SET    ALERGIC_LA_ANESTEZIC = 'Y'
WHERE  nume_pacient = 'Dumitru'
AND    prenume_pacient = 'Marian';
-- Obs: In cazul in care exista mai multi pacienti Dumitru Marian se pot introduce date inconsistente. 
-- In acest caz, actualizarea trebuie realizata folosind cheia primara (id_pacient)

-- Medicul Iordache Darius a fost promovat pe postul de supervizor al tuturor rezidentilor. Actualizati baza de date in conformitate cu stirea.

UPDATE medic_stomatolog_sen
SET    id_superior_direct = (SELECT id_medic FROM medic_stomatolog_sen WHERE nume_medic = 'Iordache' AND prenume_medic = 'Darius')
WHERE  TRIM(LOWER(grad_profesional)) LIKE '%rezident%'
AND    id_medic != (SELECT id_medic FROM medic_stomatolog_sen WHERE nume_medic = 'Iordache' AND prenume_medic = 'Darius');


-- S-a observat ca anumiti medici au introdus gresit concediile medicale. 
-- Mai exact, au introdus data de start a concediului ca ziua in care pacientul a anuntat ca necesita CM. 
-- Corectati (daca exista) astfel de zile de start CM ce exista in weekend.

SELECT t.*, TO_CHAR(t.data_start,'DY') ds, TO_CHAR(t.data_end,'DY') de  FROM concediu_medical_sen t;

UPDATE concediu_medical_sen
SET    data_start = CASE WHEN TO_CHAR(data_start,'DY') = 'SAT' THEN data_start + 2
                         WHEN TO_CHAR(data_start,'DY') = 'SUN' THEN data_start + 1
                         ELSE data_start
                    END
WHERE TO_CHAR(data_start,'DY') IN ('SAT','SUN');



-- ########## 13
--S-a creat o secventa care a fost folosita in popularea tabelei de audit.
--DROP SEQUENCE istoric_pacient_seq_sen;
CREATE SEQUENCE istoric_pacient_seq_sen START WITH 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-- ########## 14

-- View-ul este un raport cu numarul de zile totale reale de concediu ale tuturor pacientilor, ordonate descrescator. 
-- Consideram zi de concediu reala o zi din timpul saptamanii (fara sambata, duminica), din timpul unui concediu medical. 
-- Sarbatorile legale nu sunt luate in considerare chiar daca pica in timpul saptamanii.

CREATE OR REPLACE VIEW pacienti_detalii_concedii
AS
SELECT id_pacient,nume_pacient || ' ' || prenume_pacient AS full_name,SUM(real_no_of_days_cm) AS nr_zile_co_luate_pana_in_prezent
FROM
(    SELECT p.id_pacient,
           p.nume_pacient,
           p.prenume_pacient,
           cm.id_concediu,
           cm.data_start,
           cm.data_end,
          (SELECT COUNT(*)
           FROM   DUAL
           WHERE  TO_CHAR(cm.data_start + LEVEL - 1, 'DY') NOT IN ('SAT', 'SUN')
           CONNECT BY LEVEL <= cm.data_end - cm.data_start + 1) AS Weekdays_cm,
          (SELECT COUNT(1)
           FROM   zi_libera_ro_sen
           WHERE  zi_libera BETWEEN cm.data_start AND cm.data_end) AS bank_holidays_in_cm,
          (SELECT COUNT(*)
           FROM   DUAL
           WHERE  TO_CHAR(cm.data_start + LEVEL - 1, 'DY') NOT IN ('SAT', 'SUN')
           CONNECT BY LEVEL <= cm.data_end - cm.data_start + 1) -
          (SELECT COUNT(1)
           FROM   zi_libera_ro_sen
           WHERE  zi_libera BETWEEN cm.data_start AND cm.data_end) AS real_no_of_days_cm     
    FROM   pacient_sen p
    LEFT JOIN concediu_medical_sen cm ON p.id_pacient = cm.id_pacient)
GROUP BY id_pacient,nume_pacient || ' ' || prenume_pacient
ORDER BY SUM(real_no_of_days_cm) DESC;

SELECT * FROM PACIENTI_DETALII_CONCEDII;


-- ########## 15
SELECT *
FROM medic_stomatolog_sen
WHERE grad_profesional IN ('primar','specialist');

--DROP INDEX idx_grad_prof;
CREATE INDEX idx_grad_prof ON medic_stomatolog_sen(grad_profesional);

-- ########## 16

-- OUTER JOIN 4 tabele
-- Cate consultatii s-au realizat in 2022, grupat pe Case de Asigurari?

SELECT ca.id_casa_asigurari,ca.nume_casa_asigurari,COUNT(c.id_consultatie) cnt
FROM   casa_asigurari_sen ca
LEFT JOIN medic_stomatolog_sen ms ON ca.id_casa_asigurari = ms.id_casa_asigurari
LEFT JOIN pacient_sen p ON ms.id_medic = p.id_medic
LEFT JOIN consultatie_sen c ON p.id_pacient = c.id_pacient
GROUP BY ca.id_casa_asigurari,ca.nume_casa_asigurari
ORDER BY 3 DESC;