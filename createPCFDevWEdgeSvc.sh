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
echo "cf push edgesvc -o hecklerm/edgesvc -m 1G"
cf push edgesvc -o hecklerm/edgesvc -m 1G
read -p "Press ENTER to continue..."
echo ""
# echo "curl http://edgesvc.local.pcfdev.io/quote"
# curl http://edgesvc.local.pcfdev.io/quote
# read -p "Press ENTER to continue..."
# echo ""
echo "cf set-env edgesvc QUOTESVC_URI http://quotesvc.local.pcfdev.io"
cf set-env edgesvc QUOTESVC_URI http://quotesvc.local.pcfdev.io
read -p "Press ENTER to continue..."
echo ""
echo "cf restart edgesvc"
cf restart edgesvc
read -p "Press ENTER to continue..."
echo ""
echo "curl http://edgesvc.local.pcfdev.io/quote"
curl http://edgesvc.local.pcfdev.io/quote
read -p "Press ENTER to continue..."
echo ""
echo "cf scale edgesvc -i 2"
cf scale edgesvc -i 2
read -p "Press ENTER to continue..."
echo ""
echo "cf app edgesvc"
cf app edgesvc
echo ""
read -p "Run cf logs edgesvc from another tab & press ENTER to continue..."
echo ""
echo "curl http://edgesvc.local.pcfdev.io/quote x 4"
curl http://edgesvc.local.pcfdev.io/quote
curl http://edgesvc.local.pcfdev.io/quote
curl http://edgesvc.local.pcfdev.io/quote
curl http://edgesvc.local.pcfdev.io/quote
read -p "Press ENTER to continue..."
echo ""
echo "cf stop edgesvc"
cf stop edgesvc
echo "cf stop quotesvc"
cf stop quotesvc
echo ""
# echo "Deploy as buildpack, then..."
echo "cf dev suspend"
cf dev suspend
