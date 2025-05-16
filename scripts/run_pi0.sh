#!/bin/bash -x

HF_USER=xuaner233
REPO_ID="${HF_USER}/eval_pi0_so100_test"

if [ -n "$REPO_ID" ]; then
  rm -rf ~/.cache/huggingface/lerobot/${REPO_ID}
fi

# task should be logged here for dataset quick run, and can be refered from dataset:

# |------ trained model ------------- | -------------- task -------------------------- |
# - so100_pi0_pick_cube_20250321      : Grasp a white cube and put it in the bin.
# - so100_pi0_towel_fold_20250522     : Folding the towel
# - so100_pi0_shirt_fold_20250526     : Folding the T-shirt
# |----------------------------------------------------------------------------------- |
CUDA_VISIBLE_DEVICES=1 python lerobot/scripts/control_robot.py \
  --robot.type=so100_bimanual \
  --control.display_data=true \
  --control.type=record \
  --control.num_image_writer_threads_per_camera=10 \
  --control.fps=30 \
  --control.single_task="Folding the T-shirt" \
  --control.repo_id=${REPO_ID} \
  --control.tags='["pi0"]' \
  --control.warmup_time_s=5 \
  --control.episode_time_s=1200 \
  --control.reset_time_s=10 \
  --control.num_episodes=1 \
  --control.push_to_hub=false \
  --control.policy.device=cuda \
  --control.policy.path=outputs/train/so100_pi0_shirt_fold_20250528/checkpoints/last/pretrained_model
