from vunit.verilog import VUnit

vu = VUnit.from_argv()

vu.add_verilog_builtins()

prj = vu.add_library("prj")
prj.add_source_files("*.sv")

vu.main()