# 章「有限半順序の被覆関係と被覆近傍割り当てによる生成」の検算で共有する補助。
# 帰属: 有限集合、有限関係、有限写像表、自然数だけを使う。R/C 脱出はない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../neighborhood-assignment-reachability-realization-of-finite-posets/_common.sage"))


def order_interval(cells, relation, v, w):
    return frozenset(u for u in cells if (v, u) in relation and (u, w) in relation)


def covering_relation(cells, relation):
    return frozenset(
        (v, w)
        for v in cells
        for w in cells
        if (v, w) in relation
        and v != w
        and order_interval(cells, relation, v, w) == frozenset((v, w))
    )


def covering_assignment(cells, relation):
    covers = covering_relation(cells, relation)
    return tuple(frozenset(w for w in cells if (v, w) in covers) for v in cells)
