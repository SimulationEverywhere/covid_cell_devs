#!/bin/bash
cd ../model
zip ../RISE/covid.zip covid.ma covid.val VN.inc
cd ../RISE
java -jar RESTful_CDppTest.jar DeleteFramework test test test/lopez/covid
java -jar RESTful_CDppTest.jar PutXMLFile test test test/lopez/covid covid.xml
java -jar RESTful_CDppTest.jar PostZipFile test test test/lopez/covid?zdir=covid covid.zip
java -jar RESTful_CDppTest.jar PutFramework test test test/lopez/covid/simulation
rm  covid.zip
echo Retrieve Simulation results http://vs1.sce.carleton.ca:8080/cdpp/sim/workspaces/test/lopez/covid/results
