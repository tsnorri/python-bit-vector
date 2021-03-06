# Copyright (c) 2018 Tuukka Norri
# This code is licensed under MIT license (see LICENSE for details).

# cython: language_level=3

from .bit_vector_interface cimport bit_vector, size_type, value_type, rank_support_v5, select_support_mcl, assign, retrieve
from .util import decode_string
from cython.operator cimport dereference as deref
from libcpp cimport bool
import os

cdef extern from *:
	ctypedef int ZERO	"0"
	ctypedef int ONE	"1"


include "bit_vector_support.pxi"


cdef class BitVector(object):
	cdef bit_vector						bv
	cdef BvSupport_rank_0				rank_0
	cdef BvSupport_rank_1				rank_1
	cdef BvSupport_select_0				select_0
	cdef BvSupport_select_1				select_1
	# 01 and 10 are missing.
	
	def __cinit__(self, size_type size = 0):
		self.bv = bit_vector(size, 0)
		self.rank_0 = BvSupport_rank_0()
		self.rank_1 = BvSupport_rank_1()
		self.select_0 = BvSupport_select_0()
		self.select_1 = BvSupport_select_1()
		
		self.set_bit_vector_pointers()
		
	cpdef void assign(self, size_type idx, value_type val):
		assign(self.bv, idx, val)
	
	cpdef value_type access(self, size_type idx):
		return retrieve(self.bv, idx)
	
	cpdef size_type size(self):
		return self.bv.size()
	
	def __getitem__(self, idx):
		return self.access(int(idx))
	
	def __setitem__(self, idx, val):
		self.assign(int(idx), int(val))
	
	def __len__(self):
		return self.size()
	
	@property
	def rank_0(self):
		return self.rank_0
	
	@property
	def rank_1(self):
		return self.rank_1
	
	@property
	def select_0(self):
		return self.select_0
	
	@property
	def select_1(self):
		return self.select_1
	
	cpdef void set_bit_vector_pointers(self):
		self.rank_0.bv = &self.bv
		self.rank_1.bv = &self.bv
		self.select_0.bv = &self.bv
		self.select_1.bv = &self.bv
	
	cpdef void load_from_text_file(self, object f):
		# Check the size.
		f.seek(0, os.SEEK_END)
		size = f.tell()
		f.seek(0)
	
		self.bv = bit_vector(size, 0)
		self.set_bit_vector_pointers()
		
		# Read the contents. This is rather inefficient, though. A word could be filled at a time, instead.
		idx = 0
		while True:
			c = decode_string(f.read(1))
			if 0 == len(c):
				break
			
			if '1' == c:
				assign(self.bv, idx, 1)
			elif '0' != c:
				break
			
			idx += 1
