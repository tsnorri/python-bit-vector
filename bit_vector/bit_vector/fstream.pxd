# Copyright (c) 2021 Tuukka Norri
# This code is licensed under MIT license (see LICENSE for details).

from libcpp.string cimport string


# Cython does not have definitions for these.
cdef extern from "<iostream>" namespace "std":
	cdef cppclass basic_istream[T]:
		pass

	cdef cppclass basic_ostream[T]:
		pass

	ctypedef basic_istream[char] istream

	ctypedef basic_ostream[char] ostream

cdef extern from "<fstream>" namespace "std":
	cdef cppclass ifstream(istream):
		ifstream() except+
		void open(const string &filename) except+

	cdef cppclass ofstream(ostream):
		ofstream() except+
		void open(const string &filename) except+
