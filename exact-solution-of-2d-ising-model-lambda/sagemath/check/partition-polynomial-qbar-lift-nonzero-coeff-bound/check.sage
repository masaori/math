# 対象ラベル: claim_partition_polynomial_qbar_lift_nonzero_coeff_bound
#
# 主張: L >= 1 について、持ち上げ Ẑ_L^F ∈ QQbar[t] は
#   (1) ac_k(Ẑ_L^F) = Ω_L(k)（k <= 2L^2）、= 0（2L^2 < k）
#   (2) Ẑ_L^F != 0
#   (3) 2L^2 < k ならば ac_k(Ẑ_L^F) = 0
# を満たす。人手証明の準備（係数の場合分け）と、背理法で使う係数の総和が 2^{L^2} で
# あることを ZZ[x]・QQbar[t] の厳密計算で確かめる。浮動小数点は使わない。

import os

_dir = os.path.dirname(os.path.abspath(__file__)) if '__file__' in dir() else '.'
load(os.path.join(_dir, '../../_shared/defs.sage'))

Rt.<t> = PolynomialRing(QQbar)


def lift_F(f):
    """def_integer_polynomial_qbar_lift: 係数を ZZ ⊂ QQbar の鎖で送る。"""
    n = f.degree() if f.degree() >= 0 else 0
    return sum(QQbar(f[k]) * t ** k for k in range(0, n + 1))


def main():
    Ls = [1, 2, 3]

    print("1. 係数の場合分け ac_k(Ẑ_L^F) = Ω_L(k) (k <= 2L^2), 0 (2L^2 < k)")
    for L in Ls:
        Z = partition_polynomial(L)
        lift = lift_F(Z)
        omega = multiplicity_vector(L)
        top = 2 * L * L
        for k in range(0, top + 1):
            assert lift[k] == QQbar(omega[k]), (L, k)
        for k in range(top + 1, top + 5):
            assert lift[k] == QQbar(0), (L, k)
    print("   通過")

    print("2. Ẑ_L^F != 0（係数の総和が 2^{L^2} で、零元なら総和が 0 になり矛盾する）")
    for L in Ls:
        Z = partition_polynomial(L)
        lift = lift_F(Z)
        omega = multiplicity_vector(L)
        top = 2 * L * L
        assert sum(omega) == ZZ(2) ** (L * L), L
        assert sum(omega) != ZZ(0)
        assert lift != Rt.zero()
        # 零元だと仮定したときに各係数が零になること（背理法の中身）
        zero_coeffs = [Rt.zero()[k] for k in range(0, top + 1)]
        assert all(c == QQbar(0) for c in zero_coeffs)
    print("   通過")

    print("3. 2L^2 < k ならば ac_k(Ẑ_L^F) = 0")
    for L in Ls:
        lift = lift_F(partition_polynomial(L))
        top = 2 * L * L
        for k in range(top + 1, top + 10):
            assert lift[k] == QQbar(0), (L, k)
    print("   通過")


main()
