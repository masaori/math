"""偶部分グラフ順序対の母関数の層別を厳密検査する。

対象: claim_even_subgraph_pair_stratified_count。
一辺 L=2 のトーラスで、偶部分グラフの順序対 (A,B) の母関数
Σ x^{|A|+|B|} が、互いに素で E が偶部分グラフの添字 (D,E) ごとの
選択集合の個数 |C_L(D,E)| による層別
Σ |C_L(D,E)| x^{2|D|+|E|} に一致することを ZZ[x] で検査する。
証明の各段（添字集合への帰属、ファイバーによる分割、位数の和の等式、
|P|=|C|）も全数で検査する。
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

R = PolynomialRing(ZZ, "x")
x = R.gen()

# 左辺: 偶部分グラフ順序対の母関数。
lhs = R(0)
pair_total = 0
fiber_index_of_pair = {}
for A in even_sets:
    for B in even_sets:
        D = A & B
        E = A.symmetric_difference(B)
        # 証明第 1 段: 像が添字集合に入る。
        assert not (D & E)
        assert is_even(L, E)
        # 証明第 3 段: 位数の和の等式。
        assert len(A) + len(B) == 2 * len(D) + len(E)
        fiber_index_of_pair[(frozenset(A), frozenset(B))] = (frozenset(D), frozenset(E))
        lhs += x ** (len(A) + len(B))
        pair_total += 1

# 右辺: 添字 (D,E) ごとの選択集合の個数による層別。
rhs = R(0)
index_count = 0
fiber_union = 0
for D in subsets:
    for E in even_sets:
        if D & E:
            continue
        index_count += 1
        pairs = [(A, B) for A in even_sets for B in even_sets
                 if A & B == D and A.symmetric_difference(B) == E]
        selectors = [C for C in subsets if C <= E and is_even(L, D | C)]
        # 証明第 2 段: ファイバーが P_L(D,E) と一致する。
        assert all(fiber_index_of_pair[(frozenset(A), frozenset(B))]
                   == (frozenset(D), frozenset(E)) for A, B in pairs)
        # 証明第 4 段: |P_L(D,E)| = |C_L(D,E)|（全単射の主張の再確認）。
        assert len(pairs) == len(selectors)
        fiber_union += len(pairs)
        rhs += len(selectors) * x ** (2 * len(D) + len(E))

# 証明第 2 段: ファイバーの互いに素な合併が順序対の全体を尽くす。
assert fiber_union == pair_total

assert lhs == rhs

print("PASS: even pairs =", pair_total)
print("PASS: disjoint indices (D,E) =", index_count)
print("PASS: generating polynomial =", lhs)
print("PASS: stratified count identity (L = 2)")
