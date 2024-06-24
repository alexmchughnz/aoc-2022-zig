printf -v day "%02d" $1
dir="./src/bin/day$day"

mkdir $dir
if [ ! -f "$dir/main.rs" ]; then
    cp ./src/template.rs $dir/main.rs
fi
aoc download --day $day \
    --input-file $dir/input.txt \
    --puzzle-file $dir/puzzle.md \
    -o