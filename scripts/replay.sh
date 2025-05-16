#!/bin/bash -x

HF_USER=xuaner233
REPO_ID=${HF_USER}/so100_shirt_fold_20250522

python lerobot/scripts/control_robot.py \
  --robot.type=so100_bimanual \
  --control.type=replay \
  --control.fps=30 \
  --control.repo_id=${REPO_ID} \
  --control.episode=0