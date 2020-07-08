In this case an experiment is one variation of the model. each `config_*.yml` represents an experiment. to run one experimement on the cluster I did this:

 ```
 nohup snakemake --cluster "sbatch -A iidd -t 02:00:00 -p cpu -N 1 " -p -j 5 --configfile config_[exp_name].yml > nohup_[exp_name].out &
 ```

 so for the `A1` experimement I did

 ```
 nohup snakemake --cluster "sbatch -A iidd -t 02:00:00 -p cpu -N 1 " -p -j 5 --configfile config_a5.yml > nohup_a5.out &
 ```
