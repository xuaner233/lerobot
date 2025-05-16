#!/bin/bash -x

HF_USER=xuaner233
REPO_ID=${HF_USER}/so100_towel_fold_20250514
RESUME=

# if dataset exists, backup it and resume recording
if [ -d ~/.cache/huggingface/lerobot/${REPO_ID} ]; then
  echo "Backup ~/.cache/huggingface/lerobot/${REPO_ID}"
  rsync -a ~/.cache/huggingface/lerobot/${REPO_ID}/ ~/.cache/huggingface/lerobot/${REPO_ID}_bak
  RESUME="--control.resume=true"
fi


# --control.display_data=true
# Should record > 20 times episode for pi0 fine-tuning
python lerobot/scripts/control_robot.py \
  --robot.type=so100_bimanual \
  --control.type=record \
  --control.play_sounds=false \
  --control.num_image_writer_threads_per_camera=10 \
  --control.fps=30 \
  --control.single_task="Folding the towel" \
  --control.repo_id=${REPO_ID} \
  --control.tags='["so100","towel", "fold"]' \
  --control.warmup_time_s=10 \
  --control.episode_time_s=30 \
  --control.reset_time_s=15 \
  --control.num_episodes=1 \
  --control.push_to_hub=false $RESUME