# 群構造を持たない二セル舞台の有限反例に共通する定義。
# 全て有限集合・有限写像・ZZ で閉じる。

import itertools


CELLS = frozenset(('u', 'v'))
STATES = (0, 1)
NEIGHBORHOODS = {
    'u': frozenset(('u',)),
    'v': frozenset(('u', 'v')),
}
SWAP = {'u': 'v', 'v': 'u'}


def image(mapping, subset):
    return frozenset(mapping[element] for element in subset)


def local_inputs(neighborhood):
    ordered_neighborhood = tuple(sorted(neighborhood))
    return tuple(
        tuple(zip(ordered_neighborhood, values))
        for values in itertools.product(STATES, repeat=len(ordered_neighborhood))
    )

