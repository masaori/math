# 周期境界で重なるオフセット入力と一様規則表の検算で共有する有限定義。
# 全て有限集合・有限写像表・ZZ の剰余・NN の個数だけで閉じる。

import itertools


def offsets(radius):
    return tuple(range(-radius, radius + 1))


def cells(length):
    return tuple(range(length))


def projection(length, vertex, offset):
    return (vertex + offset) % length


def projected_neighborhood(length, radius, vertex):
    return tuple(sorted({projection(length, vertex, j) for j in offsets(radius)}))


def bit_assignments(domain):
    domain = tuple(domain)
    return tuple(tuple(bits) for bits in itertools.product((0, 1), repeat=len(domain)))


def admissible_inputs(length, radius):
    domain = offsets(radius)
    out = []
    for argument in bit_assignments(domain):
        values = dict(zip(domain, argument))
        if all(projection(length, 0, j) != projection(length, 0, k) or values[j] == values[k]
               for j in domain for k in domain):
            out.append(argument)
    return tuple(out)


def pullback(length, radius, vertex, neighborhood_values):
    neighborhood = projected_neighborhood(length, radius, vertex)
    values = dict(zip(neighborhood, neighborhood_values))
    return tuple(values[projection(length, vertex, j)] for j in offsets(radius))


def configuration_input(configuration, length, radius, vertex):
    return tuple(configuration[projection(length, vertex, j)] for j in offsets(radius))


def truth_tables(radius):
    arguments = bit_assignments(offsets(radius))
    return tuple(tuple(values) for values in itertools.product((0, 1), repeat=len(arguments)))


def table_value(table, argument, radius):
    arguments = bit_assignments(offsets(radius))
    return table[arguments.index(tuple(argument))]


def global_map_table(table, length, radius):
    configurations = bit_assignments(cells(length))
    return tuple(
        tuple(table_value(table, configuration_input(configuration, length, radius, vertex), radius)
              for vertex in cells(length))
        for configuration in configurations
    )


def elementary_table(rule_number):
    arguments = bit_assignments(offsets(1))
    return tuple((rule_number >> (4 * a[0] + 2 * a[1] + a[2])) & 1 for a in arguments)

