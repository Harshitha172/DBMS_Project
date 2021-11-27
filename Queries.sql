/*simple queries*/

/* To fetch zoos registered and visiting hours*/
EXPLAIN SELECT zoos_name,zoos_visiting_hours
FROM ZOOS;

/* To fetch adopted animals*/
EXPLAIN SELECT ANIMAL_ADOPTED.animal_adopted_animal,ANIMAL_ADOPTED.animal_adopted_adoption_date,GENERAL_PUBLIC.general_public_name
FROM ANIMAL_ADOPTED,GENERAL_PUBLIC
WHERE animal_adopted.animal_adopted_general_pulic_aadhar = GENERAL_PUBLIC.general_public_aadhar_no;

/* To fetch Doctor details*/
EXPLAIN SELECT doctor_name,doctor_hospital_address,doctor_domain
FROM DOCTORS;

/* To fetch queries and answers*/
EXPLAIN SELECT A.queries_query_question,B.queries_query_answer_query_answer
FROM QUERIES AS A,QUERIES_QUERY_ANSWER AS B
WHERE A.queries_query_answer_query_id = B.queries_query_id;

/* To fetch Animal care*/
EXPLAIN SELECT animal_type_animal_type_care_animal_type_breed,animal_type_animal_type_care_animal_type_care
FROM ANIMAL_TYPE_ANIMAL_TYPE_CARE;

/*COMPLEX QUERIES*/

/* To fetch animals grouped*/
EXPLAIN SELECT A.animal_id
FROM SPONSOR AS S, ANIMAL AS A, ZOOS AS Z
WHERE S.sponsor_zoos_id = Z.zoos_id AND S.sponsor_animal_id = A.animal_id
GROUP BY Z.zoos_name;

/* To fetch animals grouped*/
EXPLAIN SELECT A.animal_id
FROM ADOPT AS S, ANIMAL AS A, ANIMAL_SHELTER AS Z
WHERE S.adopt_animal_shelter_certificate_no = Z.animal_shelter_certificate_no AND S.adopt_animal_id = A.animal_id
GROUP BY Z.animal_shelter_name;

/* To fetch animals grouped*/
EXPLAIN SELECT A.animal_id
FROM HOST AS S, ANIMAL AS A, PET_SHOP AS Z
WHERE S.host_pet_shop_certificate_no = Z.pet_shop_certificate_no AND S.host_animal_id = A.animal_id
GROUP BY Z.pet_shop_name;

/* To fetch products grouped*/
EXPLAIN SELECT pet_care_products_link
FROM PET_CARE_PRODUCTS
GROUP BY pet_care_products_animal_type_id,pet_care_products_link_website;

/* To fetch doctors grouped*/
EXPLAIN SELECT doctor_name,doctor_email
FROM DOCTORS
GROUP BY doctor_domain;

/* NESTED QUERIES*/

/*to fetch people who have adopted animal with disease history*/
EXPLAIN SELECT G.general_public_name,G.general_public_email
FROM ANIMAL_ADOPTED AS A, GENERAL_PUBLIC AS G
WHERE A.animal_adopted_general_public_aadhar = G.general_public_aadhar_no AND A.animal_adopted_animal_id IN (SELECT animal_disease_history_animal_id FROM ANIMAL_DISEASE_HISTORY);

/*fetch queries not answered*/
EXPLAIN SELECT queries_query_question
FROM QUERIES
WHERE queries_query_id NOT IN(SELECT queries_query_answer_query_id FROM QUERIES_QUERY_ANSWER);

/*fetch people who have not adopted any animal*/
EXPLAIN SELECT general_public_name, general_public_email
FROM GENERAL_PUBLIC
WHERE general_public_aadhar_no NOT IN (SELECT animal_adopted_general_public_aadhar FROM ANIMAL_ADOPTED WHERE animal_adopted_general_public_aadhar IS NOT NULL);

/*fetch email of people who have adopted animals after 01/01/2000*/
EXPLAIN SELECT general_public_name,general_public_email
FROM GENERAL_PUBLIC
WHERE general_public_aadhar_no IN(SELECT animal_adopted_general_public_aadhar FROM ANIMAL_ADOPTED WHERE animal_adopted_adoption_date>01/01/2000);

/*fetch people who have adopted animal from pet shop with more than 50 pets*/
EXPLAIN SELECT general_public_name,general_public_email
FROM GENERAL_PUBLIC
WHERE general_public_aadhar_no IN(SELECT animal_adopted_general_public_aadhar FROM ANIMAL_ADOPTED WHERE animal_adopted_pet_shop_certificate IS NOT NULL AND animal_adopted_pet_shop_certificate IN(SELECT pet_shop_certificate_no FROM PET_SHOP WHERE pet_shop_no_of_pets>50));


