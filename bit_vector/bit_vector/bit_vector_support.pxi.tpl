# Copyright (c) 2018 Tuukka Norri
# This code is licensed under MIT license (see LICENSE for details).

# Generate code for rank and select support.
# Cython does not support templates at the moment.


cdef class BvSupport_${t_name}(object):
	cdef const bit_vector *bv
	cdef ${t_class} support
	
	def __cinit__(self):
		self.bv = NULL
	
	cpdef prepare(self):
		self.support.prepare(deref(self.bv))
	
	cpdef size_type access(self, size_type idx):
		self.support.call(idx)
	
	def __call__(self, idx):
		return self.support.call(int(idx))
