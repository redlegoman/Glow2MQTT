#!/bin/bash
glowuser=""
glowpass=""
mqttip=""
mqttuser=""
mqttpass=""
e_consumption=`glowmarkt-today -u $glowuser -p $glowpass -c electricity.consumption`
e_cost=`glowmarkt-today -u $glowuser -p $glowpass -c electricity.consumption.cost`
mosquitto_pub -h $mqttip -m $e_consumption -t glowmarkt/electric_consumptiontoday -u $mqttuser -P $mqttpass -r -d
mosquitto_pub -h $mqttip -m $e_cost -t glowmarkt/electric_costtoday -u $mqttuser -P $mqttpass -r -d
g_consumption=`glowmarkt-today -u $glowuser -p $glowpass -c gas.consumption`
g_cost=`glowmarkt-today -u $glowuser -p $glowpass -c gas.consumption.cost`
mosquitto_pub -h $mqttip -m $g_consumption -t glowmarkt/gas_consumptiontoday -u $mqttuser -P $mqttpass -r -d
mosquitto_pub -h $mqttip -m $e_cost -t glowmarkt/gas_costtoday -u $mqttuser -P $mqttpass -r -d
