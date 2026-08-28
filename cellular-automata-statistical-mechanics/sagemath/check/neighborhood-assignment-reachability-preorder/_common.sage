# 章「到達前順序と相互到達成分」の検算で共有する補助。
# 帰属: 有限集合、有限部分集合、有限写像表、自然数だけを使う。R/C 脱出はない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../neighborhood-assignment-reachability-closure/_common.sage"))


def reachable(result, source, target):
    return target in result[source]


def mutually_reachable(result, left, right):
    return reachable(result, left, right) and reachable(result, right, left)


def transpose(cells, assignment):
    return tuple(frozenset(source for source in cells if target in assignment[source]) for target in cells)


def pointwise_intersection(left, right):
    return tuple(left[v] & right[v] for v in range(len(left)))


def components(cells, result):
    return pointwise_intersection(result, transpose(cells, result))
