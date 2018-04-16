#!/bin/bash

selectCustomer="SELECT ALL genBSON( customer )::JSON FROM customer;"
selectCustCalls="SELECT ALL genBSON( cust_calls )::JSON FROM cust_calls;"
errorCode=0

runuser -l informix -c "echo '$selectCustomer' | dbaccess stores_demo" >> customers.json
if [ $? -eq 0 ]; then
	echo "Customer request done"
else
    	echo "Error while requesting customer"
	$errorCode=1	
fi

runuser -l informix -c "echo '$selectCustCalls' | dbaccess stores_demo" >> cust_calls.json
if [ $? -eq 0 ]; then
	echo "Cust_calls request done"
else
    	echo "Error while requesting cust_calls"
	$errorCode=1	
fi


exit
