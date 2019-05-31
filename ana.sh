#!/bin/bash
#run anaconda
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/home/lizhao/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/lizhao/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/lizhao/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        export PATH="/home/lizhao/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
bash
# <<< conda init <<<
