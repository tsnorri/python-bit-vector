# python-bit-vector
A simple Python 3 wrapper for SDSL’s bit vectors and rank and select support.

## Build Requirements
* Python 3 (tested with version 3.6.5)
* A C++ compiler (tested with Clang 6)
* Cython (tested with version 0.29)

## Usage Example
```python
from bit_vector import BitVector

# Load a bit vector from a text file (zeros and ones).
k = BitVector()
with open("test.txt", "r") as f:
	k.load_from_text_file(f)

# Useful properties include rank_0, rank_1, select_0, select_1.
# Prepare the select_0 support.
k.select_0.prepare()

# Access the values.
k[0]
k.select_0(1) # Indices are 1-based like in SDSL.
```
