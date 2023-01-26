export subscriptionId="78a38e5d-91b9-4370-8590-d6bea8bda53b";
export resourceGroup="koala";
export tenantId="a57c94a8-372e-4f3c-b09f-51f755132763";
export location="koreacentral";
export authType="token";
export correlationId="5ea62433-2c9f-4b70-8e0d-2872126ae8d9";
export cloud="AzureCloud";

# 설치 패키지 다운로드
output=$(wget https://aka.ms/azcmagent -O ~/install_linux_azcmagent.sh 2>&1);
if [ $? != 0 ]; then wget -qO- --method=PUT --body-data="{\"subscriptionId\":\"$subscriptionId\",\"resourceGroup\":\"$resourceGroup\",\"tenantId\":\"$tenantId\",\"location\":\"$location\",\"correlationId\":\"$correlationId\",\"authType\":\"$authType\",\"operation\":\"onboarding\",\"messageType\":\"DownloadScriptFailed\",\"message\":\"$output\"}" "https://gbl.his.arc.azure.com/log" &> /dev/null || true; fi;
echo "$output";

# 하이브리드 에이전트 설치
bash ~/install_linux_azcmagent.sh;

# 연결 명령 실행
sudo azcmagent connect --resource-group "$resourceGroup" --tenant-id "$tenantId" --location "$location" --subscription-id "$subscriptionId" --cloud "$cloud" --correlation-id "$correlationId";
