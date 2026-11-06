# 対象ラベル: trace_power_upper_bound
# 証明が使う W の性質は「成分が実数で対称」「半正定値（rayleigh_bounds_operator_norm の前提）」「c は上限」だけなので、
# P := A^⊤A（A は整数の n'×n 行列、n = 1..5、n' = n−1, n, n+1）の有理行列で証明の行を確かめる。全て厳密計算。
load("_prelude.sage")
load("_lines.sage")

set_random_seed(20261104)
count = 0
for n in range(1, 6):
    for nn in [n - 1, n, n + 1]:
        if nn < 1:
            continue
        for _ in range(2):
            A = random_matrix(ZZ, nn, n, x=-3, y=4)
            P = (A.transpose() * A).change_ring(QQ)
            if P == 0:
                continue
            assert is_real_symmetric(P) and real_rooted_with_signs(P, strict=False)
            c = rayleigh_sup_exact(P)
            check_proof_lines(P, c, 6 if n <= 3 else 5, f"n={n}, n'={nn}, P={P.list()}")
            check_varrho_lines(P, 6 if n <= 3 else 5, f"n={n}, n'={nn}, P={P.list()}")
            count += 1
print(f"行列 {count} 組、等号 {n_eq} 個、不等号 {n_le} 個")

# 否定コントロール 1: c の代わりに 2 番目に大きい固有値 c' を使うと、大きい n で主張 tr(P^n) ≤ d c'^n が外れる（c が上限であることが効く）
P = matrix(QQ, [[2, 1, 0], [1, 2, 1], [0, 1, 2]])
roots = sorted([r for r, _ in P.charpoly().roots(AA)], reverse=True)
c2 = roots[1]
assert any((P**n).trace() > 3 * c2**n for n in range(1, 30))
# 否定コントロール 2: 対称だが半正定値でない diag(1, −2) では、c = sup{x^⊤Px | ‖x‖ = 1} = 1 だが tr(P^2) = 5 > 2·1^2（半正定値性が効く）
N = diagonal_matrix(QQ, [1, -2])
assert max(r for r, _ in N.charpoly().roots(AA)) == 1 and (N**2).trace() == 5 and 5 > 2 * 1**2
# 否定コントロール 3: 対称でない [[0, 1], [0, 0]] では【冪の実対称性】の (W^1)_{kl} = (W^1)_{lk} が外れる（対称性が効く）
T = matrix(QQ, [[0, 1], [0, 0]])
assert body_transpose(power_by_def_exp(T, 1)) != power_by_def_exp(T, 1)
print("否定コントロール 3 件")
print("RESULT: PASS")
