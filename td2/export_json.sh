#!/bin/bash

selectCustomer="SELECT ALL genBSON( customer )::JSON FROM customer;"
selectCustCalls="SELECT ALL genBSON( cust_calls )::JSON FROM cust_calls;"
errorCode=0

echo "$(tput bold ; tput setaf 6)#######################################################################"
echo "$(tput bold ; tput setaf 2) Baptiste Domange export Informix Customer et Cust_calls to Json format  $(tput bold ; tput setaf 6)"
echo "$(tput bold ; tput setaf 6)#######################################################################$(tput sgr0)"


#REQUETE POUR CUSTOMER
echo "$(tput bold ; tput setaf 6)Customer request : $(tput sgr0)"
#On lance la commande 'runuser -l informix' afin de pouvoir executer le script sans être l'utilisateur Informix
#On lance ensuite le SELECT dans la database 'stores_demo' puis écrit le résultat dans 'customer.json'
runuser -l informix -c "echo '$selectCustomer' | dbaccess stores_demo" >> customers.json
#Si la dernière commande retourne 0, c'est qu'elle s'est déroulé sand problème
if [ $? -eq 0 ]; then
	echo "$(tput setaf 2)Customer request done without error, data are stored in $PWD/customer.json $(tput sgr0)"
#Sinon une erreur est survenue
else
    	echo "$(tput setaf 1)Error while requesting customer $(tput sgr0)"
	$errorCode=1	
fi
echo ""

#REQUETE POUR CUST_CALLS
echo "$(tput bold ; tput setaf 6)Cust_calls request : $(tput sgr0)"
runuser -l informix -c "echo '$selectCustCalls' | dbaccess stores_demo" >> cust_calls.json
if [ $? -eq 0 ]; then
	echo "$(tput setaf 2)Customer request done without error, data are stored in $PWD/cust_calls.json $(tput sgr0)"
else
	echo "$(tput setaf 1)Error while requesting cust_calls $(tput sgr0)"
	$errorCode=1	
fi
echo ""

echo "$(tput setaf 1)Script finished with end code $errorCode $(tput sgr0)"

exit
