# run all the config files in a directory
# usage `sh run_all.sh path/Snakefile path/exp_A`
snakefile=$1
experiment_dir=$2
echo $experiment_dir

for filename in $experiment_dir/config_*.yml; do
    echo running $filename model
    out_name="${filename%.yml}.out"
    nohup snakemake --cluster "sbatch -A iidd -t 03:00:00 -p gpu -N 1 --gres gpu:1" -s $snakefile -p -j 5 --configfile $filename > $out_name &
done

