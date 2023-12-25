#!/bin/bash
eval "$(conda shell.bash hook)"
conda activate alpaca_eval

# export OPENAI_API_BASE="https://oa.api2d.net/v1"
# export OPENAI_API_KEY="fk200847-boI4Z4CrBbGnBrdh6LQVi4MtRgQQMe7R"

export OPENAI_API_BASE="https://api.openai-proxy.org/v1"
export OPENAI_API_KEY="sk-gvvyMxkXwFNNh2g94XgZfrwkO024E0yqqd5vatR2t6yHZVWG"

#CONFIG=chatgpt_fn
CONFIG=alpaca_eval_gpt4
MODDEL_CONFIG=./phi-2
#MODDEL_CONFIG=./phi-2-alpaca-gpt4
#MODDEL_CONFIG=./phi-2-ultrachat200K
#MODDEL_CONFIG=./phi-2-alpaca-gpt4-dpo
MODDEL_CONFIG_STR="${MODDEL_CONFIG//./-}"
MODDEL_CONFIG_STR="${MODDEL_CONFIG_STR//\//-}"

OUT_PATH="./output/${CONFIG}_${MODDEL_CONFIG_STR}"

if [ ! -d "${OUT_PATH}" ]; then
    mkdir -p "${OUT_PATH}"
fi

alpaca_eval evaluate_from_model \
    --annotators_config $CONFIG \
    --model_configs "${MODDEL_CONFIG}" \
    --output_path "${OUT_PATH}" \
    |& tee $OUT_PATH/alpaca_eval_log.txt