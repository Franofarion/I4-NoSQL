#! bin/bash

echo "$(tput bold ; tput setaf 6)######################################"
echo "$(tput bold ; tput setaf 2) Baptiste Domange - TD3 mongodb script $(tput bold ; tput setaf 6)"
echo "$(tput bold ; tput setaf 6)######################################$(tput sgr0)"

echo ""

echo "$(tput setaf 1)Vous trouverez le résultat des requêtes dans le fichier $(tput bold) $PWD/td3_insert_mongo.log  $(tput sgr0)"

echo ""

#Exercice 1 : IMPORT
echo "$(tput bold ; tput setaf 6)Exercice 1 : IMPORT  $(tput sgr0)"
mongoimport --db 'stores_demo_td3' --collection customers --drop --file $PWD/c.unl
mongoimport --db 'stores_demo_td3' --collection orders --drop --file $PWD/o.unl
mongoimport --db 'stores_demo_td3' --collection cust_calls --drop --file $PWD/a.unl

echo "" > $PWD/td3_insert_mongo.log

#Exercice 2 : FIND
echo "$(tput bold ; tput setaf 6)Exercice 2 : FIND  $(tput sgr0)"
#a) customer : dont customer_num > 101 (1pt)
mongo localhost:27017/stores_demo_td3 --eval "db.getCollection('customers').find({'customer_num' : { \$gt: 101 }})" >> $PWD/td3_insert_mongo.log

#b) orders : dont order_num between 1003 and 1006 (1pt)
mongo localhost:27017/stores_demo_td3 --eval "db.getCollection('orders').find({'order_num' : { \$gt: 1002, \$lt: 1007 }})" >> $PWD/td3_insert_mongo.log

#c) cust_calls : dont user_id like ‘%j’ (1pt)
mongo localhost:27017/stores_demo_td3 --eval "db.getCollection('cust_calls').find({'user_id' : /.*j/})" >> $PWD/td3_insert_mongo.log

#d) orders : le 1er  enregistrement en triant par order_date (parordre croissant) (2pts)
mongo localhost:27017/stores_demo_td3 --eval "db.getCollection('orders').find({}).sort({'order_date' : 1}).limit(1)" >> $PWD/td3_insert_mongo.log

#Exercice 3 : INDEX 
echo "$(tput bold ; tput setaf 6)Exercice 3 : INDEX $(tput sgr0)"
#a. Unique sur la colonne : customer_num de la collection customer (1point)
mongo localhost:27017/stores_demo_td3 --eval "db.getCollection('customers').createIndex( { customer_num: 1 }, {unique : true})"

#b. Unique sur les colonnes : customer_num + call_dtime + user_id, de la collection cust_calls (2pts)
mongo localhost:27017/stores_demo_td3 --eval "db.getCollection('cust_calls').createIndex( { customer_num: 1, call_dtime: 1, user_id: 1 })"

# c. Vérifier que votre index est bien utilisé dans l’instruction 2a puis 2c (2pts) à voir l’article suivant pour le contrôle de l’utilisation d’un Index : 
mongo localhost:27017/stores_demo_td3 --eval "db.getCollection('customers').find({'customer_num' : { \$gt: 101 }}).explain()" >> $PWD/td3_insert_mongo.log
mongo localhost:27017/stores_demo_td3 --eval "db.getCollection('cust_calls').find({'user_id' : /.*j/}).explain()" >> $PWD/td3_insert_mongo.log

#Exercice 4 : SQL to Mongo
echo "$(tput bold ; tput setaf 6)Exercice 4 : SQL to Mongo $(tput sgr0)"
#a. DELETE FROM CUST_CALLS WHERE customer_num = 121 ; 
mongo localhost:27017/stores_demo_td3 --eval "db.getCollection('cust_calls').remove({'customer_num' : 121})" >> $PWD/td3_insert_mongo.log

#SELECT COUNT(*) FROM CUST_CALLS (2points)
mongo localhost:27017/stores_demo_td3 --eval "db.getCollection('cust_calls').find().count()" >> $PWD/td3_insert_mongo.log


#b. UPDATE FROM CUSTOMER SET FNAME = « Laurent » AND LNAME = « Revel » WHERE CUSTOMER_NUM = 101 (3pts)
mongo localhost:27017/stores_demo_td3 --eval "db.getCollection('customers').update({ customer_num: 101}, {\$set :{ fname: 'Laurent', lname: 'Revel' }})"

echo "$(tput setaf 1)Fin du script, vous pourrez voir les résultats des requêtes dans le fichier $(tput bold) $PWD/td3_insert_mongo.log $(tput sgr0)"


exit
