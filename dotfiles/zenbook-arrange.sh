# Bottom screen IDs

BS_IDS=$(xinput --list | grep ELAN9009 | awk -F"id=" '{print $2}' | awk '{print $1}')
TS_IDS=$(xinput --list | grep ELAN9008 | awk -F"id=" '{print $2}' | awk '{print $1}')

TS_MAT='1 0 0 0 1 0 0 0 1'
BS_MAT='0.529411764705882 0 0 0 0.291497975708502 0.708502024291498 0 0 1'

echo Top screen IDs:
echo ${TS_IDS}
echo Bottom screen IDs:
echo ${BS_IDS}

# libinput calibration matrix needs to be identity matrix
for id in ${BS_IDS}
do
	xinput --set-prop ${id} --type=float "Coordinate Transformation Matrix" ${TS_MAT}
	xinput --map-to-output ${id} DP-1
	#xinput --set-prop ${id} --type=float "Coordinate Transformation Matrix" ${BS_MAT}
done

for id in ${TS_IDS}
do
	xinput --set-prop ${id} --type=float "Coordinate Transformation Matrix" ${TS_MAT}
	xinput --map-to-output ${id} eDP-1
	#xinput --set-prop ${id} --type=float "Coordinate Transformation Matrix" ${TS_MAT}
done


exit
## Bottom screen


xinput --map-to-output 'ELAN9009:00 04F3:2F2A' DP-1
xinput --set-prop 'ELAN9009:00 04F3:2F2A' --type=float "Coordinate Transformation Matrix" ${mat}
#xinput --set-prop 'ELAN9009:00 04F3:2F2A Stylus' --type=float "Coordinate Transformation Matrix" ${mat}
xinput --map-to-output 'ELAN9009:00 04F3:2F2A Stylus Pen (0)' DP-1
xinput --map-to-output 'ELAN9009:00 04F3:2F2A Stylus Eraser (0)' DP-1

## Top screen
xinput --map-to-output 'ELAN9008:00 04F3:2F29' eDP-1
xinput --map-to-output 'ELAN9008:00 04F3:2F29 Stylus' eDP-1
xinput --map-to-output 'ELAN9008:00 04F3:2F29 Stylus Pen (0)' eDP-1
xinput --map-to-output 'ELAN9008:00 04F3:2F29 Stylus Eraser (0)' eDP-1
exit
