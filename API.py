from time import sleep
from grr_api_client import api
import ipaddress

grrapi = api.InitHttp(api_endpoint="http://172.20.4.100:8000",auth=("admin", "hola123.,"))

def buscarClientes(filtro=""):
  search_result = grrapi.SearchClients(filtro)
  #result = {}
  for client in search_result:
    client_id = client.client_id
    client_name = client.data.users[0].username
    client_IPReadable = ipaddress.ip_address(client.data.interfaces[1].addresses[0].packed_bytes) #Revisar
    client_last_seen_at = client.data.last_seen_at
    print (client_id, client_name, client_IPReadable, client_last_seen_at)
  sleep(30)

buscarClientes()