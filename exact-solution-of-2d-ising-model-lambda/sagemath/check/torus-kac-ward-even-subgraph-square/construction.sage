"""四つの Kac--Ward 行列式が符号付き偶部分グラフ多項式の平方に一致するかを厳密計算で観察する。（再利用する厳密構成のみ）

このファイルは下流の検算が読み込む定義だけを置く。観測の出力と assertion は
同じディレクトリの check.sage にある。下流はここだけを読むので、上流の
assertion を再実行しない（全先行検算は日次監査が check.sage を回して維持する）。
"""


K8 = CyclotomicField(8)
zeta8 = K8.gen()
P = PolynomialRing(K8, "x")
x = P.gen()


def edges(L):
    return [(kind, i, j, d) for kind in ("h", "v")
            for i in range(L) for j in range(L) for d in (0, 1)]


def base_edges(L):
    return [(kind, i, j) for kind in ("h", "v") for i in range(L) for j in range(L)]


def reversal(edge):
    kind, i, j, d = edge
    return (kind, i, j, 1 - d)


def endpoints(L, edge):
    kind, i, j, d = edge
    boundary0 = (i, j)
    boundary1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
    return (boundary0, boundary1) if d == 0 else (boundary1, boundary0)


def direction(edge):
    kind, _, _, d = edge
    return {("h", 0): 0, ("v", 0): 1, ("h", 1): 2, ("v", 1): 3}[(kind, d)]


def seam_parities(L, edge):
    kind, i, j = edge[0], edge[1], edge[2]
    return (ZZ(kind == "h" and j == L - 1), ZZ(kind == "v" and i == L - 1))


def rotation_phase(edge, successor):
    turn = (direction(successor) - direction(edge)) % 4
    return {0: K8(1), 1: zeta8, 3: zeta8 ** (-1)}[turn]


def transition_entry(L, a, b, edge, successor):
    if endpoints(L, edge)[1] != endpoints(L, successor)[0]:
        return K8(0)
    if successor == reversal(edge):
        return K8(0)
    ch, cv = seam_parities(L, successor)
    twist = K8(ZZ(-1) ** (a * ch + b * cv))
    return twist * rotation_phase(edge, successor)


def even_subgraphs(L):
    """全頂点の次数が偶数である台の辺の部分集合を全数で拾う。"""
    bases = base_edges(L)
    result = []
    for mask in range(2 ** len(bases)):
        subset = [bases[t] for t in range(len(bases)) if (mask >> t) & 1]
        degree = {}
        for kind, i, j in subset:
            p0 = (i, j)
            p1 = (i, (j + 1) % L) if kind == "h" else ((i + 1) % L, j)
            for p in (p0, p1):
                degree[p] = degree.get(p, 0) + 1
        if all(v % 2 == 0 for v in degree.values()):
            result.append(subset)
    return result


for L in (2, 3):
    oriented = edges(L)
    evens = even_subgraphs(L)
    # 偶部分グラフの切断線偶奇（ホモロジー類）ごとの符号付き多項式の候補。
    # c,d は横・縦の切断線偶奇に付ける符号、e は積 h*v に付ける符号。
    candidates = {}
    for c in (0, 1):
        for d in (0, 1):
            for e in (0, 1):
                q = P(0)
                for subset in evens:
                    h = sum(seam_parities(L, be)[0] for be in subset) % 2
                    v = sum(seam_parities(L, be)[1] for be in subset) % 2
                    q += ZZ(-1) ** (c * h + d * v + e * h * v) * x ** len(subset)
                candidates[(c, d, e)] = q
    for a in (0, 1):
        for b in (0, 1):
            m = matrix(P, len(oriented), len(oriented), lambda r, s: P(
                transition_entry(L, a, b, oriented[r], oriented[s])))
            det_poly = (identity_matrix(P, len(oriented)) - x * m).det()
            matches = [key for key, q in candidates.items() if q ** 2 == det_poly]
