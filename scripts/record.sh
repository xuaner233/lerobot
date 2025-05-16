#!/bin/bash -x

HF_USER=xuaner233
REPO_ID=${HF_USER}/so100_shirt_fold_20250528
DATASET_DIR="${HOME}/.cache/huggingface/lerobot/${REPO_ID}"
RESUME=

# if dataset exists, backup it and resume recording
if [ -d ${DATASET_DIR} ]; then
  echo "Backup ${DATASET_DIR}"
  rsync -a ${DATASET_DIR}/ ${DATASET_DIR}_bak/
  RESUME="--control.resume=true"
elif [ -d ${DATASET_DIR}_bak ]; then
  echo "restore from last backup dir: ${DATASET_DIR}_bak"
  cp -a ${DATASET_DIR}_bak ${DATASET_DIR}
fi


# --control.display_data=true
# Should record >= 30 times episode for pi0 fine-tuning
python lerobot/scripts/control_robot.py \
  --robot.type=so100_bimanual \
  --control.type=record \
  --control.play_sounds=false \
  --control.num_image_writer_threads_per_camera=10 \
  --control.fps=30 \
  --control.single_task="Folding the T-shirt" \
  --control.repo_id=${REPO_ID} \
  --control.tags='["so100","shirt", "fold"]' \
  --control.warmup_time_s=10 \
  --control.episode_time_s=100 \
  --control.reset_time_s=15 \
  --control.num_episodes=1 \
  --control.push_to_hub=false $RESUME