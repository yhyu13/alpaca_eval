#!/bin/bash
eval "$(conda shell.bash hook)"
conda activate alpaca_eval

# export OPENAI_API_BASE="https://oa.api2d.net/v1"
# export OPENAI_API_KEY="fk200847-boI4Z4CrBbGnBrdh6LQVi4MtRgQQMe7R"

export OPENAI_API_BASE="https://api.openai-proxy.org/v1"
export OPENAI_API_KEY="sk-gvvyMxkXwFNNh2g94XgZfrwkO024E0yqqd5vatR2t6yHZVWG"

#CONFIG=chatgpt_fn
CONFIG=alpaca_eval_gpt4
#MODDEL_OUTPUTS=./example/outputs_simple.json
MODDEL_OUTPUTS=./output/chatgpt_fn_--LMCocktail-10.7B-v1/model_outputs.json
MODDEL_OUTPUTS_STR="${MODDEL_OUTPUTS//./-}"
MODDEL_OUTPUTS_STR="${MODDEL_OUTPUTS_STR//\//-}"

OUT_PATH="./output/${CONFIG}_--LMCocktail-10.7B-v1-eval"

if [ ! -d "${OUT_PATH}" ]; then
    mkdir -p "${OUT_PATH}"
fi

alpaca_eval \
    --annotators_config $CONFIG \
    --model_outputs "${MODDEL_OUTPUTS}" \
    --output_path "${OUT_PATH}" \
    |& tee $OUT_PATH/alpaca_eval_log.txt