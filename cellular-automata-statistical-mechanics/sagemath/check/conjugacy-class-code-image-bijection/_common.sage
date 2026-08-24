# 章「共役類の集合と写像符号の像の全単射」の検算で共有する補助。
# 帰属: 有限集合、有限写像表、有限置換、有限列・有限集合・有限多重集合の等号だけを使う。
# 浮動小数点と R/C 脱出はない。

import itertools
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '..', 'recursive-preimage-tree-code', '_common.sage'))


def maps_by_size():
    """元数 1・2・4 の配位集合上の全自己写像を元数ごとに返す。"""
    result = {}
    for table in all_self_map_instances():
        result.setdefault(len(table), []).append(table)
    return {size: tuple(tables) for size, tables in result.items()}


def conjugate_table(table, permutation):
    """h F h^{-1} の写像表。"""
    inverse = [None] * len(permutation)
    for source, target in enumerate(permutation):
        inverse[target] = source
    return tuple(permutation[table[inverse[y]]] for y in range(len(table)))


def conjugacy_class(table):
    """有限置換の全数走査で得る table の共役類。"""
    return frozenset(
        conjugate_table(table, permutation)
        for permutation in itertools.permutations(range(len(table)))
    )


def quotient_classes(tables):
    """全自己写像表を共役類へ一度ずつ分割する。"""
    remaining = set(tables)
    classes = []
    while remaining:
        representative = min(remaining)
        cls = conjugacy_class(representative)
        assert cls <= set(tables)
        classes.append(cls)
        remaining -= cls
    return tuple(classes)
