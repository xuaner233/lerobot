#!/bin/bash -x

HF_USER=xuaner233
REPO_ID=${HF_USER}/so100_towel_fold_20250521

python lerobot/scripts/visualize_dataset_html.py --repo-id ${REPO_ID}