# 対象ラベル: claim_open_rectangle_value_ge_one_at_positive_rational
#           （準備として def_open_rectangle_constant_plus_configuration・claim_open_rectangle_constant_plus_breaks_no_bond も検査する）
# 帰属: ZZ / QQ の厳密計算だけを使う。浮動小数点・ball 算術は使わない（主張は Q で閉じている）。
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


def open_edges(a, b):
    # def_open_rectangle_edges（向きの印つき）
    horizontal = [('h', i, j) for i in range(a) for j in range(b - 1)]
    vertical = [('v', i, j) for i in range(a - 1) for j in range(b)]
    return horizontal + vertical


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


def open_broken_bond_count(a, b, sigma):
    # def_open_rectangle_broken_bond_count
    return sum(ZZ(sigma[u] != sigma[v]) for u, v in map(endpoints, open_edges(a, b)))


def open_partition_polynomial(a, b):
    # def_open_rectangle_partition_polynomial（ZZ[x] の元）
    return sum((x ** open_broken_bond_count(a, b, sigma)
                for sigma in open_configurations(a, b)), R.zero())


def open_constant_plus_configuration(a, b):
    # def_open_rectangle_constant_plus_configuration: すべての頂点に +1 を割り当てる定数写像 τ_+
    return {v: ZZ(1) for v in open_vertices(a, b)}


def check_constant_plus():
    # def_open_rectangle_constant_plus_configuration: τ_+ ∈ Σ^op_{a,b}
    # claim_open_rectangle_constant_plus_breaks_no_bond: b^op_{a,b}(τ_+) = 0（破れた辺の集合は空）
    total = 0
    for a, b in SHAPES:
        tau_plus = open_constant_plus_configuration(a, b)
        assert any(s == tau_plus for s in open_configurations(a, b)), (a, b)          # τ_+ ∈ Σ^op_{a,b}
        broken = [e for e in open_edges(a, b)
                  if tau_plus[endpoints(e)[0]] != tau_plus[endpoints(e)[1]]]
        assert broken == [], (a, b)                                                    # 破れた辺の集合は空
        assert open_broken_bond_count(a, b, tau_plus) == 0, (a, b)                    # b^op(τ_+) = 0
        total += 3
    print(f"τ_+ ∈ Σ^op_{{a,b}} と b^op(τ_+) = 0（厳密）: {total} 件 OK")
    return total


def check_preparation_terms_positive():
    # 準備の検査: 各配位 σ について 0 < q^{b^op(σ)}（QQ の厳密比較）、b^op(σ) = 0 のとき q^0 = 1。
    total = 0
    for a, b in SHAPES:
        for sigma in open_configurations(a, b):
            bb = open_broken_bond_count(a, b, sigma)
            assert bb in NN, (a, b, bb)
            for q in Q_SAMPLES:
                term = q ** bb
                assert term in QQ and term > 0, (a, b, q, bb)
                if bb == 0:
                    assert term == 1, (a, b, q)
                total += 1
    print(f"各項 0 < q^{{b^op(σ)}}（厳密）: {total} 件 OK")
    return total


def check_chain_and_lower_bound():
    # 式変形の各行の検査（厳密）:
    # 1 = q^0、q^0 = q^{b^op(τ_+)}、q^{b^op(τ_+)} ≤ q^{b^op(τ_+)} + Σ_{σ≠τ_+} q^{b^op(σ)}（残りの和は 0 以上）、
    # 1 項分離の等式（Σ_σ q^{b^op(σ)} へ戻す）、Σ_σ q^{b^op(σ)} = Z^op_{a,b}(q)（ZZ[x] への代入と一致）、そして 1 ≤ Z^op_{a,b}(q)。
    total = 0
    for a, b in SHAPES:
        tau_plus = open_constant_plus_configuration(a, b)
        Zop = open_partition_polynomial(a, b)
        for q in Q_SAMPLES:
            assert q ** 0 == 1, (a, b, q)                                              # 1 = q^0
            term_plus = q ** open_broken_bond_count(a, b, tau_plus)
            assert term_plus == q ** 0, (a, b, q)                                      # q^0 = q^{b^op(τ_+)}
            rest = sum((q ** open_broken_bond_count(a, b, s)
                        for s in open_configurations(a, b) if s != tau_plus), QQ(0))
            assert rest >= 0, (a, b, q)                                                # 加えた和は 0 以上
            assert term_plus <= term_plus + rest, (a, b, q)                            # ≤ の行
            full = sum((q ** open_broken_bond_count(a, b, s)
                        for s in open_configurations(a, b)), QQ(0))
            assert term_plus + rest == full, (a, b, q)                                 # 1 項を有限和へ戻す
            value = Zop(x=q)
            assert value in QQ and value > 0, (a, b, q)
            assert full == value, (a, b, q)                                            # Σ_σ q^{b^op(σ)} = Z^op_{a,b}(q)
            assert 1 <= value, (a, b, q)                                               # 主張 1 ≤ Z^op_{a,b}(q)
            if q == 1:
                assert value == 2 ** (a * b), (a, b, q)                                # 整合検査: Z^op_{a,b}(1) = 2^{ab}
            total += 7
    print(f"式変形の各行と 1 ≤ Z^op_{{a,b}}(q)（厳密）: {total} 件 OK")
    return total


total = 0
total += check_constant_plus()
total += check_preparation_terms_positive()
total += check_chain_and_lower_bound()
print(f"合計 {total} 件 OK")
