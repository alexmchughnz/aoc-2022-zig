printf -v day "%02d" $1
dir="./src/day$day"

mkdir $dir
if [ ! -f "$dir/main.rs" ]; then
    cp ./src/template.zig $dir/main.zig
fi
aoc download \
    --year 2022\
    --day $day \
    --input-file $dir/input.txt \
    --puzzle-file $dir/puzzle.md \
    -o