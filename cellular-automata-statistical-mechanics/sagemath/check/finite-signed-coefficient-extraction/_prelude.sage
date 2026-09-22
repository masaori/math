from itertools import combinations, permutations, product


def finite_power_set(index_set):
    ordered = tuple(index_set)
    return tuple(
        frozenset(subset)
        for size in range(len(ordered) + 1)
        for subset in combinations(ordered, size)
    )


def zero_table(index_set):
    return {subset: ZZ(0) for subset in finite_power_set(index_set)}


def basis_table(index_set, support):
    support = frozenset(support)
    return {
        subset: ZZ(1) if subset == support else ZZ(0)
        for subset in finite_power_set(index_set)
    }


def scale_table(scalar, table):
    scalar = ZZ(scalar)
    return {support: scalar * coefficient for support, coefficient in table.items()}


def inversion_pairs(left_support, right_support):
    return ZZ(sum(1 for left in left_support for right in right_support if right < left))


def anticommuting_product(index_set, left_table, right_table):
    subsets = finite_power_set(index_set)
    result = zero_table(index_set)
    for union_support in subsets:
        coefficient = ZZ(0)
        for left_support, right_support in product(subsets, repeat=2):
            if left_support.intersection(right_support):
                continue
            if left_support.union(right_support) != union_support:
                continue
            sign = ZZ(-1) ** inversion_pairs(left_support, right_support)
            coefficient += sign * left_table[left_support] * right_table[right_support]
        result[union_support] = coefficient
    return result


def word_inversions(word):
    return ZZ(sum(1 for left in range(len(word)) for right in range(left + 1, len(word)) if word[right] < word[left]))


def word_monomial(index_set, word):
    if len(set(word)) != len(word):
        return zero_table(index_set)
    return scale_table(ZZ(-1) ** word_inversions(word), basis_table(index_set, word))


def top_coefficient(index_set, table):
    return ZZ(table[frozenset(index_set)])


def top_coefficient_matrix(index_set, states, table_family):
    return {
        (source, target): top_coefficient(index_set, table_family[(source, target)])
        for source, target in product(states, repeat=2)
    }


def self_map_indicator_matrix(states, self_map):
    return {
        (source, target): ZZ(1) if target == self_map[source] else ZZ(0)
        for source, target in product(states, repeat=2)
    }
