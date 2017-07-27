
function init_OLED(sda,scl) --Set up the u8glib lib
     sla = 0x3C
     i2c.setup(0, sda, scl, i2c.SLOW)
     disp = u8g.ssd1306_128x64_i2c(sla)
     disp:setFont(u8g.font_6x10)
     disp:setFontRefHeightExtendedText()
     disp:setDefaultForegroundColor()
     disp:setFontPosTop()
     --disp:setRot180()           -- Rotate Display if needed
end


function print_OLED()
   disp:firstPage()
   repeat
     disp:drawFrame(1,1,127,63)
     disp:drawStr(3, 8, str1)
     disp:drawStr(3, 18, str2)
     disp:drawStr(3, 28, str3)
     disp:drawStr(3, 38, str4)
     disp:drawStr(3, 48, str5)    
   until disp:nextPage() == false
   
end
