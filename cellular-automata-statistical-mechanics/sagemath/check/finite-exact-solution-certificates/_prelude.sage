from itertools import product


def pair_index(size, left, right):
    return ZZ(left) * ZZ(size) + ZZ(right)


def index_pair(size, index):
    return (ZZ(index) // ZZ(size), ZZ(index) % ZZ(size))


def pair_value(table, size, left, right):
    return index_pair(size, table[pair_index(size, left, right)])


def left_slice(table, size, left):
    return tuple(pair_value(table, size, left, right)[0] for right in range(size))


def right_slice(table, size, right):
    return tuple(pair_value(table, size, left, right)[1] for left in range(size))


def has_distinct_values(values):
    return len(set(values)) == len(values)


def is_classically_nondegenerate(table, size):
    return all(has_distinct_values(left_slice(table, size, left)) for left in range(size)) and all(
        has_distinct_values(right_slice(table, size, right)) for right in range(size)
    )


def adjacent_12(table, size, triple):
    first, second = pair_value(table, size, triple[0], triple[1])
    return (first, second, ZZ(triple[2]))


def adjacent_23(table, size, triple):
    second, third = pair_value(table, size, triple[1], triple[2])
    return (ZZ(triple[0]), second, third)


def braid_left(table, size, triple):
    return adjacent_12(table, size, adjacent_23(table, size, adjacent_12(table, size, triple)))


def braid_right(table, size, triple):
    return adjacent_23(table, size, adjacent_12(table, size, adjacent_23(table, size, triple)))


def all_triples(size):
    return tuple(product(range(size), repeat=3))
