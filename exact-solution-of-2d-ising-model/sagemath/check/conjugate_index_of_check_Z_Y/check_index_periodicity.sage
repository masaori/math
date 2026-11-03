# 対象ラベル: conjugate_index_of_check_Z_Y
# (3) の二つの鎖 Ž_{M+1-μ} = Ž_{(1-μ)+M} = Ž_{1-μ}、Y̌ も同じ形、を M = 2..5、μ = -M..2M で厳密に確かめる。
# - Z_j・Y_j は def_jordan_wigner_Z_matrices・def_jordan_wigner_Y_matrices の σ_1^x⋯σ_{j-1}^x σ_j^{z/y} を、
#   クロネッカー積と積の成分の式で組む（sagemath/_shared/pauli_sites_exact.sage の jw）。
# - 係数 exp(-i(j_R θ̃_μ)_C) は 1 の冪根として円分体 CyclotomicField(L)（L = lcm(4, 2M)）で持ち、
#   各行を def_half_integer_checkZ・def_half_integer_checkY の和として、その行の添字で組む。
# - 第 1 等号は添字の整数の等号 (1-μ)+M = M+1-μ（ZZ）、第 2 等号は half_integer_checkZ_periodicity・
#   half_integer_checkY_periodicity を添字 1-μ に当てたもの（係数の一致も項ごとに確かめる）。
# 対照: Ž_{M+1-μ} は整数運動量の共役添字 -μ の Ž_{-μ} と一致しない。
load("../../_shared/pauli_sites_exact.sage")
load("../../_shared/half_integer_phase_exact.sage")


def to_cf(A, CF, L):
    z4 = CF.gen() ** (L // 4)
    return matrix(CF, A.nrows(), A.ncols(), lambda r, c: QQ(A[r, c].real()) + QQ(A[r, c].imag()) * z4)


def coeff(CF, L, q):
    e = QQ(q) * L
    assert e in ZZ
    return CF.gen() ** (ZZ(e) % L)


def fourier(Us, CF, L, M, mu):
    return sum(coeff(CF, L, -QQ(j) * theta_over_2pi(M, mu)) * Us[j] for j in range(1, M + 1))


for M in range(2, 6):
    L = lcm(4, 2 * M)
    CF = CyclotomicField(L)
    assert CF(coeff(CF, L, QQ(1) / L)).complex_embedding().imag() > 0
    for a in ['z', 'y']:
        Us = {j: to_cf(jw(M, j, a), CF, L) for j in range(1, M + 1)}
        for mu in range(-M, 2 * M + 1):
            assert (1 - mu) + M == M + 1 - mu
            line0 = fourier(Us, CF, L, M, M + 1 - mu)
            line1 = fourier(Us, CF, L, M, (1 - mu) + M)
            line2 = fourier(Us, CF, L, M, 1 - mu)
            for j in range(1, M + 1):
                assert coeff(CF, L, -QQ(j) * theta_over_2pi(M, (1 - mu) + M)) == coeff(CF, L, -QQ(j) * theta_over_2pi(M, 1 - mu))
            assert line0 == line1 and line1 == line2
            assert fourier(Us, CF, L, M, -mu) != line0
    print(f"  M_col={M}: μ = {-M}..{2*M} で Ž・Y̌ の鎖の 2 等号が円分体の {2**M}×{2**M} 行列で厳密に成り立つ。Ž_{{-μ}} ≠ Ž_{{M+1-μ}}")
print("RESULT: PASS")
