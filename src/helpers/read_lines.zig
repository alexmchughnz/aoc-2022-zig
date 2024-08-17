const std = @import("std");
const fs = std.fs;
const heap = std.heap;
const mem = std.mem;

const LineIterator = struct {
    allocator: mem.Allocator,
    text: []const u8,
    index: usize = 0,

    fn next(self: *LineIterator) ?[]const u8 {
        const start_index = self.index;
        while (self.text[self.index] != '\n') {
            self.index += 1;
        }

        self.index += 1;
        return self.text[start_index .. self.index - 1];
    }

    fn free(self: LineIterator) void {
        self.allocator.free(self.text);
    }
};

pub fn readLines(allocator: mem.Allocator, path: []const u8) !LineIterator {
    const file = try fs.openFileAbsolute(path, .{});
    defer file.close();

    const size = (try file.stat()).size;
    const text = try file.reader().readAllAlloc(allocator, size);
    const iter = LineIterator{
        .allocator = allocator,
        .text = text,
    };
    return iter;
}

test readLines {
    const path = "/Users/Alex/Developer/advent_of_code/aoc2022/aoc2022-zig/src/helpers/test_read_lines.txt";
    var lines = try readLines(std.testing.allocator, path);
    defer lines.free();

    for (1..6) |i| {
        const line = lines.next().?;
        const char = '0' + i;
        std.debug.print("line = {s}. char = {}.\n", .{ line, char });
        try std.testing.expect(line[0] == char);
    }
}
