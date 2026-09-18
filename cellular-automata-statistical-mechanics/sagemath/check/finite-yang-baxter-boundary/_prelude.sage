from itertools import product


def pair_index(size, left, right):
    return ZZ(left) * ZZ(size) + ZZ(right)


def index_pair(size, index):
    return (ZZ(index) // ZZ(size), ZZ(index) % ZZ(size))


def pair_value(table, size, left, right):
    return index_pair(size, table[pair_index(size, left, right)])


def adjacent_12(table, size, triple):
    first, second = pair_value(table, size, triple[0], triple[1])
    return (first, second, ZZ(triple[2]))


def adjacent_23(table, size, triple):
    second, third = pair_value(table, size, triple[1], triple[2])
    return (ZZ(triple[0]), second, third)


def nonadjacent_13(table, size, triple):
    first, third = pair_value(table, size, triple[0], triple[2])
    return (first, ZZ(triple[1]), third)


def braid_left(table, size, triple):
    return adjacent_12(table, size, adjacent_23(table, size, adjacent_12(table, size, triple)))


def braid_right(table, size, triple):
    return adjacent_23(table, size, adjacent_12(table, size, adjacent_23(table, size, triple)))


def yang_baxter_left(table, size, triple):
    return adjacent_12(table, size, nonadjacent_13(table, size, adjacent_23(table, size, triple)))


def yang_baxter_right(table, size, triple):
    return adjacent_23(table, size, nonadjacent_13(table, size, adjacent_12(table, size, triple)))


def all_triples(size):
    return tuple(product(range(size), repeat=3))


def satisfies_braid(table, size):
    return all(braid_left(table, size, triple) == braid_right(table, size, triple) for triple in all_triples(size))


def satisfies_yang_baxter(table, size):
    return all(
        yang_baxter_left(table, size, triple) == yang_baxter_right(table, size, triple)
        for triple in all_triples(size)
    )


def swap_after(table, size):
    swapped = []
    for left in range(size):
        for right in range(size):
            out_left, out_right = pair_value(table, size, left, right)
            swapped.append(pair_index(size, out_right, out_left))
    return tuple(swapped)


def swap_table(size):
    return tuple(pair_index(size, right, left) for left in range(size) for right in range(size))


def pair_linearization_matrix(table, size, ring=QQ):
    dimension = size * size
    return matrix(
        ring,
        dimension,
        dimension,
        lambda target, source: ring.one() if target == table[source] else ring.zero(),
    )


def triple_index(size, triple):
    return ZZ(triple[0]) * ZZ(size) ** 2 + ZZ(triple[1]) * ZZ(size) + ZZ(triple[2])


def triple_action_matrix(size, action, ring=QQ):
    dimension = size ** 3
    return matrix(
        ring,
        dimension,
        dimension,
        lambda target, source: ring.one()
        if target == triple_index(size, action(index_pair(size, source // size) + (ZZ(source) % ZZ(size),)))
        else ring.zero(),
    )
