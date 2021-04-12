/*
 * Copyright (c) 2021 Tuukka Norri
 * This code is licensed under MIT license (see LICENSE for details).
 */

#ifndef PYTHON_BIT_VECTOR_SERIALIZATION_HH
#define PYTHON_BIT_VECTOR_SERIALIZATION_HH

#include <fstream>


namespace python_bit_vector {

	template <typename T>
	void write_to_file(std::ofstream &stream, T const &value)
	{
		value.serialize(stream);
	}

	template <typename T>
	void load_from_file(std::ifstream &stream, T &value)
	{
		value.load(stream);
	}
}

#endif
