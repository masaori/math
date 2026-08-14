# 対象ラベル: def_constant_plus_configuration, claim_constant_plus_breaks_no_bond,
#             claim_free_energy_density_nonnegative
#
# 可算側（σ_+ が配位であること、b(σ_+) = 0、1 項分離、1 ≤ Z_L(t) の有理数比較）は厳密に検査する。
# 実対数に触れる検査（0 ≤ φ_L(t)、0 ≤ ψ_L(t)）だけ RealBallField（ball 算術）を使う。
# ball 算術は「不等式の成立」は厳密に証明できる（ball が分離していれば確定）が、
# 「等式の成立」は証明できない。どの検査がどちらかを各関数に明記する。
# 有限標本での検査であり、普遍量化された主張そのものの証明ではない（それは本文の人手証明が担う）。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

RBF = RealBallField(256)

# L の範囲（free-energy-density の検査と同じ範囲に揃える）
L_RANGE = [1, 2, 3]

# t の標本（正の有理数。ι_{Q→R} を通した R の元のモデル。1 未満・1・1 超え）
T_SAMPLES = [QQ(1)/10, QQ(1)/3, QQ(1)/2, QQ(1), QQ(3)/2, QQ(22)/7, QQ(5)]


def constant_plus_configuration(L):
    # def_constant_plus_configuration: すべての頂点に +1 を割り当てる定数写像
    return {v: 1 for v in vertices(L)}


def check_constant_plus_is_configuration():
    # def_constant_plus_configuration の検査（厳密）: σ_+ ∈ Σ_L（全列挙との照合）。
    total = 0
    for L in L_RANGE:
        sigma_plus = constant_plus_configuration(L)
        assert any(s == sigma_plus for s in configurations(L)), L
        total += 1
    print(f"σ_+ ∈ Σ_L（厳密）: {total} 件 OK")
    return total


def check_constant_plus_breaks_no_bond():
    # claim_constant_plus_breaks_no_bond の式変形の各行の検査（厳密）:
    # 破れている辺の集合が空集合であること、b(σ_+) = 0。
    total = 0
    for L in L_RANGE:
        sigma_plus = constant_plus_configuration(L)
        broken = [(u, w) for (u, w) in edges(L)
                  if sigma_plus[u] != sigma_plus[w]]
        assert broken == [], L                                   # 空集合であること
        assert len(broken) == 0, L                               # |∅| = 0
        assert broken_bond_count(L, sigma_plus) == 0, L          # b(σ_+) = 0
        total += 3
    print(f"b(σ_+) = 0 の式変形の各行（厳密）: {total} 件 OK")
    return total


def check_one_term_separation_and_lower_bound():
    # claim_free_energy_density_nonnegative の準備の第二の式変形の各行の検査（厳密）:
    # t^0 = 1、t^{b(σ_+)} = 1、1 項分離の等式、残りの和の正値性、1 ≤ Z_L(t)。
    total = 0
    for L in L_RANGE:
        sigma_plus = constant_plus_configuration(L)
        ZL = partition_polynomial(L)
        for t in T_SAMPLES:
            assert t ** 0 == 1, (L, t)                           # 冪の指数 0 の約束
            term_plus = t ** broken_bond_count(L, sigma_plus)
            assert term_plus == 1, (L, t)                        # t^{b(σ_+)} = t^0 = 1
            rest = sum(t ** broken_bond_count(L, s)
                       for s in configurations(L) if s != sigma_plus)
            assert rest >= 0, (L, t)                             # 残りの和は非負（実際は正）
            value = ZL(x=t)
            assert term_plus + rest == value, (L, t)             # 1 項分離の等式
            assert 1 <= value, (L, t)                            # 1 ≤ Z_L(t)（厳密比較）
            total += 5
    print(f"1 項分離と 1 ≤ Z_L(t)（厳密）: {total} 件 OK")
    return total


def check_iota_inverse_square_positive():
    # claim_free_energy_density_nonnegative の準備の第三の検査（厳密）:
    # L ≥ 1 で 1 ≤ L²、0 < 1/L²（可算側 QQ の計算）。
    total = 0
    for L in L_RANGE:
        assert 1 <= L * L, L
        assert QQ(1) / (L * L) > 0, L
        total += 2
    print(f"0 < 1/L²（厳密）: {total} 件 OK")
    return total


def check_free_energy_density_nonnegative_ball():
    # claim_free_energy_density_nonnegative の本体の検査（ball 算術）:
    # 0 ≤ φ_L(t) と 0 ≤ ψ_L(t)。不等式は ball の下端の比較で厳密に確定する
    # （Z_L(t) = 1 のときは log の ball が 0 を含むことの整合検査にとどまる。
    #  そのときは可算側で Z_L(t) = 1 を厳密に確認して等号の側を取る）。
    total = 0
    for L in L_RANGE:
        ZL = partition_polynomial(L)
        w = QQ(1) / (L * L)
        for t in T_SAMPLES:
            value = ZL(x=t)
            assert value > 0, (L, t)                             # 厳密比較（定義域）
            phi = RBF(value).log()
            psi = RBF(w) * phi
            if value == 1:
                assert phi.contains_zero(), (L, t)               # 整合検査（等式は証明できない）
                assert psi.contains_zero(), (L, t)
            else:
                assert value > 1, (L, t)                         # 厳密比較
                assert phi > 0, (L, t)                           # ball の分離による厳密な不等式
                assert psi > 0, (L, t)
            total += 2
    print(f"0 ≤ φ_L(t) と 0 ≤ ψ_L(t)（ball。Z=1 の標本は整合検査）: {total} 件 OK")
    return total


total = 0
total += check_constant_plus_is_configuration()
total += check_constant_plus_breaks_no_bond()
total += check_one_term_separation_and_lower_bound()
total += check_iota_inverse_square_positive()
total += check_free_energy_density_nonnegative_ball()
print(f"合計 {total} 件 OK")
