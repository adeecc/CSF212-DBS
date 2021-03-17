-- LAB SOLUTIONS FOR 
-- PARTS AND VENDORS
-- MDADE IN: LAB

-- Problem 1
SELECT p.pid, p.pname from part p
WHERE P.pid NOT IN (
    SELECT s.pid FROM supply s
);


-- Problem 2
SELECT p.pid, p.pname FROM part p, supply s, vendor v
WHERE p.pid = s.pid AND v.vid = s.vid AND vloc = 'Delhi'
GROUP BY p.pid, p.pname
HAVING COUNT(*) = (SELECT COUNT(*) FROM vendor WHERE vloc = 'Delhi'); -- This line required since it must be supplied by all vendors from delhi

SELECT p.pid, p.pname FROM part p
WHERE NOT EXISTS ((
    SELECT v.vid FROM vendor v WHERE v.vloc = 'Delhi')
    MINUS (SELECT s.vid FROM supply s where s.pid = p.pid));

-- Problem 3
SELECT v.vid, v.vname FROM vendor v
WHERE v.vloc='Delhi' AND v.vid IN (
    SELECT s.vid FROM supply s GROUP BY s.vid HAVING COUNT(s.vid) > 2
);

-- Problem 4
SELECT v.vid, v.vname 
FROM vendor v
WHERE v.vid IN (
    (SELECT v.vid FROM vendor v)
    MINUS
    (
        SELECT v.vid FROM vendor v, supply s, part p
        WHERE v.vid = s.vid AND s.pid = p.pid AND p.price > 100
    )
);

-- Alternate

SELECT v.vid, v.vname FROM vendor v
MINUS (
    SELECT v.vid, v.vname FROM vendor v, supply s, part p
    WHERE v.vid = s.vid AND s.pid = p.pid AND p.price > 100);

-- Problem 5

-- Does not give 0 for parts not being supplied
SELECT p.pid, p.pname, COUNT(*)
FROM part p, supply s, vendor v
WHERE p.pid = s.pid AND v.vid = s.vid AND vloc='Chennai'
GROUP BY p.pid, p.pname;


-- Alternative
SELECT p.pid, p.pname, COUNT(s.pid)
FROM part p
    LEFT JOIN (
        SELECT s.pid
        FROM supply s, vendor v
        WHERE s.vid = v.vid AND v.vloc = 'Chennai'
        ) s
    ON p.pid = s.pid
GROUP BY p.pid, p.pname;


-- Problem 6

SELECT v1.vid, v1.vname FROM vendor v1 
WHERE NOT EXISTS (
    (SELECT p.pid FROM part p WHERE p.price > 100)
    MINUS (
        SELECT s.pid FROM vendor v2, supply s WHERE v1.vid = v2.vid AND v1.vid = s.vid
    )
);

-- Problem 7

SELECT p.pid, p.pname, COUNT(s.vid)
FROM part p, supply s
WHERE p.pid = s.pid
GROUP BY p.pid, p.pname;

-- Problem 8
SELECT v.vid, v.vname 
FROM vendor v
WHERE v.vid IN (
    SELECT s.vid FROM supply s
    GROUP BY s.vid
    HAVING SUM(s.qty) > 42
);

-- Get vid, vname and qty supplied by each vendor

SELECT v.vid, v.vname, SUM(s.qty)
FROM vendor v, supply s
WHERE v.vid = s.vid
GROUP BY v.vid, v.vname;



-- Problem 9
SELECT v.vid, v.vname FROM vendor v
WHERE v.vid IN (
    SELECT s.vid from supply s, part p
    WHERE s.pid = p.pid AND p.pname='Pad'
);

-- Problem 10
SELECT v.vid, v.vname 
FROM vendor v, supply s
WHERE s.vid = v.vid 
GROUP BY v.vid, v.vname
HAVING MAX(s.qty) > 250;

-- Problem 11
SELECT v.vid, v.vname, COUNT(s.pid)
FROM vendor v, supply s
WHERE v.vid = s.vid AND s.qty > 100
GROUP BY v.vid, v.vname;