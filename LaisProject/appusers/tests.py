import requests

#"refresh": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTYyNzU3MDY5MSwianRpIjoiNjQ5OTZiZGY0N2IxNGRmZTlmMmE3NjRhNmVhNzZlYzQiLCJ1c2VyX2lkIjoxfQ.1fOFYpHF91fkecpyQl4jXwl8evggFZ6Ud2C1jt27h_k",
#"access": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI3NDg0NTkxLCJqdGkiOiI0NDgyMTMyZDQ5MzE0MzZhOWY1YTU1OTYzYmE3NDg3MyIsInVzZXJfaWQiOjF9.Pvi93EAh7_VNnlIJ1yfSH5prah2QH6fArARBeJJCrdI"


headers = { "Authorization": "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjI3NDg3ODc2LCJqdGkiOiI0NmI5MDQ2N2E2N2E0NDk3OTliNzc0NTVhMDQ1MDYwMiIsInVzZXJfaWQiOjF9.4JWh7VmZvh4az0Rllu2o18WDUTYYEJ8AfaMRM_fALtU"}

x1 = requests.get("http://localhost:8000/api/user/users", headers=headers)
print(x1.content)