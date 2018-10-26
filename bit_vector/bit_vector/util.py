# Copyright (c) 2018 Tuukka Norri
# This code is licensed under MIT license (see LICENSE for details).

from functools import singledispatch


# Handle both strings and bytes-like objects.

@singledispatch
def decode_string(data):
	return str(data, "UTF-8")

@decode_string.register(str)
def _(data):
	return data
