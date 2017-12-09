(deftemplate person (slot name)(slot age)(slot price)(slot distance)(slot points)(slot credit))
(deftemplate age_risk_factor (slot factor)(slot name))
(deftemplate price_risk_factor (slot pr)(slot name))
(deftemplate commute_risk_factor (slot ds)(slot name))
(deftemplate offense_risk_factor (slot pt)(slot name))
(deftemplate credit_risk_factor (slot cr)(slot name))
(deftemplate total_average_risk (slot avg_risk)(slot name))
(deftemplate insurance_premium (slot insurance)(slot name))

(deffacts persons
(person (name Sarah)(age 18.5)(price 5000)(distance 20)(points 10)(credit 700.5))
(person (name Daniel)(age 18)(price 5001)(distance 20.5)(points 11)(credit 700))
)
(defrule age_risk_factor
	(person (name ?n1) (age ?a1))
=>
(if (or(<= ?a1 18) (>= ?a1 75))
then
	(assert (age_risk_factor (factor 5)(name ?n1))) 
else
    (assert (age_risk_factor (factor 0)(name ?n1)))	)

)

(defrule price_risk_factor
	(person (name ?n1) (price ?p1))
=>
(if (<= ?p1 5000)
then
	(assert (price_risk_factor (pr 0)(name ?n1))) 
else
(if (or(> ?p1 5000) (< ?p1 20000))
then
	(assert (price_risk_factor (pr 5)(name ?n1))))
else
(if (> ?p1 20000)
then
	(assert (price_risk_factor (pr 5)(name ?n1)))))) 

(defrule commute_risk_factor
	(person (name ?n1) (distance ?d1))
=>
(if (<= ?d1 20)
then
	(assert (commute_risk_factor (ds 0)(name ?n1))) 
else
(if (or(> ?d1 20) (< ?d1 50))
then
	(assert (commute_risk_factor (ds 2)(name ?n1)))
else
	(assert (commute_risk_factor (ds 5)(name ?n1))))))

(defrule offense_risk_factor
	(person (name ?n1) (points ?po1))
=>
(if (<= ?po1 10)
then
	(assert (offense_risk_factor (pt 0)(name ?n1))) 
else
(if (or(> ?po1 10) (< ?po1 20))
then
	(assert (offense_risk_factor (pt 2)(name ?n1))))
else
(if (> ?po1 20)
then
	(assert (offense_risk_factor (pt 5)(name ?n1)))))) 

(defrule credit_risk_factor
	(person (name ?n1) (credit ?c1))
=>
(if (> ?c1 700)
then
	(assert (credit_risk_factor (cr 0)(name ?n1))) 
else
(if (or(> ?c1 600) (< ?c1 700))
then
	(assert (credit_risk_factor (cr 2)(name ?n1))))
else
(if (<= ?c1 600)
then
	(assert (credit_risk_factor (cr 5)(name ?n1))))))
	
(defrule total_average_risk
	(age_risk_factor (name ?n)(factor ?f))(price_risk_factor (name ?n)(pr ?p))(commute_risk_factor (name ?n)(ds ?d))(offense_risk_factor (name ?n)(pt ?po))(credit_risk_factor (name ?n)(cr ?c))
=>
	(assert (total_average_risk (avg_risk(/(+ ?f ?p ?d ?po ?c) 5)) (name ?n))))
	
(defrule insurance_premium
	(total_average_risk (avg_risk ?ar)(name ?n))
=>
	(assert(insurance_premium(insurance(*(+ 1 ?ar) 700))(name ?n)))
	)
 	
(defrule output
	(insurance_premium(insurance ?i)(name ?n))
=>
	(printout t "The insurance premium of " ?n " is " ?i crlf)
)