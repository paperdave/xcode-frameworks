const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addStaticLibrary(.{
        .name = "xcode-frameworks",
        .root_source_file = b.addWriteFiles().add("empty.c", ""),
        .target = target,
        .optimize = optimize,
    });
    lib.root_module.addSystemFrameworkPath(b.path("Frameworks"));
    lib.root_module.addSystemIncludePath(b.path("include"));
    lib.root_module.addLibraryPath(b.path("lib"));
    lib.linkLibC();
    lib.installHeadersDirectory(b.path("include"), ".", .{});
    b.installArtifact(lib);
}
