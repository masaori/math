# 対象ラベル: rayleigh_bounds_operator_norm
# 証明が使う W の性質は「成分が実数で対称（def_real_symmetric_matrix）」「半正定値」「c = sup{x^⊤Wx | ‖x‖ = 1}」だけである。
# そこで P := A^⊤A（A は整数の n'×n 行列。n' < n なら P は特異）の形の実対称・半正定値な有理行列で、証明の行を一行ずつ確かめる。
# 特異な P では Px = 0 となる x ≠ 0 が取れ、証明の場合分け「‖Wx‖ = 0」の側も通る。
load("_prelude.sage")
load("_lines.sage")

set_random_seed(20261104)
cases = 0
for n in range(2, 6):
    for rows in [n - 1, n, n + 1]:
        for trial in range(3):
            A = random_matrix(ZZ, rows, n, x=-3, y=4)
            P = (A.transpose() * A).change_ring(QQ)
            assert is_real_symmetric(P)
            assert real_rooted_with_signs(P, strict=False)            # 半正定値
            if P == 0:
                continue
            c = rayleigh_sup_exact(P)
            xs = [random_vector(QQ, n, num_bound=5, den_bound=3) for _ in range(3)]
            xs += [vector(QQ, v) for v in P.right_kernel().basis()[:1]]   # Px = 0 の x（特異な P のとき）
            xs += [vector(QQ, [1] + [0] * (n - 1))]
            for x in xs:
                check_proof_lines(P, c, x, 3, f"n={n}, rows={rows}, trial={trial}, x={x}")
                cases += 1

# 否定コントロール
# (a) c より小さい数 c' := (P の 2 番目に大きい固有値) を check_proof_lines に渡すと、c の固有ベクトルで検算自身が落ちる。
P = matrix(QQ, [[2, 1, 0], [1, 2, 1], [0, 1, 2]])
c = rayleigh_sup_exact(P)
roots = sorted(set(r for r, _ in P.charpoly().roots(AA)))
assert len(roots) >= 2
cprime = roots[-2]
v = (c * identity_matrix(AA, 3) - P.change_ring(AA)).right_kernel().basis()[0]
try:
    check_proof_lines(P.change_ring(AA), cprime, v, 1, "否定コントロール (a)")
    raise RuntimeError("小さすぎる c' で検算が落ちなかった")
except AssertionError as e:
    assert "x^⊤Wx ≤ c‖x‖^2" in str(e), e    # 上限の評価の行で落ちたこと（別の理由の失敗を数えない）
    n_neg += 1
# (a') 半正定値の判定 real_rooted_with_signs は、c'I − P と diag(1, −1) で False を返す。
assert not real_rooted_with_signs(cprime * identity_matrix(AA, 3) - P.change_ring(AA), strict=False)
assert not real_rooted_with_signs(diagonal_matrix(QQ, [1, -1]), strict=False)
n_neg += 2
# (b) 半正定値でない対称な P = diag(1, −1) では、Cauchy–Schwarz の行 (y^⊤Px)^2 ≤ (x^⊤Px)(y^⊤Py) が x = (1, 0)、y = (1, 1) で外れる。
P = diagonal_matrix(QQ, [1, -1])
x0 = vector(QQ, [1, 0]); y0 = vector(QQ, [1, 1])
assert not bil(y0, P, x0)**2 <= bil(x0, P, x0) * bil(y0, P, y0)
n_neg += 1
# (c) 対称でない半正定値（x^⊤Px ≥ 0）の P = [[1, 0], [2, 1]]（x^⊤Px = x_1^2 + 2x_1x_2 + x_2^2 ≥ 0）でも、Cauchy–Schwarz の行が
#     x = (1, 0)、y = (0, 1)（y^⊤Px = P_21 = 2、x^⊤Px = y^⊤Py = 1）で外れる。対称性の仮定は外せない。
P = matrix(QQ, [[1, 0], [2, 1]])
x0 = vector(QQ, [1, 0]); y0 = vector(QQ, [0, 1])
assert not bil(y0, P, x0)**2 <= bil(x0, P, x0) * bil(y0, P, y0)
n_neg += 1
# (d) 二乗の前の値で止めた誤った評価 ‖Px‖ ≤ c‖x‖^2 は ‖x‖ < 1 で外れることがある（‖x‖ の冪の取り違えの検出）。
P = matrix(QQ, [[1, 0], [0, 1]])
x0 = vector(QQ, [1/2, 0])
c = rayleigh_sup_exact(P)
assert not norm_exact(matvec(P, x0)) <= c * norm_exact(x0)**2
n_neg += 1

print(f"場合分け: ‖Wx‖ = 0 の側 {n_zero_side} 件、‖Wx‖ > 0 の側 {n_positive_side} 件")
print(f"組 {cases} 件、等号 {n_steps} 個、不等号 {n_ineq} 個、否定コントロール {n_neg} 件")
print("RESULT: PASS")
