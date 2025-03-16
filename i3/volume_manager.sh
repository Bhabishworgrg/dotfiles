#!/bin/bash

volume="$(pactl get-sink-volume @DEFAULT_SINK@ | grep -o '[0-9]*%' | head -n1)"

case $1 in
    up)
		if [ "${volume%?}" -eq 99 ]; then
			pactl set-sink-volume @DEFAULT_SINK@ 100%
		elif [ "${volume%?}" -ne 100 ]; then
			pactl set-sink-volume @DEFAULT_SINK@ +2%
		fi
		notify-send "Volume" -h int:value:${volume%?} -h string:synchronous:download -u low -i /usr/share/icons/Adwaita/symbolic/status/audio-volume-high-symbolic.svg
	;;
    down)
		pactl set-sink-volume @DEFAULT_SINK@ -2%
		notify-send "Volume" -h int:value:${volume%?} -h string:synchronous:download -u low -i /usr/share/icons/Adwaita/symbolic/status/audio-volume-low-symbolic.svg
	;;
    mute)
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		if [ $(pactl get-sink-mute @DEFAULT_SINK@ | cut -d' ' -f2) = "yes" ]; then
			notify-send "Volume" "MUTED" -h string:synchronous:download -u low -i /usr/share/icons/Adwaita/symbolic/status/audio-volume-muted-symbolic.svg
		else
			notify-send "Volume" "UNMUTED" -h string:synchronous:download -u low -i /usr/share/icons/Adwaita/symbolic/status/audio-volume-medium-symbolic.svg
		fi
	;;
esac
