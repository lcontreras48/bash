HOST="appb7.ob.jash1.syseng.tmcs"
PRODUCTCODE="prd1046"
INSTANCETYPE="GP2-2-4"
PROFILE="ash"

CMK="/Users/dorance.martinez/git/cloudstack-cloudmonkey/bin/cmk"

if [ "$(/opt/cisco/anyconnect/bin/vpn status | grep state | cut -d' ' -f5 | head -1)" == "Disconnected" ]; then
  echo "vpn is Disconnected, please connect"
  exit
fi
date
open http://${HOST}:8080/health/healthcheck
open http://${HOST}:8080/rest/orderbridge/v3/mama/orders/cop-order-29000288883703236
curl -s http://${HOST}:8080/health/healthcheck | html2text >${HOST}-OL5.txt
curl -s http://${HOST}:8080/rest/orderbridge/v3/mama/orders/cop-order-29000288883703236 | jq . >${HOST}-OL5.json
$CMK set profile prod.${PROFILE} &&
$CMK sync &&
$CMK tm provisionvirtualmachine hostname=${HOST} productcode=${PRODUCTCODE} instancetype=${INSTANCETYPE} osfamily=oracle-6.9 reprovision=true &&
open https://cstack-prod.${PROFILE}.tktm.io/client/
say 'cmk ends' ; date ; sleep 420
say 'the provision finished?'
read -p "Press enter to continue"
for i in {1..3}; do
  ssh -i ~/.ssh/id_rsa -o "StrictHostKeyChecking=no" -l sre ${HOST} 'cat /etc/redhat-release ; sudo rubix' &&
  say "sudo rubix $i, finished" ; date
  sleep 5
done
curl -s http://${HOST}:8080/health/healthcheck | html2text >${HOST}-OL6.txt
diff -y --suppress-common-lines ${HOST}-OL5.txt ${HOST}-OL6.txt
read -p "Press enter to continue"
curl -s http://${HOST}:8080/rest/orderbridge/v3/mama/orders/cop-order-29000288883703236 | jq . >${HOST}-OL6.json
diff -y --suppress-common-lines ${HOST}-OL5.json ${HOST}-OL6.json
read -p "Press enter to continue"
open http://${HOST}:8080/health/healthcheck
# open "https://rundeck.tm.tmcs/project/CORCH/activity?jobIdFilter=417&includeJobRef=false"
open "https://rundeck.tm.tmcs/project/COPBOH/activity?jobIdFilter=1487&includeJobRef=false"
read -p "Press enter to continue"
say 'rundeck job started' ; date ; sleep 450
say 'rundeck job finished' ; date
date
curl -s http://${HOST}:8080/health/healthcheck | html2text >${HOST}-OL6.txt
diff -y --suppress-common-lines ${HOST}-OL5.txt ${HOST}-OL6.txt