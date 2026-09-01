"""共通辺と単純通過辺を固定した偶部分グラフ対の全単射を厳密検査する。

対象: claim_even_subgraph_pair_fiber_bijection。
一辺 L=2 のトーラスで、互いに素な D,E のうち E が偶部分グラフであるものを
全列挙する。偶部分グラフ対 (A,B) で A∩B=D, A△B=E を満たすものと、
C⊆E で D∪C が偶部分グラフであるものを作り、本文の写像と逆写像を検査する。
"""

load("sagemath/check/torus-kac-ward-even-subgraph-square/check.sage")


def base_endpoints(L, base):
    kind, i, j = base
    return ((i, j), (i, (j + 1) % L)) if kind == "h" else ((i, j), ((i + 1) % L, j))


def is_even(L, subset):
    vertices = [(i, j) for i in range(L) for j in range(L)]
    return all(sum(1 for edge in subset for endpoint in base_endpoints(L, edge)
                   if endpoint == vertex) % 2 == 0 for vertex in vertices)


L = 2
bases = base_edges(L)
subsets = [{bases[index] for index in range(len(bases)) if (mask >> index) & 1}
           for mask in range(2 ** len(bases))]
even_sets = [subset for subset in subsets if is_even(L, subset)]

data_count = 0
pair_count = 0
selector_count = 0

for D in subsets:
    for E in even_sets:
        if D & E:
            continue
        data_count += 1
        pairs = [(A, B) for A in even_sets for B in even_sets
                 if A & B == D and A.symmetric_difference(B) == E]
        selectors = [C for C in subsets if C <= E and is_even(L, D | C)]

        forward = [(A - D) for A, _ in pairs]
        backward = [(D | C, D | (E - C)) for C in selectors]

        assert all(C <= E and is_even(L, D | C) for C in forward)
        assert all(is_even(L, A) and is_even(L, B)
                   and A & B == D and A.symmetric_difference(B) == E
                   for A, B in backward)
        assert len({frozenset(C) for C in forward}) == len(pairs)
        assert {(frozenset(A), frozenset(B)) for A, B in backward} == {
            (frozenset(A), frozenset(B)) for A, B in pairs}
        assert len(pairs) == len(selectors)
        pair_count += len(pairs)
        selector_count += len(selectors)

print("PASS: disjoint (D,E) data =", data_count)
print("PASS: even-subgraph pairs =", pair_count)
print("PASS: selectors =", selector_count)
print("PASS: pair fiber bijection (L = 2)")
