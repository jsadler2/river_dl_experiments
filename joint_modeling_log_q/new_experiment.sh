copy_dir=$1
dest_id=$2
dest_dir=exp_$dest_id

cp -r $copy_dir $dest_dir
rename 's/config_\w\d/config_${dest_id}\d/' $dest_dir/config*.yml
