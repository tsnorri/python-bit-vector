# Copyright (c) 2018–2021 Tuukka Norri
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

	cdef load_from_file(self, ifstream &stream):
		load_from_file(stream, self.support)
		self.support.set_vector(self.bv)
	
	cdef write_to_file(self, ofstream &stream):
		write_to_file(stream, self.support)
