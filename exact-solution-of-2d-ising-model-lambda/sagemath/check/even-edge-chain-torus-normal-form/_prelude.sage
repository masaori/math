from itertools import product

def add_square(horizontal, vertical, length, row, column):
    horizontal[row, column] ^= 1
    horizontal[(row + 1) % length, column] ^= 1
    vertical[row, column] ^= 1
    vertical[row, (column + 1) % length] ^= 1

def cases():
    for length in (1, 2, 3):
        for bits in product((0, 1), repeat=length * length + 2):
            horizontal = {(i, j): 0 for i in range(length) for j in range(length)}
            vertical = horizontal.copy()
            if bits[0]:
                for j in range(length):
                    horizontal[0, j] ^= 1
            if bits[1]:
                for i in range(length):
                    vertical[i, 0] ^= 1
            for i in range(length):
                for j in range(length):
                    if bits[2 + i * length + j]:
                        add_square(horizontal, vertical, length, i, j)
            yield length, horizontal, vertical

def reduce_vertical(length, horizontal, vertical):
    coefficients = {(i, 0): 0 for i in range(length)}
    for i in range(length):
        for j in range(1, length):
            coefficients[i, j] = (coefficients[i, j - 1] + vertical[i, j]) % 2
    reduced_horizontal = horizontal.copy()
    reduced_vertical = vertical.copy()
    for i in range(length):
        for j in range(length):
            if coefficients[i, j]:
                add_square(reduced_horizontal, reduced_vertical, length, i, j)
    return coefficients, reduced_horizontal, reduced_vertical

def reduce_horizontal(length, horizontal, vertical):
    row_value = {i: horizontal[i, 0] for i in range(length)}
    coefficients = {0: 0}
    for i in range(1, length):
        coefficients[i] = (coefficients[i - 1] + row_value[i]) % 2
    reduced_horizontal = horizontal.copy()
    reduced_vertical = vertical.copy()
    for i in range(length):
        if coefficients[i]:
            for j in range(length):
                add_square(reduced_horizontal, reduced_vertical, length, i, j)
    return coefficients, reduced_horizontal, reduced_vertical
