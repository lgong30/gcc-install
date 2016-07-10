#!/usr/bin/python

import ctypes
so_name = "/usr/lib/x86_64-linux-gnu/libgmp.so.10"
var_name = "__gmp_version"
L = ctypes.cdll.LoadLibrary(so_name)
v = ctypes.c_char_p.in_dll(L,var_name)
print v.value