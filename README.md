# Glow2MQTT

Note : This is all made possible by this project : https://github.com/cybermaggedon/pyglowmarkt All credit belongs with them!

You will need a glowmarkt.com account (free.. no need for their IHD) linked to your provider and receiving readings from your SMETS2 meter. This will only give you the halfhourly increments, but seeing as the energy dashboard in HA only reports hourly figures, it works just fine.

* Ubuntu 20.04 # Only version this has been tested on
* timedatectl set-timezone Europe/London # Make sure your timezone is correct
* mkdir glow2mqtt
* cd glow2mqtt
* apt install python3-pip
* pip install pyglowmarkt
* apt install mosquitto-clients
* wget https://raw.githubusercontent.com/danmed/Glow2MQTT/main/consumption.sh
* edit consumption.sh to input your credentials.
* chmod a+x consumption.sh


Then run the consumption.sh on a cronjob every... however long you want.. Glow only update every 30 minutes so if you check every 20 you should cover it off pretty well

HA YAML code for MQTT Consumption Sensor : 




```YAML
sensor:

  - platform: mqtt
    name: glow_electric_energy_today
    state_topic: "glowmarkt/electric_consumptiontoday"
    unit_of_measurement: 'kWh'
    device_class: energy
    state_class: total_increasing

  - platform: mqtt
    name: glow_gas_energy_today
    state_topic: "glowmarkt/gas_consumptiontoday"
    unit_of_measurement: 'kWh'
    device_class: energy
    state_class: total_increasing

template:
  sensor:
    - name: Gas Consumption glow
      unit_of_measurement: 'm³'
      state: "{{ states('sensor.glow_gas_energy_today') | float * 3.6 / 40 / 1.02264 }}"
      icon: 'mdi:fire'
      state_class: total_increasing
      device_class: gas
```

HA YAML code for MQTT Cost Sensor : 

```YAML
  - platform: mqtt
    name: glow_electric_cost_today
    state_topic: "glowmarkt/electric_costtoday"
    unit_of_measurement: '£'  
    value_template: "{{ (value | float | round(2)) / 100 }}"
    device_class: energy
    state_class: total_increasing
```
    
![image](https://user-images.githubusercontent.com/3878490/132579305-4641c814-c510-48b5-adb9-2d2fa6a4bfba.png)

![image](https://user-images.githubusercontent.com/3878490/132579214-7fb948ad-1020-4309-ab58-281ed78528db.png)
