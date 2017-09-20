#!/bin/sh
clear

# Resume PCF Dev
cf dev resume

cf delete edgesvc
cf delete edgesvcbp
cf delete quotesvc

echo ""
echo "\033[33mcf push quotesvc -o hecklerm/quotesvc -m 1G\033[0m"
cf push quotesvc -o hecklerm/quotesvc -m 1G
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mcf push edgesvc -o hecklerm/edgesvc -m 1G\033[0m"
cf push edgesvc -o hecklerm/edgesvc -m 1G
read -p "Press ENTER to continue..."
echo ""
# echo "http http://edgesvc.local.pcfdev.io/quote"
# http http://edgesvc.local.pcfdev.io/quote
# read -p "Press ENTER to continue..."
# echo ""
echo "\033[33mcf set-env edgesvc QUOTESVC_URI http://quotesvc.local.pcfdev.io\033[0m"
cf set-env edgesvc QUOTESVC_URI http://quotesvc.local.pcfdev.io
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mcf restart edgesvc\033[0m"
cf restart edgesvc
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mhttp http://edgesvc.local.pcfdev.io/quote\033[0m"
http http://edgesvc.local.pcfdev.io/quote
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mcf scale edgesvc -i 2\033[0m"
cf scale edgesvc -i 2
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mcf app edgesvc\033[0m"
cf app edgesvc
echo ""
read -p "Run cf logs edgesvc from another tab & press ENTER to continue..."
echo ""
echo "\033[33mhttp http://edgesvc.local.pcfdev.io/quote x 4\033[0m"
http http://edgesvc.local.pcfdev.io/quote
http http://edgesvc.local.pcfdev.io/quote
http http://edgesvc.local.pcfdev.io/quote
http http://edgesvc.local.pcfdev.io/quote
read -p "Press ENTER to continue..."
echo ""
echo "\033[33mcf stop edgesvc\033[0m"
cf stop edgesvc
echo "\033[33mcf stop quotesvc\033[0m"
cf stop quotesvc
echo ""
# echo "Deploy as buildpack, then..."
echo "\033[33mcf dev suspend\033[0m"
cf dev suspend
