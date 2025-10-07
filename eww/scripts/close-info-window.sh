eww close info -c $1 ; eww open info -c $1 ; sleep 3 && eww close info -c $1 
eww open info -c ${EWW_CONFIG_DIR} && sleep 2 && eww close info -c ${EWW_CONFIG_DIR}