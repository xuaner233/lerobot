#!/bin/bash -x

python lerobot/scripts/control_robot.py --robot.type=so100_bimanual --control.display_data=true --control.type=teleoperate
