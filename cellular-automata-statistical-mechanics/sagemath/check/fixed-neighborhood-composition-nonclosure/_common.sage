# 章「固定近傍による可逆大域写像族の合成非閉性」の検算で共有する補助。
# 帰属: 有限集合、有限写像表、自然数のみ。浮動小数点と R/C 脱出はない。

import itertools

CELL_COUNT = 3          # V = {a, b, c} を {0, 1, 2} で表す
CELL_A, CELL_B, CELL_C = 0, 1, 2


def shift(v):
    """def_three_cell_cyclic_dependency_stage の s。s(a)=b, s(b)=c, s(c)=a。"""
    return (v + 1) % CELL_COUNT


def neighborhood(v):
    """N(v) = {s(v)}。一元集合。"""
    return (shift(v),)


def configurations():
    """A^V の全配位を組で列挙する。"""
    return tuple(itertools.product((0, 1), repeat=CELL_COUNT))


CONFIGS = configurations()
INDEX = {config: position for position, config in enumerate(CONFIGS)}


def shift_global_table():
    """def_three_cell_cyclic_dependency_stage の F を大域写像表として作る。"""
    return tuple(INDEX[tuple(config[shift(v)] for v in range(CELL_COUNT))]
                 for config in CONFIGS)


def compose(table_outer, table_inner):
    return tuple(table_outer[table_inner[point]] for point in range(len(table_inner)))


def identity_table():
    return tuple(range(len(CONFIGS)))


def unary_rules():
    """一元近傍上の局所規則 A -> A の四つの真理値表を (g(0), g(1)) で表す。"""
    return tuple(itertools.product((0, 1), repeat=2))


def fixed_neighborhood_global_tables():
    """N で表せる大域写像 M(V, N) を全て作る。各セル v は N(v) の唯一の元を読む。"""
    tables = {}
    for family in itertools.product(unary_rules(), repeat=CELL_COUNT):
        table = tuple(INDEX[tuple(family[v][config[neighborhood(v)[0]]] for v in range(CELL_COUNT))]
                      for config in CONFIGS)
        tables[table] = family
    return tables


def flip(config, w):
    """def_flip_map の一点反転写像 phi_w。"""
    return tuple(1 - value if v == w else value for v, value in enumerate(config))


def coordinate_map(table, v):
    """大域写像表の v 座標写像 x |-> (table x)(v) を配位ごとの値として返す。"""
    return tuple(CONFIGS[table[INDEX[config]]][v] for config in CONFIGS)


def support(value_map):
    """def_essential_dependency_support の supp。一点反転検査で決定する。"""
    return frozenset(w for w in range(CELL_COUNT)
                     if any(value_map[INDEX[config]] != value_map[INDEX[flip(config, w)]]
                            for config in CONFIGS))
