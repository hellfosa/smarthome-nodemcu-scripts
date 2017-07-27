FileToExecute="mqtt.lua"
dofile("config.lua")
dofile('oled.lua')
dofile('bmp180.lua')
dofile('co2.lua')
while(carbon == NIL or carbon <= 400)
do 
    str1=" Welcome to RedQueen"
    str2=" Sensors is not "
    str3=" initialized " 
    str4=" Please wait... "
    str5=" " 
    init_OLED(sda,scl)
    print_OLED() 
    break
end
dofile('mqtt.lua')