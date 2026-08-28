# 章「相互到達成分の商が定める有限半順序」の検算で共有する補助。
# 帰属: 有限集合、有限部分集合、有限写像表、自然数だけを使う。R/C 脱出はない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../neighborhood-assignment-reachability-preorder/_common.sage"))


def component_set(cells, result):
    component_assignment = components(cells, result)
    return tuple(sorted(set(component_assignment), key=lambda value: tuple(sorted(value))))


def component_reaches(result, left, right):
    return any(reachable(result, v, w) for v in left for w in right)


def all_representatives_reach(result, left, right):
    return all(reachable(result, v, w) for v in left for w in right)
