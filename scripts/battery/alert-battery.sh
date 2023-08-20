#!/bin/sh
bat_files="/sys/class/power_supply/BAT1"
bat_status=$(cat "${bat_files}/status")
capacity=$(cat "${bat_files}/capacity")




if [[ ${bat_status} == "Discharging" && ${capacity} -lt	28 && ${capacity} -gt 15 ]]; then
    echo "Battery alert - ${capacity}%"
    notify-send  "Low Battery Level" "Only ${capacity} left" --icon=/config/battery/low-battery.png --urgency normal
fi




if [[ ${bat_status} == "Discharging" && ${capacity} -lt 15 ]]; then
	    echo "Battery alert - ${capacity}%"
	    notify-send  "Low Battery Level" "Only ${capacity}" --icon=/config/battery/low-battery.png --urgency critical
		sleep 60
    /config/battery/alert-battery.sh
fi




if [[ ${capacity} -gt 98 ]]; then
	    echo "Battery alert - ${capacity}%"
	    notify-send  "Battery full" --icon=/config/battery/full-battery.png --urgency low
fi

echo $capacity
notify-send "test"
sleep 20
/config/battery/alert-battery.sh
