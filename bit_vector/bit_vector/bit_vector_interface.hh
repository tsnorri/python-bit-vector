/*
 * Copyright (c) 2018 Tuukka Norri
 * This code is licensed under MIT license (see LICENSE for details).
 */

#ifndef PYTHON_BIT_VECTOR_BIT_VECTOR_INTERFACE
#define PYTHON_BIT_VECTOR_BIT_VECTOR_INTERFACE

#include <sdsl/int_vector.hpp>
#include <sdsl/rank_support_v5.hpp>
#include <sdsl/select_support_mcl.hpp>
#include <type_traits>


namespace python_bit_vector {
	
	// Make typedefs and operators more easily accessible from Cython.
	typedef sdsl::bit_vector				bit_vector;
	typedef bit_vector::size_type			size_type;
	typedef bool							value_type;
	
	inline void assign(bit_vector &dst, size_type idx, value_type val) { dst[idx] = val; }
	inline value_type retrieve(bit_vector const &src, size_type idx) { return src[idx]; }
	
	
	template <std::uint8_t t_pattern, std::uint8_t t_patlen>
	struct rank_support_v5 : public sdsl::rank_support_v5 <t_pattern, t_patlen>
	{
		using sdsl::rank_support_v5 <t_pattern, t_patlen>::rank_support_v5;
		
		void prepare(bit_vector const &bv) { rank_support_v5 temp(&bv); this->operator=(std::move(temp)); }
		size_type call(size_type idx) const { return this->rank(idx); }
	};
	
	
	template <std::uint8_t t_pattern, std::uint8_t t_patlen>
	struct select_support_mcl : public sdsl::select_support_mcl <t_pattern, t_patlen>
	{
		using sdsl::select_support_mcl <t_pattern, t_patlen>::select_support_mcl;
		
		void prepare(bit_vector const &bv) { select_support_mcl temp(&bv); this->operator=(std::move(temp)); }
		size_type call(size_type idx) const { return this->select(idx); }
	};
}

#endif
