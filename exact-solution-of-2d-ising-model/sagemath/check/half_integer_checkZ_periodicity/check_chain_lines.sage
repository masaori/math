# 対象ラベル: half_integer_checkZ_periodicity
# 証明の 2 等号の鎖 Ž_{μ+M} = Σ_j exp(-i(j_R θ̃_{μ+M})_C) Z_{j_Z} = Σ_j exp(-i(j_R θ̃_μ)_C) Z_{j_Z} = Ž_μ を、
# M = 2..5、μ = -M..2M で厳密に確かめる。
# - Z_j は def_jordan_wigner_Z_matrices の σ_1^x⋯σ_{j-1}^x σ_j^z を、クロネッカー積の成分の式と mat_mult の成分の式で組む
#   （sagemath/_shared/pauli_sites_exact.sage の jw。Sage 組み込みの tensor_product と * で組んだものとの一致も確かめる）。
# - 係数 exp(-i(j_R θ̃)_C) は 1 の冪根として円分体 CyclotomicField(L)（L = lcm(4, 2M)、θ̃/2π の分母は 2M）で持ち、
#   Z_j の成分の QQ(i) は i ↦ ζ_L^{L/4} で同じ体へ送る。等号は円分体の行列の等号で厳密に判定する。
# - 第 1 行は def_half_integer_checkZ を μ+M で、第 3 行は μ で組んだ和、第 2 行は証明に書かれた和
#   （係数だけを θ̃_μ のものに替えたもの）。係数の一致（half_integer_phase_periodicity）を項ごとにも確かめる。
# 係数が本文の exp の値であることは half_integer_phase_periodicity の検算（本文の exp のボール）で確かめている。
# 対照: 添字を 1 だけずらした Ž_{μ+1} は Ž_μ と一致しない（行列の比較が係数の違いを捉えることの確認）。
load("../../_shared/pauli_sites_exact.sage")
load("../../_shared/half_integer_phase_exact.sage")


def to_cf(A, CF, L):
    z4 = CF.gen() ** (L // 4)
    return matrix(CF, A.nrows(), A.ncols(), lambda r, c: QQ(A[r, c].real()) + QQ(A[r, c].imag()) * z4)


def coeff(CF, L, q):
    """exp(i(2πq)_C) = ζ_L^{qL}。"""
    e = QQ(q) * L
    assert e in ZZ
    return CF.gen() ** (ZZ(e) % L)


def fourier(Us, CF, L, M, mu):
    """def_half_integer_checkZ: Σ_{j=1}^{M} exp(-i(j_R θ̃_μ)_C) Z_{j_Z}。"""
    return sum(coeff(CF, L, -QQ(j) * theta_over_2pi(M, mu)) * Us[j] for j in range(1, M + 1))


for M in range(2, 6):
    L = lcm(4, 2 * M)
    CF = CyclotomicField(L)
    assert CF(coeff(CF, L, QQ(1) / L)).complex_embedding().imag() > 0
    Us = {j: to_cf(jw(M, j, 'z'), CF, L) for j in range(1, M + 1)}
    for mu in range(-M, 2 * M + 1):
        line0 = fourier(Us, CF, L, M, mu + M)
        line1 = sum(coeff(CF, L, -QQ(j) * theta_over_2pi(M, mu + M)) * Us[j] for j in range(1, M + 1))
        line2 = sum(coeff(CF, L, -QQ(j) * theta_over_2pi(M, mu)) * Us[j] for j in range(1, M + 1))
        line3 = fourier(Us, CF, L, M, mu)
        for j in range(1, M + 1):
            assert coeff(CF, L, -QQ(j) * theta_over_2pi(M, mu + M)) == coeff(CF, L, -QQ(j) * theta_over_2pi(M, mu))
        assert line0 == line1 and line1 == line2 and line2 == line3
        assert fourier(Us, CF, L, M, mu + 1) != line3
    print(f"  M_col={M}: μ = {-M}..{2*M} で鎖の 3 等号が円分体の {2**M}×{2**M} 行列で厳密に成り立つ。Ž_{{μ+1}} ≠ Ž_μ")
print("RESULT: PASS")
