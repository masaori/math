# 章「自己近傍舞台の可逆大域写像群」の検算で共有する補助。
# 帰属: 有限集合、有限写像表、自然数、有限多重集合のみ。浮動小数点と R/C 脱出はない。

import itertools
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'locality-restricts-cycle-type', '_common.sage'))


def negation(a):
    """def_negation_map の nu。"""
    return 1 - a


def flip_family(cell_count, flip_set):
    """反転集合 S から自己近傍舞台の局所規則族を作る（各セルは id または nu）。"""
    return tuple((1, 0) if v in flip_set else (0, 1) for v in range(cell_count))


def flip_table(cell_count, flip_set):
    """def_finite_self_neighborhood_flip_map の F_S を大域写像表として作る。"""
    return global_table(flip_family(cell_count, flip_set))


def subsets(cell_count):
    """V = {0,...,cell_count-1} の冪集合を frozenset の組で返す。"""
    cells = range(cell_count)
    return tuple(frozenset(combination)
                 for size in range(cell_count + 1)
                 for combination in itertools.combinations(cells, size))


def compose(table_outer, table_inner):
    """写像の合成 table_outer o table_inner。"""
    return tuple(table_outer[table_inner[point]] for point in range(len(table_inner)))


def identity_table(size):
    return tuple(range(size))


def is_injective(table):
    return len(set(table)) == len(table)
