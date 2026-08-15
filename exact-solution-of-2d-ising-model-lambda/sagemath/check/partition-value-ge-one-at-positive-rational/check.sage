# 対象ラベル: claim_partition_value_ge_one_at_positive_rational
# 帰属: ZZ / QQ の厳密計算だけを使う。浮動小数点・ball 算術は使わない（主張は Q で閉じている）。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

# L の範囲（分配多項式を全配位から組む。L=4 は 65536 配位）
L_RANGE = [1, 2, 3, 4]

# q の標本（正の有理数。1 未満・1・1 超え）
Q_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(2)/3, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5), QQ(11)]


def constant_plus_configuration(L):
    # def_constant_plus_configuration: すべての頂点に +1 を割り当てる定数写像
    return {v: 1 for v in vertices(L)}


def check_preparation_terms_positive():
    # 準備の検査: 各配位 σ について 0 < q^{b(σ)}（QQ の厳密比較）、b(σ) = 0 のとき q^0 = 1。
    total = 0
    for L in L_RANGE:
        for sigma in configurations(L):
            b = broken_bond_count(L, sigma)
            assert b in NN, (L, b)
            for q in Q_SAMPLES:
                term = q ** b
                assert term in QQ and term > 0, (L, q, b)
                if b == 0:
                    assert term == 1, (L, q)
                total += 1
    print(f"各項 0 < q^{{b(σ)}}（厳密）: {total} 件 OK")
    return total


def check_chain_and_lower_bound():
    # 式変形の各行の検査（厳密）:
    # 1 = q^0、q^0 = q^{b(σ_+)}、q^{b(σ_+)} ≤ q^{b(σ_+)} + Σ_{σ≠σ_+} q^{b(σ)}（残りの和は 0 以上）、
    # 1 項分離の等式（Σ_σ q^{b(σ)} へ戻す）、Σ_σ q^{b(σ)} = Z_L(q)、そして 1 ≤ Z_L(q)。
    total = 0
    for L in L_RANGE:
        sigma_plus = constant_plus_configuration(L)
        assert any(s == sigma_plus for s in configurations(L)), L      # σ_+ ∈ Σ_L
        assert broken_bond_count(L, sigma_plus) == 0, L                 # b(σ_+) = 0
        ZL = partition_polynomial(L)
        for q in Q_SAMPLES:
            assert q ** 0 == 1, (L, q)                                  # 1 = q^0
            term_plus = q ** broken_bond_count(L, sigma_plus)
            assert term_plus == q ** 0, (L, q)                          # q^0 = q^{b(σ_+)}
            rest = sum((q ** broken_bond_count(L, s)
                        for s in configurations(L) if s != sigma_plus), QQ(0))
            assert rest >= 0, (L, q)                                    # 加えた和は 0 以上
            assert term_plus <= term_plus + rest, (L, q)                # ≤ の行
            full = sum((q ** broken_bond_count(L, s) for s in configurations(L)), QQ(0))
            assert term_plus + rest == full, (L, q)                     # 1 項を有限和へ戻す
            value = ZL(x=q)
            assert value in QQ, (L, q)
            assert full == value, (L, q)                                # Σ_σ q^{b(σ)} = Z_L(q)
            assert 1 <= value, (L, q)                                   # 主張 1 ≤ Z_L(q)
            if q == 1:
                assert value == 2 ** (L * L), (L, q)                    # 整合検査: Z_L(1) = 2^{L^2}（claim_free_entropy_at_one の値）
            total += 7
    print(f"式変形の各行と 1 ≤ Z_L(q)（厳密）: {total} 件 OK")
    return total


total = 0
total += check_preparation_terms_positive()
total += check_chain_and_lower_bound()
print(f"合計 {total} 件 OK")
