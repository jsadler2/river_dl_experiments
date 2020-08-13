experiment=$1
echo $experiment
 
nohup snakemake --cluster "sbatch -A iidd -t 03:00:00 -p gpu -N 1 --gres gpu:1" -p -j 5 --configfile config_${experiment}.yml > nohup_${experiment}.out &
