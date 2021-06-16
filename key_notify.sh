#!/bin/env bash
get_data() {
    case $1 in
        "Brightness")
            echo $(xbacklight -get)
            ;;
        "Volume")
            if [[ $(pamixer --get-mute) = 'true' ]]
            then
                echo "'Muted'"
            else
                echo $(pamixer --get-volume)
            fi
            ;;
        "Mic")
            pacmd_dump=$(pacmd dump)
            default_source=$(awk '/default-source/{print $2}' <(echo "${pacmd_dump}"))
            muted=$(awk "/${default_source}/ && /mute/ {print \$3}" <(echo "${pacmd_dump}"))
            if [[ $muted = 'yes' ]]
            then
                echo "'Muted'"
            else
                echo "'Unmuted'"
            fi
            ;;
        "Player")
            sleep 0.1
            if [[ $(playerctl status) = 'Paused' ]]
            then
                echo "'Paused'"
            else
                echo "'$(playerctl metadata --format '{{artist}} - {{title}}')'"
            fi
            ;;

        *)
            echo "'Data not available'"
            ;;
    esac
}

out=$(get_data "$1")
echo "notify('${1}: ', ${out})"

