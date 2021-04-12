# Copyright (c) 2021 Tuukka Norri
# This code is licensed under MIT license (see LICENSE for details).

from libcpp cimport bool
from libc.stdint cimport uint64_t
from .fstream cimport ifstream, ofstream


cdef extern from "serialization.hh" namespace "python_bit_vector":
	cdef void write_to_file[T](ofstream &stream, const T &value) except +
	cdef void load_from_file[T](ifstream &stream, T &value) except +
