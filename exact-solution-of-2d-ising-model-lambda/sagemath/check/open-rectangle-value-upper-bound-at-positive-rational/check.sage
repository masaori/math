# 対象ラベル: claim_open_rectangle_value_upper_bound_at_positive_rational
# 帰属: ZZ / QQ の厳密計算だけを使う。浮動小数点・ball 算術は使わない（主張は Q で閉じている）。
#
# 開境界長方形の正の有理点での値の上からの評価 Z^op_{a,b}(q) ≤ 2^{ab}·(1+q)^{2ab} を検査する。
# 準備の第五（b^op(σ) ≤ |E^op| = a(b-1)+(a-1)b ≤ 2ab の鎖）と、本体の式変形の各行を見る。
# 準備の第一〜第四（冪の正値性・底の単調性・指数の単調性・定数の有限和）は周期境界の
# partition-value-upper-bound-at-positive-rational で検査済みの有理数体の性質であり、ここでは本体で使う組だけを見る。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

from itertools import product

R.<x> = PolynomialRing(ZZ)

# 長方形の形 (a, b)（配位数 2^{ab}。(3,3) は 512 配位、(2,4) は 256 配位）
SHAPES = [(1, 1), (1, 2), (2, 1), (2, 2), (1, 3), (3, 1), (2, 3), (3, 2), (3, 3), (2, 4), (4, 2)]

# q の標本（正の有理数。1 未満・1・1 超え）
Q_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(2)/3, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5), QQ(11)]


def open_vertices(a, b):
    # def_open_rectangle_vertices
    return [(i, j) for i in range(a) for j in range(b)]


def open_edges_h(a, b):
    # def_open_rectangle_edges の横向き辺 E^op_{a,b,h} = {(i,j) | i<a, j+1<b}
    return [('h', i, j) for i in range(a) for j in range(b - 1)]


def open_edges_v(a, b):
    # def_open_rectangle_edges の縦向き辺 E^op_{a,b,v} = {(i,j) | i+1<a, j<b}
    return [('v', i, j) for i in range(a - 1) for j in range(b)]


def open_edges(a, b):
    # def_open_rectangle_edges（向きの印つき直和）
    return open_edges_h(a, b) + open_edges_v(a, b)


def endpoints(edge):
    direction, i, j = edge
    if direction == 'h':
        return (i, j), (i, j + 1)
    return (i, j), (i + 1, j)


def open_configurations(a, b):
    # def_open_rectangle_configuration
    vertices = open_vertices(a, b)
    for values in product((ZZ(1), ZZ(-1)), repeat=len(vertices)):
        yield dict(zip(vertices, values))


def open_broken_bond_set(a, b, sigma):
    # def_open_rectangle_broken_bond_count の B^op_{a,b}(σ)
    return [e for e in open_edges(a, b) if sigma[endpoints(e)[0]] != sigma[endpoints(e)[1]]]


def open_broken_bond_count(a, b, sigma):
    # def_open_rectangle_broken_bond_count の b^op_{a,b}(σ) = |B^op_{a,b}(σ)|
    return ZZ(len(open_broken_bond_set(a, b, sigma)))


def open_partition_polynomial(a, b):
    # def_open_rectangle_partition_polynomial（ZZ[x] の元）
    return sum((x ** open_broken_bond_count(a, b, sigma)
                for sigma in open_configurations(a, b)), R.zero())


def check_edge_count_chain():
    # 準備の第五の検査（厳密、N の中）:
    # b^op(σ) = |B^op(σ)| ≤ |E^op| = |E_h| + |E_v| = a(b-1) + (a-1)b ≤ ab + ab = 2ab。
    total = 0
    for a, b in SHAPES:
        edges = open_edges(a, b)
        eh, ev = open_edges_h(a, b), open_edges_v(a, b)
        assert set(eh).isdisjoint(set(ev)), (a, b)                        # 向きの印が異なるので直和
        assert len(edges) == len(eh) + len(ev), (a, b)                    # |E^op| = |E_h| + |E_v|
        assert len(eh) == a * (b - 1) and len(ev) == (a - 1) * b, (a, b)  # 直積の元の個数
        assert a - 1 in NN and b - 1 in NN, (a, b)
        assert a * (b - 1) + (a - 1) * b <= a * b + a * b == 2 * a * b, (a, b)
        total += 5
        for sigma in open_configurations(a, b):
            broken = open_broken_bond_set(a, b, sigma)
            assert set(broken) <= set(edges), (a, b)                      # B^op(σ) ⊆ E^op
            bb = open_broken_bond_count(a, b, sigma)
            assert bb == len(broken) and bb <= len(edges), (a, b)         # |B^op(σ)| ≤ |E^op|
            assert bb <= 2 * a * b, (a, b)                                # b^op(σ) ≤ 2ab
            total += 3
    print(f"準備の第五（辺数の鎖と b^op(σ) ≤ 2ab、厳密）: {total} 件 OK")
    return total


def check_upper_bound_chain():
    # 本体の式変形の各行の検査（厳密）:
    # Z^op_{a,b}(q) = Σ q^{b^op(σ)} ≤ Σ (1+q)^{b^op(σ)} ≤ Σ (1+q)^{2ab}
    #              = |Σ^op_{a,b}|·(1+q)^{2ab} = 2^{ab}·(1+q)^{2ab}。
    # 途中で使う事実 q ≤ 1+q、1 ≤ 1+q、各項の底の単調性・指数の単調性、|Σ^op| = 2^{ab} も検査する。
    total = 0
    for a, b in SHAPES:
        Zop = open_partition_polynomial(a, b)
        configs = list(open_configurations(a, b))
        assert len(configs) == 2 ** (a * b), (a, b)                # |Σ^op_{a,b}| = 2^{ab}
        bs = [open_broken_bond_count(a, b, s) for s in configs]
        total += 1
        for q in Q_SAMPLES:
            assert q <= 1 + q, (a, b, q)                           # q ≤ 1+q
            assert 1 <= 1 + q, (a, b, q)                           # 1 ≤ 1+q
            cap = (1 + q) ** (2 * a * b)
            for bb in bs:
                assert 0 < q ** bb, (a, b, q, bb)                  # 準備の第一（本体で使う組）
                assert q ** bb <= (1 + q) ** bb, (a, b, q, bb)     # 準備の第二（本体で使う組）
                assert (1 + q) ** bb <= cap, (a, b, q, bb)         # 準備の第三（本体で使う組）
                total += 3
            sum_q = sum((q ** bb for bb in bs), QQ(0))
            sum_base = sum(((1 + q) ** bb for bb in bs), QQ(0))
            sum_cap = sum((cap for _ in bs), QQ(0))
            value = Zop(x=q)
            assert value in QQ and value > 0, (a, b, q)            # Z^op_{a,b}(q) ∈ Q_{>0}
            assert value == sum_q, (a, b, q)                       # 代入は環準同型
            assert sum_q <= sum_base, (a, b, q)                    # 底を 1+q へ上げる
            assert sum_base <= sum_cap, (a, b, q)                  # 指数を 2ab へ上げる
            assert sum_cap == len(configs) * cap, (a, b, q)        # 定数の有限和（準備の第四）
            assert len(configs) * cap == 2 ** (a * b) * cap, (a, b, q)   # |Σ^op| = 2^{ab}
            assert value <= 2 ** (a * b) * cap, (a, b, q)          # 主張の不等式
            if a == b:
                assert value <= 2 ** (a * a) * (1 + q) ** (2 * a * a), (a, q)   # 正方形 L=a の形
            total += 9
    print(f"上界の式変形の各行（厳密）: {total} 件 OK")
    return total


total = 0
total += check_edge_count_chain()
total += check_upper_bound_chain()
print(f"合計 {total} 件 OK")
