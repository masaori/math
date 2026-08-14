# 対象ラベル: claim_sector_value_duality
# 帰属: 有限集合、ZZ[x]、QQ。浮動小数点を使わない。

import os
from itertools import combinations

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

R = PolynomialRing(ZZ, 'x')
x = R.gen()


def edge_subsets(L):
    edge_list = list(range(1, 2 * L * L + 1))
    for size in range(len(edge_list) + 1):
        for subset in combinations(edge_list, size):
            yield frozenset(subset)


def incidence_count(L, subset, vertex):
    return sum(ZZ(1) for edge in subset for endpoint in endpoints(L, edge)
               if endpoint == vertex)


def is_even_subgraph(L, subset):
    return all(incidence_count(L, subset, vertex) % 2 == 0
               for vertex in vertices(L))


def winding_sector(L, subset):
    horizontal_cut = frozenset(edge_number_horizontal(L, i, -1) for i in range(L))
    vertical_cut = frozenset(edge_number_vertical(L, -1, j) for j in range(L))
    return (len(subset.intersection(horizontal_cut)) % 2,
            len(subset.intersection(vertical_cut)) % 2)


# 検査する有理点（すべて 0 < q < 1 の既約分数。QQ の厳密計算）
rational_points = [QQ(1) / 2, QQ(1) / 3, QQ(2) / 5, QQ(3) / 7, QQ(9) / 10, QQ(1) / 40]

for L in (1, 2, 3):
    # セクター多項式 H^{a,b}_L（def_high_temperature_sector_polynomial）と
    # セクター生成多項式 G^{a,b}_L（def_sector_generating_polynomial）を独立に数え上げる
    sector_high_polynomials = {(a, b): R(0) for a in (0, 1) for b in (0, 1)}
    sector_generating_polynomials = {(a, b): R(0) for a in (0, 1) for b in (0, 1)}
    for subset in edge_subsets(L):
        if not is_even_subgraph(L, subset):
            continue
        key = winding_sector(L, subset)
        size = len(subset)
        # 準備: 指数 2L^2-|A| と |A| が自然数であること
        assert 0 <= size <= 2 * L * L
        sector_high_polynomials[key] += (1 + x) ** (2 * L * L - size) * (1 - x) ** size
        sector_generating_polynomials[key] += x ** size

    for q in rational_points:
        # 前セクションの範囲: q ∈ Q_{(0,1)}
        assert 0 < q < 1
        # 双対変換の値（def_kw_dual_transform を QQ で評価。1+q ≠ 0）
        assert 1 + q != 0
        kw_value = (1 - q) * (1 + q) ** (-1)
        # claim_kw_dual_preserves_unit_interval との整合: KW(q) ∈ Q_{(0,1)}
        assert kw_value in QQ and 0 < kw_value < 1
        # 準備の等式: (1+q)·KW(q) = 1-q
        assert (1 + q) * kw_value == 1 - q
        for a in (0, 1):
            for b in (0, 1):
                # 主張: H^{a,b}_L(q) = (1+q)^{2L^2} · G^{a,b}_L(KW(q))
                left = sector_high_polynomials[(a, b)](q)
                right = (1 + q) ** (2 * L * L) * sector_generating_polynomials[(a, b)](kw_value)
                assert left == right
                # 一行ずつ: 各項の書き換え 1-q = (1+q)·KW(q) と括り出しを項単位でも確認
        # 項単位の検査（式変形の 2〜5 行目に対応）: 各偶部分グラフの重みごとに等式を見る
    # 項単位の検査は多項式の再走査を要するので、L ごとに 1 つの有理点で行う
    q = rational_points[0]
    kw_value = (1 - q) * (1 + q) ** (-1)
    for subset in edge_subsets(L):
        if not is_even_subgraph(L, subset):
            continue
        size = len(subset)
        term = (1 + q) ** (2 * L * L - size) * (1 - q) ** size
        # 2 行目: (1-q)^{|A|} = ((1+q)·KW(q))^{|A|}
        assert term == (1 + q) ** (2 * L * L - size) * ((1 + q) * kw_value) ** size
        # 3 行目: 積の冪は冪の積
        assert term == (1 + q) ** (2 * L * L - size) * (1 + q) ** size * kw_value ** size
        # 4 行目: 冪の指数法則
        assert term == (1 + q) ** (2 * L * L) * kw_value ** size
    print("L=%d: H^{a,b}_L(q) = (1+q)^{2L^2}·G^{a,b}_L(KW(q)) を QQ で確認（有理点 %d 個 × 4 セクター、項単位の検査は q=%s）" %
          (L, len(rational_points), rational_points[0]))

print("RESULT: PASS")
