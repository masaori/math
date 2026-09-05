"""四つの Kac--Ward 行列式が符号付き偶部分グラフ多項式の平方に一致するかを厳密計算で観察する。

台の辺を両向きに使う閉歩道（頂点単純閉路族への分解の仮定から外れるもの）が
有限展開でどう扱われるかを確定するための観察である。行列式の置換展開の項は
向き付き辺が相異なる非後退閉路の族であり、台の辺は両向きに現れうる。
行列式が偶部分グラフ多項式（各台の辺を高々一度使う）の平方に一致するかを調べ、
一般の恒等式で目標にすべき符号を特定する。多項式全体の一致だけでは、置換展開の
個々の項と平方の交差項との対応や相殺の有無までは確定しない。
"""

load("sagemath/check/torus-kac-ward-even-subgraph-square/construction.sage")

for L in (2, 3):
    oriented = edges(L)
    evens = even_subgraphs(L)
    assert len(evens) == 2 ** (2 * L ** 2 - L ** 2 + 1)
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
            print("L=%d spin structure (a,b)=(%d,%d): matches=%s" % (L, a, b, matches))
            assert len(matches) >= 1, "no candidate square matches det for (a,b)=(%d,%d)" % (a, b)

print("PASS")
