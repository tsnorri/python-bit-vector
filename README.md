# python-bit-vector
A simple Python 3 wrapper for SDSL’s bit vectors and rank and select support.

## Build Requirements
* Python 3 (tested with version 3.6.5)
* A C++ compiler (tested with Clang 6)
* Cython (tested with version 0.29)

## Usage Example
```python
from bit_vector import BitVector

# Create a bit vector.
k = BitVector(5)
k[1] = True
k[3] = True

# Useful properties include rank_0, rank_1, select_0, select_1.
# Prepare the select_1 support.
k.select_1.prepare()

# Access the values. Currently, no bounds checking is performed.
for i in range(5):
	print(k[i])

print(k.select_1(1)) # Indices for rank and select are 1-based like in SDSL.
print(k.select_1(2))
```
