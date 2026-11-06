# 対象ラベル: W_real_has_positive_entries
# 証明の 2 行の鎖 ((W_ℝ)_kl)_ℂ = W_kl = w_ℂ と、単射性による (W_ℝ)_kl = w > 0 を、
# 具体の W（M_col = 2, 3、x, y ∈ {2, 3}）の全ての k, l で厳密に（QQbar・AA）確かめる。
load("../W_real_is_symmetric/_W_exact.sage")


def check_entry(WC, WR, k, l):
    """1 つの (k, l) について証明の手順をたどる。どこかの段が成り立たなければ False。"""
    z = WC[k, l]
    if z.imag() != 0:                                            # W_has_positive_entries: W_kl = w_ℂ を満たす w ∈ ℝ が在る
        return False
    w = AA(z.real())
    if not (w > 0 and iota(w) == z):                             # その w は ℝ_{>0} の元
        return False
    line1 = iota(WR[k, l])                                       # ((W_ℝ)_kl)_ℂ
    line2 = z                                                    # W_kl（def_W_real）
    line3 = iota(w)                                              # w_ℂ（w の取り方）
    if not (line1 == line2 == line3):
        return False
    return WR[k, l] == w and WR[k, l] > 0                        # inclusion_rr_to_cc_is_injective の結論と主張


count = 0
for M in [2, 3]:
    for x in [QQ(2), QQ(3)]:
        for y in [QQ(2), QQ(3)]:
            WC, WR = W_complex_and_real(M, x, y)                 # def_W_real
            n = WC.nrows()
            for k in range(n):
                for l in range(n):
                    assert check_entry(WC, WR, k, l), (M, x, y, k, l)
                    count += 1
# 否定コントロール: 同じ手順は、成分に 0・負の値・実数でない値を持つ行列では外れる
negatives = [
    matrix(QQbar, 2, 2, [1, 0, 0, 1]),                           # 成分 0（w ∈ ℝ_{>0} の段で外れる）
    matrix(QQbar, 2, 2, [1, -1, -1, 1]),                         # 負の成分（同じ段で外れる）
    matrix(QQbar, 2, 2, [1, QQbar(I), -QQbar(I), 1]),            # 実数でない成分（w ∈ ℝ の段で外れる）
]
for N in negatives:
    NR = matrix(AA, 2, 2, [AA(z.real()) for z in N.list()])
    assert not all(check_entry(N, NR, k, l) for k in range(2) for l in range(2))
print(f"{count} 組の (k, l) で 2 行の鎖と (W_ℝ)_kl = w > 0 を確かめた。否定コントロール {len(negatives)} 件")
print("RESULT: PASS")
