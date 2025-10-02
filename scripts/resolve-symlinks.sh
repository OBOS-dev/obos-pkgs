cd $1

res=`git config core.symlinks`
if [[ "$res" == "true" ]]; then
  echo "Skipping symlink resolve, as git has already done it for us"
  exit 0
fi

file_list=`git ls-files -s | awk '$1 ~ /^120000/ {print $4}'`

for file in $file_list; do
  if [[ -f "$file"  && "$file" != *"statfs.h" ]]; then
    link=`cat $file`
    rm $file
    cp -f -- `dirname $file`/$link $file
  fi
done
