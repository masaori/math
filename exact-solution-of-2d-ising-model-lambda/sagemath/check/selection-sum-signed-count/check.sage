"""選択和が二つの選択集合の元の個数の差に等しいことを厳密検査する。

対象: claim_selection_sum_signed_count。

一辺 L=2 で、互いに素な辺集合 D,E（E は偶部分グラフ）の全ての組と
四つのスピン構造について、U_L^{a,b}(D,E) を定義の被加数の和として ZZ で計算し、
被加数の符号で選択集合を二分した個数の差に一致することを検査する。
全過程は ZZ の厳密演算であり、浮動小数点は使わない。
"""

L = 2


def base_edges(L):
    return [(kind, i, j) for kind in ("h", "v") for i in range(L) for j in range(L)]


def seam_parities(L, edge):
    kind, i, j = edge
    return (ZZ(kind == "h" and j == L - 1), ZZ(kind == "v" and i == L - 1))


def edge_endpoints(L, edge):
    kind, i, j = edge
    p0 = (i, j)
    p1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (p0, p1)


def is_even_edge_subset(subset):
    degree = {}
    for edge in subset:
        for p in edge_endpoints(L, edge):
            degree[p] = degree.get(p, 0) + 1
    return all(v % 2 == 0 for v in degree.values())


def winding_parities(subset):
    return (
        sum(seam_parities(L, edge)[0] for edge in subset) % 2,
        sum(seam_parities(L, edge)[1] for edge in subset) % 2,
    )


def sign_exponent(a, b, doubled, single, selected):
    first = frozenset(doubled) | frozenset(selected)
    second = frozenset(doubled) | (frozenset(single) - frozenset(selected))
    h1, v1 = winding_parities(first)
    h2, v2 = winding_parities(second)
    return ((1 + a) * h1 + (1 + b) * v1 + h1 * v1
            + (1 + a) * h2 + (1 + b) * v2 + h2 * v2)


bases = base_edges(L)
subsets = [frozenset(s) for s in Subsets(set(bases))]
even_subsets = [s for s in subsets if is_even_edge_subset(s)]

pairs = 0
checks = 0
for single in even_subsets:
    for doubled in subsets:
        if doubled & single:
            continue
        selectors = [
            selected for selected in subsets
            if selected.issubset(single)
            and is_even_edge_subset(doubled | selected)
        ]
        pairs += 1
        for a in (0, 1):
            for b in (0, 1):
                summands = [ZZ(-1) ** sign_exponent(a, b, doubled, single, selected)
                            for selected in selectors]
                assert all(value in (ZZ(1), ZZ(-1)) for value in summands)
                selection_sum = sum(summands, ZZ(0))
                positive = sum(ZZ(1) for value in summands if value == ZZ(1))
                negative = sum(ZZ(1) for value in summands if value == ZZ(-1))
                assert selection_sum == positive - negative
                checks += 1

assert len(even_subsets) == 2 ** (2 * L ** 2 - L ** 2 + 1)
print("PASS: L=%d の互いに素な (D,E)（E は偶部分グラフ）の全 %d 組と"
      "四スピン構造の %d 件で U=|C+|-|C-| を検査" % (L, pairs, checks))
