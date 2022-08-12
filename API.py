from time import sleep
from grr_api_client import api
grrapi = api.InitHttp(api_endpoint="http://192.168.100.100:8000",auth=("admin", "hola123.,"))

search_result = grrapi.SearchClients("")
result = {}
for client in search_result:
  client_id = client.client_id
  client_last_seen_at = client.data.last_seen_at
  result[client_id] = client_last_seen_at
print(result)
sleep(4)