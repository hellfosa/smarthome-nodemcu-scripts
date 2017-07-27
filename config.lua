--wifi module
wifi_ssid = "test"  
wifi_password = "password_was_here"

--mqtt module
mqtt_broker_ip = "192.168.20.155"  
mqtt_broker_port = 1883  
mqtt_username = ""  
mqtt_password = ""  
mqtt_client_id = ""

--dht module
dht_pin = 4  -- Pin connected to DHT22 sensor  
dht_temp_calc = 0  -- Calculated temperature  
dht_humi_calc = 0  -- Calculated humidity  
mqtt_temp = 0      -- Temperature for publication  
mqtt_humi = 0 -- Humidity for publication
mqtt_co2 = 0 -- CO2 for publication
mqtt_pres = 0

--CO2 module
co2_pin = 3

--sensor reading interval
dsleep_time = 60000 --sleep time in us

--display parameters
sda = 2 -- SDA Pin
scl = 1 -- SCL Pin

--pressure service
OSS = 3 -- oversampling setting (0-3)
SDA_pre = 6 -- sda pin, GPIO2
SCL_pre = 5  -- scl pin, GPIO0

-- Status Message
print("Global variables loaded")  
