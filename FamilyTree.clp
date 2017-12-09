(deftemplate father-of (slot father)(slot child))
(deftemplate mother-of (slot mother)(slot child))
(deftemplate male (slot person))
(deftemplate female (slot person))
(deftemplate wife-of (slot wife) (slot husband))
(deftemplate husband-of (slot husband) (slot wife))
(deftemplate parent-of (slot parent) (slot child))
(deftemplate grandparent-of (slot parent) (slot child))
(deftemplate grandfather-of (slot parent) (slot child))
(deftemplate grandmother-of (slot parent) (slot child))
(deftemplate brother-of (slot male) (slot child))
(deftemplate sister-of (slot female) (slot child))
(deftemplate uncle-of (slot male) (slot child))
(deftemplate aunt-of (slot female) (slot child))
(deftemplate cousin-of (slot cousin) (slot child))

(deffacts my-family-tree
(male (person Ramakrishna))
(male (person Chandra))
(male (person Chaitanya))
(male (person Dinakar))
(male (person Rajeev))
(male (person Kumar))
(male (person Shanmukha))
(male (person Srimanth))
(male (person Veerabhadra))
(male (person Shravan))
(male (person Padmanabham))
(male (person Somayajulu))
(male (person Rammurthy))
(male (person Shankar))
(male (person Uday))
(male (person Padmakar))
(male (person Charan))
(female (person Hemalatha))
(female (person Padmavati))
(female (person Nirupama))
(female (person Padmaja))
(female (person Srilatha))
(female (person Jayasri))
(female (person Vasantha))
(female (person Laxmi))
(female (person Sujatha))
(female (person Vijaya))
(female (person Sudheshna))
(female (person Valli))
(female (person Tripura))
(female (person Padma))
(father-of (father Ramakrishna)(child Chandra))
(father-of (father Ramakrishna)(child Dinakar))
(father-of (father Ramakrishna)(child Kumar))
(father-of (father Ramakrishna)(child Vasantha))
(father-of (father Chandra)(child Chaitanya))
(father-of (father Chandra)(child Nirupama))
(father-of (father Dinakar)(child Rajeev))
(father-of (father Dinakar)(child Srilatha))
(father-of (father Kumar)(child Shanmukha))
(father-of (father Kumar)(child Srimanth))
(father-of (father Somayajulu)(child Uday))
(father-of (father Padmanabham)(child Laxmi))
(father-of (father Padmanabham)(child Rammurthy))
(father-of (father Padmanabham)(child Shankar))
(father-of (father Padmanabham)(child Jayasri))
(father-of (father Rammurthy)(child Sudheshna))
(father-of (father Rammurthy)(child Valli))
(father-of (father Shankar)(child Padmakar))
(father-of (father Shankar)(child Charan))
(father-of (father Shankar)(child Tripura))
(father-of (father Veerabhadra)(child Shravan))
(mother-of (mother Hemalatha)(child Chandra))
(mother-of (mother Hemalatha)(child Dinakar))
(mother-of (mother Hemalatha) (child Kumar))
(mother-of (mother Hemalatha)(child Vasantha))
(mother-of (mother Padmavati)(child Chaitanya))
(mother-of (mother Padmavati)(child Nirupama))
(mother-of (mother Padmaja)(child Rajeev))
(mother-of (mother Padmaja)(child Srilatha))
(mother-of (mother Jayasri)(child Shanmukha))
(mother-of (mother Jayasri)(child Srimanth))
(mother-of (mother Vasantha)(child Shravan))
(mother-of (mother Padma)(child Laxmi))
(mother-of (mother Padma)(child Rammurthy))
(mother-of (mother Padma)(child Shankar))
(mother-of (mother Padma)(child Jayasri))
(mother-of (mother Laxmi)(child Uday))
(mother-of (mother Sujatha)(child Sudheshna))
(mother-of (mother Sujatha)(child Valli))
(mother-of (mother Vijaya)(child Padmakar))
(mother-of (mother Vijaya)(child Charan))
(mother-of (mother Vijaya)(child Tripura))
(wife-of (wife Hemalatha)(husband Ramakrishna))
(wife-of (wife Padmaja)(husband Dinakar))
(wife-of (wife Jayasri)(husband Kumar))
(wife-of (wife Vasantha)(husband Veerabhadra))
(wife-of (wife Padma)(husband Padmanabham))
(wife-of (wife Laxmi)(husband Somayajulu))
(wife-of (wife Sujatha)(husband Rammurthy))
(wife-of (wife Vijaya)(husband Shankar))
(husband-of (husband Ramakrishna)(wife Hemalatha))
(husband-of (husband Chandra)(wife Padmavati))
(husband-of (husband Dinakar)(wife Padmaja))
(husband-of (husband Kumar)(wife Jayasri))
(husband-of (husband Veerabhadra)(wife Vasantha))
(husband-of (husband Padmanabham)(wife Padmavathi))
(husband-of (husband Somayajulu)(wife Laxmi))
(husband-of (husband Rammurthy)(wife Sujatha))
(husband-of (husband Shankar)(wife Vijaya)))

(defrule parent-of
(or (father-of (father ?x) (child ?y))
  (mother-of (mother ?x) (child ?y)))
=>
(assert (parent-of (parent ?x) (child ?y))))

(defrule grandparent-of
(and (parent-of (parent ?x) (child ?y))
  (parent-of (parent ?y) (child ?z)))
=>
(assert (grandparent-of (parent ?x) (child ?z))))

(defrule grandfather-of
(and (father-of (father ?x) (child ?y))
  (parent-of (parent ?y) (child ?z)))
=>
(assert (grandfather-of (parent ?x) (child ?z))))

(defrule grandmother-of
(and (mother-of (mother ?x) (child ?y))
  (parent-of (parent ?y) (child ?z)))
=>
(assert (grandmother-of (parent ?x) (child ?z))))

(defrule brother-of
(and (parent-of (parent ?x) (child ?y)) (male (person ?y))
 (parent-of (parent ?x) (child ?z))
 (test (neq ?y ?z)))
=>
(assert (brother-of (male ?y) (child ?z))))

(defrule sister-of
(and (parent-of (parent ?x) (child ?y)) (female (person ?y))
 (parent-of (parent ?x) (child ?z))
 (test (neq ?y ?z)))
=>
(assert (sister-of (female ?y) (child ?z))))

(defrule uncle-of
(and (parent-of (parent ?x) (child ?y)) 
 (brother-of (male ?z) (child ?x)))
=>
(assert (uncle-of (male ?z) (child ?y))))

(defrule aunt-of
(and (parent-of (parent ?x) (child ?y)) 
 (sister-of (female ?z) (child ?x)))
=>
(assert (aunt-of (female ?z) (child ?y))))

(defrule cousin-of
(and (parent-of (parent ?x) (child ?v)) 
 (parent-of (parent ?y) (child ?w))
(parent-of (parent ?z) (child ?x))
(parent-of (parent ?z) (child ?y))
(test (neq ?v ?w))
(test (neq ?x ?y))
)
=>
(assert (cousin-of (cousin ?v) (child ?w))))