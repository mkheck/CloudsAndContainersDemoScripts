#!/bin/sh
clear

# Resume PCF Dev
cf dev resume

cf delete edgesvc
cf delete edgesvcbp
cf delete quotesvc

echo ""
echo "\033[33mcf push quotesvc -o jmreif/quotesvc -m 1G\033[0m"
cf push quotesvc -o jmreif/quotesvc -m 1G
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mcurl http://quotesvc.local.pcfdev.io/random\033[0m"
curl http://quotesvc.local.pcfdev.io/random
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mcf scale quotesvc -i 2\033[0m"
cf scale quotesvc -i 2
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mcf app quotesvc\033[0m"
cf app quotesvc
echo ""
read -p "Run cf logs quotesvc from another tab & press ENTER to continue..."
echo ""
echo "\033[33mcurl http://quotesvc.local.pcfdev.io/random x 4\033[0m"
curl http://quotesvc.local.pcfdev.io/random
curl http://quotesvc.local.pcfdev.io/random
curl http://quotesvc.local.pcfdev.io/random
curl http://quotesvc.local.pcfdev.io/random
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mcf stop quotesvc\033[0m"
cf stop quotesvc
echo ""
# echo "Deploy as buildpack, then..."
echo "\033[33mcf dev suspend\033[0m"
cf dev suspend
