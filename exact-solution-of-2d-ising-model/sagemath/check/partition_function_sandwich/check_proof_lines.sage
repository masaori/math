# 対象ラベル: partition_function_sandwich
# 証明の準備の鎖 (Z(K_1,K_2))_ℂ = tr(W^{N_row}) = T_ℂ、単射性による Z(K_1,K_2) = T、
# 二つの鎖 Z = T ≥ c^{N_row} と Z = T ≤ 2^{M_col}c^{N_row} を、具体の W で厳密に確かめる。
# W は W_real_is_symmetric の検算と同じ厳密な経路（K_1 := 2 log y、K_2 := log x、x, y ∈ {2, 3}）で作る。
# Z(K_1,K_2) は def_partition_function_2d_ising の全配位の和として転送行列を経由せずに計算する
# （exp(K_1 n) = y^{2n}、exp(K_2 n) = x^n。ℝ への脱出は K_1・K_2 の選び方の一点だけ）。
# c(M_col) は def_rayleigh_sup の上限。W_ℝ は実対称なので上限は W_ℝ の最大の固有値で、AA で厳密に持つ
# （上限が最大固有値に等しいことは本文では使わない。この検算の値の取り方である）。
import itertools
load("../W_real_is_symmetric/_W_exact.sage")


def Z_direct(N, M, x, y):
    """def_partition_function_2d_ising: Σ_s exp(Σ_{i,j} (K_1 s(i,j)s(i,j+1) + K_2 s(i,j)s(i+1,j)))。"""
    total = QQ(0)
    for flat in itertools.product([-1, 1], repeat=N * M):
        s = lambda i, j: flat[(i % N) * M + (j % M)]                   # 周期境界条件
        a = sum(s(i, j) * s(i, j + 1) for i in range(N) for j in range(M))
        b = sum(s(i, j) * s(i + 1, j) for i in range(N) for j in range(M))
        total += QQ(y)**(2 * a) * QQ(x)**b
    return total


count = 0
for M in [2, 3]:
    d = 2**M
    for x in [QQ(2), QQ(3)]:
        for y in [QQ(2), QQ(3)]:
            WC, WR = W_complex_and_real(M, x, y)
            c = max(WR.charpoly().roots(AA, multiplicities=False))     # def_rayleigh_sup の c(M_col)
            assert c > 0
            for N in [1, 2, 3]:
                Z = Z_direct(N, M, x, y)
                T = sum((WR**N)[k, k] for k in range(d))                 # T := Σ_k ((W_ℝ)^{N_row})_kk
                # 準備の鎖
                line1 = iota(AA(Z))                                      # (Z(K_1,K_2))_ℂ
                line2 = (WC**N).trace()                                  # tr(W^{N_row})（Z_equals_trace_of_W）
                line3 = iota(T)                                          # T_ℂ（trace_of_W_power_via_W_real）
                assert line1 == line2 == line3, (M, x, y, N)
                assert AA(Z) == T                                        # inclusion_rr_to_cc_is_injective
                # 二つの鎖
                assert c**N <= T                                         # trace_power_sandwich の左の不等式
                assert T <= 2**M * c**N                                  # trace_power_sandwich の右の不等式
                count += 1
# 否定コントロール: 行と列の役割を入れ替えた格子（N_row = 2、M_col = 3）の Z は、M_col = 2 の W の 3 乗のトレースと一致しない
WC, WR = W_complex_and_real(2, QQ(2), QQ(3))
assert (WC**3).trace() == iota(AA(Z_direct(3, 2, QQ(2), QQ(3))))
assert (WC**3).trace() != iota(AA(Z_direct(2, 3, QQ(2), QQ(3))))
print(f"{count} 組の (M_col, x, y, N_row) で準備の鎖・Z = T・二つの鎖を確かめた。否定コントロール 1 件")
print("RESULT: PASS")
