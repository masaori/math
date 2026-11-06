# 対象ラベル: W_real_is_symmetric
# 証明の 4 行の鎖 ((W_ℝ)_kl)_ℂ = W_kl = (W^⊤)_kl = W_lk = ((W_ℝ)_lk)_ℂ と、単射性による (W_ℝ)_kl = (W_ℝ)_lk を、
# 具体の W（M_col = 2, 3、x, y ∈ {2, 3}）の全ての k, l で厳密に（QQbar・AA）確かめる。
load("_W_exact.sage")

count = 0
for M in [2, 3]:
    for x in [QQ(2), QQ(3)]:
        for y in [QQ(2), QQ(3)]:
            WC, WR = W_complex_and_real(M, x, y)
            n = WC.nrows()
            WCt = matrix(QQbar, n, n, lambda k, l: WC[l, k])           # def_matrix_transpose
            assert WCt == WC                                          # W^⊤ = W（W_is_real_symmetric_positive_definite）
            for k in range(n):
                for l in range(n):
                    line1 = iota(WR[k, l])
                    line2 = WC[k, l]
                    line3 = WCt[k, l]
                    line4 = WC[l, k]
                    line5 = iota(WR[l, k])
                    assert line1 == line2 == line3 == line4 == line5, (M, x, y, k, l)
                    assert WR[k, l] == WR[l, k]                       # inclusion_rr_to_cc_is_injective の結論
                    count += 1
            assert WR.transpose() == WR                               # def_real_symmetric_matrix の意味で対称
# 否定コントロール: 対称でない実の行列は鎖の 2→3 行（W^⊤ = W）で外れる
N = matrix(QQbar, 2, 2, [1, 2, 3, 4])
assert N.transpose() != N
print(f"{count} 組の (k, l) で 4 行の鎖と (W_ℝ)_kl = (W_ℝ)_lk を確かめた。否定コントロール 1 件")
print("RESULT: PASS")
