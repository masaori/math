# 対象ラベル: antiperiodic_exp_sum
# 鎖 k_R θ̃_μ = ⋯ = 2π(2_Rμ_R - 1_R)k_R / (2_R(M_col)_R) の 6 等号を、π・k・μ・M_col を不定元にした
# QQ(pi_, k, mu, M) で厳密に確かめる（各行をその行の式の形のまま組み、隣の行と比べる）。
# 対照: 第 3 行で分母にだけ 2 を掛けると第 2→3 行が崩れる。θ̃ の 1/2 を外すと鎖の両端が一致しない。
load("_prelude.sage")
F = FractionField(PolynomialRing(QQ, ["pi_", "k", "mu", "M"]))
pi_, k, mu, M = F.gens()
half = F(1) / 2
two = F(2)
theta = 2 * pi_ * (mu - half) / M                   # θ̃_μ の定義
lines = [
    k * theta,                                      # 第 0 行 k_R θ̃_μ
    k * (2 * pi_ * (mu - half) / M),                # 第 1 行（θ̃_μ の定義を代入）
    (2 * pi_ * k * (mu - half)) / M,                # 第 2 行（積の交換律・結合律）
    (2 * pi_ * k * (two * (mu - half))) / (two * M),# 第 3 行（分子と分母に 2 を掛ける）
    (2 * pi_ * k * (two * mu - two * half)) / (two * M),  # 第 4 行（分配法則）
    (2 * pi_ * k * (two * mu - 1)) / (two * M),     # 第 5 行（2·(1/2) = 1）
    (2 * pi_ * (two * mu - 1) * k) / (two * M),     # 第 6 行（積の交換律）
]
for a, b in zip(lines, lines[1:]):
    assert a == b
# 第 3 行の操作は M ≠ 0 と 2 ≠ 0 を要する（分母が 0 の分数を作らない）: 分母は不定元 M の 0 でない多項式
assert (two * M) != 0
# 対照
assert lines[2] != (2 * pi_ * k * (two * (mu - half))) / M
assert lines[0] != (2 * pi_ * (2 * mu) * k) / (2 * M)
# 2π を外した有理数の形が prelude の theta_tilde_over_2pi と合うこと（具体の M, μ, k で）
for Mv in M_RANGE:
    for muv in range(-Mv, 2 * Mv + 1):
        for kv in K_RANGE(Mv):
            q1 = QQ(kv) * theta_tilde_over_2pi(Mv, muv)
            q2 = QQ((2 * muv - 1) * kv) / QQ(2 * Mv)
            assert q1 == q2
            assert lines[6].subs(pi_=1, k=kv, mu=muv, M=Mv) == 2 * q2
print("  k_R θ̃_μ の 6 等号が QQ(π, k, μ, M) で成り立つ。対照の 2 つは崩れる")
print("RESULT: PASS")
