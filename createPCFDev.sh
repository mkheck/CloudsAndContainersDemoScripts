#!/bin/sh
clear

# Resume PCF Dev
cf dev resume

cf delete edgesvc
cf delete edgesvcbp
cf delete quotesvc

echo ""
echo "cf push quotesvc -o hecklerm/quotesvc -m 1G"
cf push quotesvc -o hecklerm/quotesvc -m 1G
read -p "Press ENTER to continue..."
echo ""
echo "curl http://quotesvc.local.pcfdev.io/random"
curl http://quotesvc.local.pcfdev.io/random
read -p "Press ENTER to continue..."
echo ""
echo "cf scale quotesvc -i 2"
cf scale quotesvc -i 2
read -p "Press ENTER to continue..."
echo ""
echo "cf app quotesvc"
cf app quotesvc
echo ""
read -p "Run cf logs quotesvc from another tab & press ENTER to continue..."
echo ""
echo "curl http://quotesvc.local.pcfdev.io/random x 4"
curl http://quotesvc.local.pcfdev.io/random
curl http://quotesvc.local.pcfdev.io/random
curl http://quotesvc.local.pcfdev.io/random
curl http://quotesvc.local.pcfdev.io/random
read -p "Press ENTER to continue..."
echo ""
echo "cf stop quotesvc"
cf stop quotesvc
echo ""
# echo "Deploy as buildpack, then..."
echo "cf dev suspend"
cf dev suspend
