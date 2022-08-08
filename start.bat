::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyHcjLQlHcCWGMWK0D6YI+unv4Pi7hkIeQe86dpvI5oEJ2xgv2mbIJ6onxzRfgM5s
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFDpQQQ2MNXiuFLQI5/rHy+WEt0AYWvYsRLpcIUyyEMM/uHljjmGoOYzcVQiL5fPfkNsuoNmzU6DKVKDLMt+Z0w==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off

set /p "playerName=请输入正版玩家名>>>"

echo.
echo 正在获取玩家UUID……
curl --ssl-no-revoke https://api.mojang.com/users/profiles/minecraft/%playerName%|jq .id>%temp%\UUID.tmp
set /p playerUUID=<%temp%\UUID.tmp

echo.
echo 正在获取玩家属性……
curl --ssl-no-revoke https://sessionserver.mojang.com/session/minecraft/profile/%playerUUID:"=%|jq .properties[0].value>%temp%\player.tmp
set /p playerProperties=<%temp%\player.tmp

echo.
echo 正在解密信息……
del %temp%\value.json /q
echo -----BEGIN CERTIFICATE----->%temp%\value.tmp
echo %playerProperties:"=%>>%temp%\value.tmp
echo -----END CERTIFICATE----->>%temp%\value.tmp
certutil -decode %temp%\value.tmp %temp%\value.json
jq .textures.SKIN.url %temp%\value.json>%temp%\URL.tmp
set /p skinURL=<%temp%\URL.tmp

echo.
echo 正在获取玩家皮肤……
curl --ssl-no-revoke %skinURL%>skin.png

echo.
echo 正在清理缓存……
del %temp%\UUID.tmp /q
del %temp%\player.tmp /q
del %temp%\value.tmp /q
del %temp%\URL.tmp /q

echo.
echo 获取完成！皮肤文件已保存到%cd%\skin.png。
start skin.png
pause