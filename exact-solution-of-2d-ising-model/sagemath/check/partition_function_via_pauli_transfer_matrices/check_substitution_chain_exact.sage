# ---------------------------------------------------------
# SageMath: 主張 Z(K_1,K_2) = tr((exp(K_1 Σ σ^z_m σ^z_{m+1}) (2 sinh 2K_2)^{M_col/2} exp(K_2^* Σ σ^x_m))^{N_row})
#   の証明の式変形 3 行を、各行の両辺を独立に作って厳密に比べる。
#   1 行目: Z(K_1,K_2)（全配位の和）= tr((V_1V_2)^{N_row})（成分で定めた V_1, V_2）
#   2 行目: V_1 を exp(K_1 Σ_m σ^z_m σ^z_{m+1}) に置き換えたもの
#   3 行目: さらに V_2 を (2 sinh 2K_2)^{M_col/2} exp(K_2^* Σ_m σ^x_m) に置き換えたもの
#   否定コントロール: 3 行目で K_2^* の代わりに K_2 を使った右辺は Z と一致しない。
# 対象ラベル: partition_function_via_pauli_transfer_matrices
# 対象: structured-latex/content/partition_function_transfer_matrix_representation.ts
#       ブロック transfer_matrix_representation_claim_partition_function_via_pauli_transfer_matrices
# 帰属: x_1 := exp(K_1), x_2 := exp(K_2) を 1 より大きい有理数に選ぶ（K_i = log x_i、ここだけが見かけの ℝ 脱出）。
#       Z と成分の V_1, V_2 は QQ、exp(K_1 λ) = x_1^λ は QQ、
#       exp(K_2^* λ) = (√tanh K_2)^{-λ} と前係数 (√(2 sinh 2K_2))^{M_col} は AA（実代数的数。等号は決定可能）。
#       行列の指数関数は、整数固有値をもつ対称な整数行列のスペクトル射影で計算する
#       （_shared/row_configurations.sage の exp_by_spectral_projectors）。
# ---------------------------------------------------------
import os
import itertools
_dir = os.getcwd()   # このディレクトリで実行する（overview.md の「実行方法」）
load(os.path.join(_dir, "../../_shared/row_configurations.sage"))


def Z_exact(N_row, M_col, x1, x2):
    """<def_partition_function_2d_ising> を全 2^{N_row M_col} 配位の和として QQ で計算する（周期境界）。"""
    tot = QQ(0)
    for bits in itertools.product([1, -1], repeat=N_row * M_col):
        s = lambda i, j: bits[((i - 1) % N_row) * M_col + ((j - 1) % M_col)]
        e1 = sum(s(i, j) * s(i, j + 1) for i in range(1, N_row + 1) for j in range(1, M_col + 1))
        e2 = sum(s(i, j) * s(i + 1, j) for i in range(1, N_row + 1) for j in range(1, M_col + 1))
        tot += QQ(x1) ** e1 * QQ(x2) ** e2
    return tot


def bond_sum(M_col):
    """Σ_{m=1}^{M_col} σ^z_m σ^z_{m+1}（<def_site_pauli_periodic_extension> の σ^z_{M_col+1} := σ^z_1）。"""
    return sum([site_pauli('z', m, M_col) * site_pauli('z', m % M_col + 1, M_col) for m in range(1, M_col + 1)],
               matrix(ZZ, 2 ** M_col, 2 ** M_col, 0))


def sigma_x_sum(M_col):
    return sum([site_pauli('x', m, M_col) for m in range(1, M_col + 1)], matrix(ZZ, 2 ** M_col, 2 ** M_col, 0))


def tanh_K2(x2):
    return (QQ(x2) ** 2 - 1) / (QQ(x2) ** 2 + 1)


def prefactor(x2, M_col):
    """<def_second_transfer_matrix_prefactor>: (√(2 sinh 2K_2))^{M_col}、2 sinh 2K_2 = x_2^2 - x_2^{-2}。"""
    return AA(QQ(x2) ** 2 - QQ(x2) ** (-2)).sqrt() ** M_col


ok_all = True
X_PAIRS = [(QQ(2), QQ(3) / 2), (QQ(5) / 4, QQ(2)), (QQ(3), QQ(7) / 3)]
for M_col in range(1, 5):
    for N_row in range(1, 4):
        for (x1, x2) in X_PAIRS:
            r = AA(tanh_K2(x2)).sqrt()
            V1 = V1_by_components(M_col, lambda n: QQ(x1) ** n, QQ)
            V2 = V2_by_components(M_col, lambda n: QQ(x2) ** n, QQ)
            V1_pauli = exp_by_spectral_projectors(bond_sum(M_col), lambda lam: QQ(x1) ** lam, AA)
            V2_pauli = prefactor(x2, M_col) * exp_by_spectral_projectors(sigma_x_sum(M_col), lambda lam: r ** (-ZZ(lam)), AA)
            V2_wrong = prefactor(x2, M_col) * exp_by_spectral_projectors(sigma_x_sum(M_col), lambda lam: AA(QQ(x2)) ** ZZ(lam), AA)
            chain = [AA(Z_exact(N_row, M_col, x1, x2)),
                     AA(((V1 * V2) ** N_row).trace()),
                     ((V1_pauli * matrix(AA, V2)) ** N_row).trace(),
                     ((V1_pauli * V2_pauli) ** N_row).trace()]
            wrong = ((V1_pauli * V2_wrong) ** N_row).trace()
            ok = all(c == chain[0] for c in chain) and wrong != chain[0]
            print(f"  M_col={M_col}, N_row={N_row}, exp(K_1)={x1}, exp(K_2)={x2}: 3 行の両辺と否定コントロール -> {'PASS' if ok else 'FAIL'}")
            ok_all = ok_all and ok
exact_result(ok_all)
