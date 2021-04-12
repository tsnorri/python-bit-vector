# Copyright (c) 2018 Tuukka Norri
# This code is licensed under MIT license (see LICENSE for details).

from libcpp cimport bool
from libc.stdint cimport uint64_t


cdef extern from "bit_vector_interface.hh" namespace "python_bit_vector":
	
	# FIXME: I don’t know how to import the types from bit_vector_interface.hh.
	ctypedef uint64_t	size_type
	ctypedef bool		value_type
	
	cdef cppclass bit_vector:
		bit_vector() except +
		bit_vector(size_type size) except +
		bit_vector(size_type size, value_type default) except +
		
		size_type size() const
	
	void assign(bit_vector &dst, size_type idx, value_type val)
	value_type retrieve(const bit_vector &src, size_type idx)
	
	cdef cppclass rank_support_v5[t_pattern, t_pattern_length]:
		rank_support_v5() except +
		rank_support_v5(const bit_vector *bv) except +
		void prepare(const bit_vector &bv) except +
		void set_vector(const bit_vector *bv) except +
		size_type rank(size_type i) const
		size_type call(size_type idx) const
	
	cdef cppclass select_support_mcl[t_pattern, t_pattern_length]:
		select_support_mcl() except +
		select_support_mcl(const bit_vector *bv) except +
		void prepare(const bit_vector &bv) except +
		void set_vector(const bit_vector *bv) except +
		size_type select(size_type i) const
		size_type call(size_type idx) const
