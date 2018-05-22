#! bin/bash

echo "$(tput bold ; tput setaf 6)######################################"
echo "$(tput bold ; tput setaf 2) Baptiste Domange - TD3 mongodb script $(tput bold ; tput setaf 6)"
echo "$(tput bold ; tput setaf 6)######################################$(tput sgr0)"

echo ""

echo "$(tput setaf 1)Vous trouverez le résultat des requêtes dans le fichier $(tput bold) $PWD/td4_search_mongo.log  $(tput sgr0)"

echo ""

#IMPORT / SETUP : 
echo "$(tput bold ; tput setaf 6) IMPORT / SETUP  $(tput sgr0)"
mongoimport --db 'stores_demo_td4' --collection customers --drop --file $PWD/c.unl
mongoimport --db 'stores_demo_td4' --collection orders --drop --file $PWD/o.unl
mongoimport --db 'stores_demo_td4' --collection cust_calls --drop --file $PWD/a.unl

echo "" > $PWD/td4_search_mongo.log

#Exercice 1 : FIND
echo "$(tput bold ; tput setaf 6) Exercice 1 $(tput sgr0)"  
echo "$(tput bold ; tput setaf 6) Exercice 1 $(tput sgr0)" >> $PWD/td4_search_mongo.log
#a. select * from customer where company MATCHES « *Sports* » and NOT MATCHES « *town* »
echo "$(tput bold ; tput setaf 6) a. select * from customer where company MATCHES « *Sports* » and NOT MATCHES « *town* » $(tput sgr0)" >> $PWD/td4_search_mongo.log
mongo localhost:27017/stores_demo_td4 --eval "db.getCollection('customers').createIndex({ company : 'text'})" >> $PWD/td4_search_mongo.log
mongo localhost:27017/stores_demo_td4 --eval 'db.getCollection("customers").find( { $text: { $search: "Sports -town" } } )' >> $PWD/td4_search_mongo.log
#b. select * from cust_calls where call_descr MATCHES « *hero watch* » or MATCHES « *tennis* »
echo "$(tput bold ; tput setaf 6) b. select * from cust_calls where call_descr MATCHES « *hero watch* » or MATCHES « *tennis* » $(tput sgr0)" >> $PWD/td4_search_mongo.log
mongo localhost:27017/stores_demo_td4 --eval 'db.getCollection("cust_calls").find( { call_descr: { $regex : "tennis | Hero watch" } })'  >> $PWD/td4_search_mongo.log

#Exercice 2 : FIND
echo "$(tput bold ; tput setaf 6) Exercice 2 $(tput sgr0)"
echo "$(tput bold ; tput setaf 6) Exercice 2 $(tput sgr0)" >> $PWD/td4_search_mongo.log
#a. db.customer.find ( (address2 = nul ) )
echo "$(tput bold ; tput setaf 6) a. db.customer.find ( (address2 = nul ) ) $(tput sgr0)" >> $PWD/td4_search_mongo.log
mongo localhost:27017/stores_demo_td4 --eval "db.getCollection('customers').find ( { address2 : null } )" >> $PWD/td4_search_mongo.log
#b. db.orders.find (( pai_date: ( $type = 11 )))
echo "$(tput bold ; tput setaf 6) b. db.orders.find (( pai_date: ( $type = 11 ))) $(tput sgr0)" >> $PWD/td4_search_mongo.log
mongo localhost:27017/stores_demo_td4 --eval 'db.getCollection("cust_calls").find( { paid_date: { $type : 10 } })' >> $PWD/td4_search_mongo.log

#Exercice 3 : FIND ( return only s _id , fname et lname)
echo "$(tput bold ; tput setaf 6) Exercice 3 $(tput sgr0)"
echo "$(tput bold ; tput setaf 6) Exercice 3 $(tput sgr0)" >> $PWD/td4_search_mongo.log
#a. db.customer.find ( ( state :’CA’, fname:’Arnold’))
echo "$(tput bold ; tput setaf 6) a. db.customer.find ( ( state :’CA’, fname:’Arnold’)) $(tput sgr0)" >> $PWD/td4_search_mongo.log
mongo localhost:27017/stores_demo_td4 --eval "db.getCollection('customers').find({ 'state' :'CA', 'fname':'Arnold'}, {'fname':1,'lname':1})" >> $PWD/td4_search_mongo.log
#b. db.customer.find ( ( zipcod :’85008’))
echo "$(tput bold ; tput setaf 6) b. db.customer.find ( ( zipcod :’85008’)) $(tput sgr0)" >> $PWD/td4_search_mongo.log
mongo localhost:27017/stores_demo_td4 --eval "db.getCollection('customers').find({ 'zipcode' : '85008'}, {'fname':1,'lname':1})" >> $PWD/td4_search_mongo.log



exit
