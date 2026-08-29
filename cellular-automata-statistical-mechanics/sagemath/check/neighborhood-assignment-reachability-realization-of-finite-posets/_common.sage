# 章「有限半順序の相互到達成分商としての実現」の検算で共有する補助。
# 帰属: 有限集合、有限関係、有限写像表、自然数だけを使う。R/C 脱出はない。

import itertools
import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../neighborhood-assignment-reachability-quotient-order/_common.sage"))


def is_partial_order(cells, relation):
    reflexive = all((v, v) in relation for v in cells)
    antisymmetric = all(
        v == w or not ((v, w) in relation and (w, v) in relation)
        for v in cells for w in cells
    )
    transitive = all(
        (v, w) not in relation or (w, u) not in relation or (v, u) in relation
        for v in cells for w in cells for u in cells
    )
    return reflexive and antisymmetric and transitive


def partial_orders(cells):
    diagonal = frozenset((v, v) for v in cells)
    off_diagonal = tuple((v, w) for v in cells for w in cells if v != w)
    for bits in itertools.product((False, True), repeat=len(off_diagonal)):
        relation = diagonal | frozenset(
            pair for pair, included in zip(off_diagonal, bits) if included
        )
        if is_partial_order(cells, relation):
            yield relation


def assignment_from_relation(cells, relation):
    return tuple(frozenset(w for w in cells if (v, w) in relation) for v in cells)


def singleton_quotient(cells):
    return tuple(frozenset((v,)) for v in cells)


def quotient_order(result, left, right):
    return any(reachable(result, v, w) for v in left for w in right)
