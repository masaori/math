# 対象ラベル: claim_reversal_matrix_determinant_one / def_integer_matrix_determinant
# 添字は向き付き辺 (e,d)。行列成分、符号、有限和・有限積は ZZ。
from itertools import permutations


def directed_edges(L):
    return tuple((e, d) for e in range(1, 2 * L * L + 1) for d in (0, 1))


def reversal(edge):
    e, d = edge
    return (e, 1 - d)


def swap_image(e, edge):
    return reversal(edge) if edge[0] == e else edge


def compose(left, right):
    return tuple(left[right[k]] for k in range(len(right)))


@cached_function
def sign(permutation):
    inversions = sum(ZZ(permutation[i] > permutation[j])
                     for i in range(len(permutation))
                     for j in range(i + 1, len(permutation)))
    return ZZ(-1) ** inversions


@cached_function
def data(L):
    directed = directed_edges(L)
    positions = {edge: k for k, edge in enumerate(directed)}
    reverse = tuple(positions[reversal(edge)] for edge in directed)
    swaps = tuple(tuple(positions[swap_image(e, edge)] for edge in directed)
                  for e in range(1, 2 * L * L + 1))
    composite = tuple(range(len(directed)))
    for swap in swaps:
        composite = compose(swap, composite)
    J = matrix(ZZ, len(directed), len(directed),
               lambda i, j: ZZ(directed[j] == reversal(directed[i])))
    J.set_immutable()
    return directed, reverse, swaps, composite, J


def selected_permutations(L):
    directed, reverse, swaps, composite, J = data(L)
    n = len(directed)
    if L == 1:
        return tuple(permutations(range(n)))
    selected = {reverse}
    selected.update(tuple((k + shift) % n for k in range(n)) for shift in range(n))
    for k in range(n - 1):
        adjacent_swap = list(range(n))
        adjacent_swap[k], adjacent_swap[k + 1] = adjacent_swap[k + 1], adjacent_swap[k]
        selected.add(compose(tuple(adjacent_swap), reverse))
    return tuple(sorted(selected))


def row_product(J, permutation):
    return prod(J[i, permutation[i]] for i in range(J.nrows()))


def weighted_term(J, permutation):
    return sign(permutation) * row_product(J, permutation)


def nonzero_permutations(J):
    # 行ごとの非零列をすべて選び、列が重複しない枝だけを列挙する。
    # 省いた枝には零成分が含まれるので、その Leibniz 項は零である。
    supports = tuple(tuple(j for j in range(J.ncols()) if J[i, j] != 0)
                     for i in range(J.nrows()))
    partial = [((), frozenset())]
    for support in supports:
        partial = [(image + (j,), used | {j})
                   for image, used in partial for j in support if j not in used]
    return tuple(image for image, used in partial)


def leibniz_sum(L):
    directed, reverse, swaps, composite, J = data(L)
    terms = tuple(permutations(range(len(directed)))) if L == 1 else nonzero_permutations(J)
    return sum((weighted_term(J, permutation) for permutation in terms), ZZ(0))


def mismatch_cases():
    for L in range(1, 6):
        directed, reverse, swaps, composite, J = data(L)
        for permutation in selected_permutations(L):
            if permutation != reverse:
                witness = next(i for i in range(len(directed)) if permutation[i] != reverse[i])
                yield L, J, permutation, witness
