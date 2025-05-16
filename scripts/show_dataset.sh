#!/bin/bash -x

HF_USER=xuaner233
REPO_ID=${HF_USER}/so100_shirt_fold_20250522_bak

python lerobot/scripts/visualize_dataset_html.py --repo-id ${REPO_ID}