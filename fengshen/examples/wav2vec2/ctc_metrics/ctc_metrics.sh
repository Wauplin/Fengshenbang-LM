#!/bin/bash

MODEL_PATH="/cognitive_comp/zhuojianheng/pretrained_model/wav2vec2-base-ctc-wenet"
DATA_HOME="/cognitive_comp/zhuojianheng/data/wenet"
CKPT="/cognitive_comp/zhuojianheng/experiment/fengshen-wav2vec2-base-wenet-ctc-tencent/ckpt/hf_pretrained_epoch408_step120000"
DATA_HOME="/cognitive_comp/zhuojianheng/data/wenet"
MODEL_NAME="fengshen_wav2vec2_base"

for DATA_SET in dev test_meeting test_net
do
    python3 inference.py --model_path $MODEL_PATH --ckpt $CKPT --tsv ${DATA_HOME}/${DATA_SET}/data.tsv --wrd ${DATA_HOME}/${DATA_SET}/data.wrd --target ${MODEL_NAME}_${DATA_SET}.tem
    # cp ${DATA_HOME}/${DATA_SET}/data.wrd ${DATA_SET}.wrd
done

for DATA_SET in dev test_meeting test_net
do
    python cer.py --pred ${MODEL_NAME}_${DATA_SET}.tem --label ${DATA_HOME}/${DATA_SET}/data.wrd
done
