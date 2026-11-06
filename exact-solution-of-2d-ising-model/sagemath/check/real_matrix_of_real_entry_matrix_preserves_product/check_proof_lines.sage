# 対象ラベル: real_matrix_of_real_entry_matrix_preserves_product
# 証明の 6 行の鎖 (((AB)_ℝ)_ik)_ℂ = (AB)_ik = Σ_j A_ijB_jk = Σ_j ((A_ℝ)_ij)_ℂ((B_ℝ)_jk)_ℂ = Σ_j ((A_ℝ)_ij(B_ℝ)_jk)_ℂ
#   = (Σ_j (A_ℝ)_ij(B_ℝ)_jk)_ℂ = ((A_ℝB_ℝ)_ik)_ℂ と、単射性による (AB)_ℝ = A_ℝB_ℝ を、ランダムな大きさと成分で厳密に確かめる。
# 帰属: ℂ の元は QQbar、ℝ の元は AA。浮動小数点は使わない。
def iota(r):
    """inclusion_rr_to_cc: r ↦ r_ℂ（AA → QQbar）。"""
    return QQbar(r)


def varrho(B):
    """def_real_matrix_of_real_entry_matrix: (B_ℝ)_pq := B_pq = r_ℂ を満たす r。"""
    assert all(z.imag() == 0 for z in B.list())
    return matrix(AA, B.nrows(), B.ncols(), lambda p, q: AA(B[p, q].real()))


set_random_seed(20261106)
cands = [QQ(-3), QQ(-1)/2, QQ(0), QQ(2)/3, QQ(5), AA(2).sqrt(), -AA(3).sqrt()]
count = 0
for trial in range(30):
    m, n, p = randint(1, 4), randint(1, 4), randint(1, 4)
    A = matrix(AA, m, n, lambda i, j: cands[randint(0, len(cands) - 1)]).apply_map(iota)
    B = matrix(AA, n, p, lambda j, k: cands[randint(0, len(cands) - 1)]).apply_map(iota)
    AB = matrix(QQbar, m, p, lambda i, k: sum(A[i, j] * B[j, k] for j in range(n)))   # mat_mult
    AR, BR, ABR = varrho(A), varrho(B), varrho(AB)                                   # 積も成分が実数（product_of_real_entry_matrices_has_real_entries）
    ARBR = matrix(AA, m, p, lambda i, k: sum(AR[i, j] * BR[j, k] for j in range(n)))  # def_real_matrix_product
    for i in range(m):
        for k in range(p):
            line1 = iota(ABR[i, k])
            line2 = AB[i, k]
            line3 = sum(A[i, j] * B[j, k] for j in range(n))
            line4 = sum(iota(AR[i, j]) * iota(BR[j, k]) for j in range(n))
            line5 = sum(iota(AR[i, j] * BR[j, k]) for j in range(n))
            line6 = iota(sum(AR[i, j] * BR[j, k] for j in range(n)))
            line7 = iota(ARBR[i, k])
            assert line1 == line2 == line3 == line4 == line5 == line6 == line7, (trial, i, k)
            assert ABR[i, k] == ARBR[i, k]                                           # inclusion_rr_to_cc_is_injective
            count += 1
    assert ABR == ARBR                                                               # (AB)_ℝ = A_ℝB_ℝ
# 否定コントロール: 積の順を入れ替えた B_ℝA_ℝ は一般に (AB)_ℝ と異なる
A = matrix(QQbar, 2, 2, [1, 2, 0, 1]); B = matrix(QQbar, 2, 2, [1, 0, 3, 1])
assert varrho(A * B) != varrho(B) * varrho(A)
print(f"{count} 個の成分で 6 行の鎖と ((AB)_ℝ)_ik = (A_ℝB_ℝ)_ik を確かめた。否定コントロール 1 件")
print("RESULT: PASS")
