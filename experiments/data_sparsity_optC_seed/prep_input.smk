data_dir = "/home/jsadler/drb-dl-model/data/in"

def get_prev_reduction(current_reduction):
    exps = config['flow_reductions']
    idx = exps.index(current_reduction)
    prev_exp_idx = idx+1
    prev_exp_val = exps[prev_exp_idx]
    return prev_exp_idx, prev_exp_val

def get_input_file(wildcards):
    current_flow_red = float(wildcards.flow_red)
    if current_flow_red > 0:
        prev_idx, prev_val = get_prev_reduction(current_flow_red)
        input_file = f"{wildcards.outdir}/temp_red_{wildcards.temp_red}/{wildcards.run_id}/flow_red_{prev_val}/reduced_flow"
    else:
        input_file = f'{data_dir}/obs_flow_subset'
    return input_file

def get_reduce_val(wildcards):
    current_reduction = float(wildcards.flow_red)
    if current_reduction == 0:
        reduce_val = current_reduction
    else:
        prev_idx, prev_val = get_prev_reduction(current_reduction)
        reduce_val = 1 - (1 - current_reduction)/(1 - prev_val)
    return reduce_val


rule sparsify_temp:
    input:
        f"{data_dir}/obs_temp_subset"
    output:
        directory("{outdir}/temp_red_{temp_red}/{run_id}/reduced_temp")
    run:
        reduce_training_data(input[0], train_start_date, train_end_date, float(wildcards.temp_red), output[0])


rule sparsify_flow:
    input:
        get_input_file
    output:
        directory("{outdir}/temp_red_{temp_red}/{run_id}/flow_red_{flow_red}/reduced_flow")
    params:
        reduce_val = get_reduce_val
    run:
        reduce_training_data(input[0], train_start_date, train_end_date, params.reduce_val, output[0])
        
