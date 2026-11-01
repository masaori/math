# 対象ラベル: sqrt_squared_is_original
# 証明の式変形の十の式（行 0 〜 行 9）。A := (√r, θ/2 - nπ) と書く。
#   行 0: √z·√z
#   行 1: φ_cart([A])·φ_cart([A])                       （sqrt_expansion_via_polar）
#   行 2: φ_cart([A]·[A])                                （isomorphism_of_phi_cartesian: 積を保つ）
#   行 3: φ_cart([(√r·√r, (θ/2-nπ)+(θ/2-nπ))])          （operations_on_polar_representation）
#   行 4: φ_cart([(r, (θ/2-nπ)+(θ/2-nπ))])              （definition_of_sqrt_r_positive）
#   行 5: φ_cart([(r, (θ/2+θ/2)-(nπ+nπ))])              （R の和の交換律と結合律）
#   行 6: φ_cart([(r, θ-2nπ)])                            （θ/2+θ/2 = θ, nπ+nπ = 2nπ）
#   行 7: φ_cart([(r, θ)])                                （angle_equivalence_class・polar_equivalence_class）
#   行 8: φ_cart(φ_polar(z))                              （r, θ の取り方）
#   行 9: z                                               （phi_cartesian_after_phi_polar_is_identity）
# (一般の点) 行 4 → 5、行 5 → 6、行 6 → 7 の変わる成分を、QQ 上の多項式環で比べる。
# (具体の点) z を座標で直接与え、φ_polar(z) の代表元 (r, θ) を複数取り、各行を別々に組み立てて隣の行と比べる。
#   行 0 の √z は、固定した代表元 p0 から def_sqrt_cc の式どおりに作り（s_{[0,2π)} は ⌊q/2⌋ で求める）、
#   行 1 の A は、取り替えた各代表元 p から n_of_section（候補の総当たり）で作る。
load("_prelude.sage")

# 一般の点
assert (th / 2 - n * PI) + (th / 2 - n * PI) == (th / 2 + th / 2) - (n * PI + n * PI)   # 行 4 → 5 の第 2 成分
assert (th / 2 + th / 2) - (n * PI + n * PI) == th - 2 * n * PI                         # 行 5 → 6 の第 2 成分
assert (th - 2 * n * PI) - th == 2 * (-n) * PI       # 行 6 → 7: 角度の差が 2π の整数倍（-n ∈ Z）

cnt = 0
for z, p0 in SAMPLE_Z:
    w0 = sqrt_cc_by_definition(z, p0)                  # 行 0 の √z（固定した代表元から、定義どおり）
    row0 = cc_mul(w0, w0)
    for p in reps_of(p0):
        rr, t = p
        n = n_of_section(t)
        A = (sqrt_aa(rr), t / 2 - n * pi_)
        assert is_pair(A)
        row1 = cc_mul(phi_cartesian(A), phi_cartesian(A))
        row2_class = mul_rep(A, A)                     # [A]·[A] の代表元（積の定義）
        row3 = (sqrt_aa(rr) * sqrt_aa(rr), (t / 2 - n * pi_) + (t / 2 - n * pi_))
        row4 = (rr, (t / 2 - n * pi_) + (t / 2 - n * pi_))
        row5 = (rr, (t / 2 + t / 2) - (n * pi_ + n * pi_))
        row6 = (rr, t - 2 * n * pi_)
        row7 = (rr, t)
        # 行 0 → 1: 定義どおりの √z（p0 から）と、展開の右辺 φ_cart([A])（p から）が ℂ で一致する
        assert w0 == phi_cartesian(A)
        assert row0 == row1
        # 行 1 → 2: φ_cart の積の保存（具体の値で）
        assert row1 == phi_cartesian(row2_class)
        # 行 2 → 3: 積の定義の適用（mul_rep は行 3 と同じ式を返すので、独立な比較ではない）
        assert row2_class == row3
        # 行 3 → 4: 第 2 成分は同じ式、第 1 成分は √r·√r = r（sqrt_aa の中で y ≥ 0 かつ y² = x を確かめている）
        assert row3[1] == row4[1] and row3[0] == row4[0]
        # 行 4 → 5、行 5 → 6: 第 1 成分は同じ、第 2 成分は実数の和
        assert row4[0] == row5[0] and row4[1] == row5[1]
        assert row5[0] == row6[0] and row5[1] == row6[1]
        # 行 6 → 7: 類として等しい。角度の差が 2·(-n)·π。φ_cart の値も等しい
        assert row6[1] - row7[1] == 2 * (-n) * pi_
        assert polar_equiv(row6, row7)
        assert phi_cartesian(row6) == phi_cartesian(row7)
        # 行 7 → 8: φ_polar(z) = [(r, θ)]
        assert phi_polar_equals(z, row7)
        # 行 8 → 9: φ_cart([(r, θ)]) = z（z は座標で直接与えたもの）
        assert phi_cartesian(row7) == z
        # 各段の対が R_{>=0} × R の元であること
        assert all(is_pair(x) for x in (row2_class, row3, row4, row5, row6, row7))
        cnt += 1

# 対照: 代表元を取り違えると行 7 → 8 の判定が落ちること（判定が素通りしていないことの確認）
assert not phi_polar_equals((AA(1), AA(1)), (s2, -pi_ / 4))
assert not phi_polar_equals((AA(-2), AA(0)), (AA(2), Ang(0)))
assert not phi_polar_equals((AA(1), AA(1)), (AA(2), pi_ / 4))
assert not phi_polar_equals((AA(0), AA(3)), (AA(3), -pi_ / 2))          # x = 0, y > 0
assert not phi_polar_equals((AA(0), -AA(1) / 2), (AA(1) / 2, pi_ / 2))  # x = 0, y < 0
assert not phi_polar_equals((AA(-1), AA(-1)), (s2, 3 * pi_ / 4))        # x < 0, y < 0
assert not phi_polar_equals((AA(0), AA(0)), (AA(1), Ang(0)))            # x = y = 0
print(f"rows 4->5, 5->6, 6->7 as polynomial identities; all ten rows built separately on {cnt} (z, representative) pairs")
print("RESULT: PASS")
