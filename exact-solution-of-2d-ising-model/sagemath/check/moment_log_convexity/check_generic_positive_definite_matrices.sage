# 対象ラベル: moment_log_convexity
# 証明が使う W の性質は「成分が実数で対称」「正定値（実の y ≠ 0 で y^⊤Wy > 0）」だけなので、
# P := A^⊤A（A は列の数 n の整数行列で列が一次独立、n = 1..5）の有理行列と、逆立体射影で作った ‖x‖ = 1 の x ∈ QQ^n で証明の行を確かめる。全て厳密計算。
load("_prelude.sage")
load("_lines.sage")

set_random_seed(20261105)
count = 0
for n in range(1, 6):
    for nn in [n, n + 1]:
        for _ in range(2):
            while True:
                A = random_matrix(ZZ, nn, n, x=-3, y=4)
                if A.rank() == n:
                    break
            P = (A.transpose() * A).change_ring(QQ)
            assert is_real_symmetric(P) and real_rooted_with_signs(P, strict=True)
            xs = [vector(QQ, [1 if i == 0 else 0 for i in range(n)])]
            for _ in range(2 if n >= 2 else 0):   # d = 1 の単位ベクトルは ±1 だけなので、e_1 と (−1) の 2 本にする
                xs.append(rational_unit_vector([QQ.random_element(num_bound=4, den_bound=3) for _ in range(n - 1)]))
            if n == 1:
                xs.append(rational_unit_vector([]))
            for x in xs:
                check_proof_lines(P, x, 6 if n <= 3 else 5, f"n={n}, P={P.list()}, x={list(x)}")
                count += 1
print(f"(P, x) {count} 組、等号 {n_eq} 個、不等号 {n_le} 個")

# 否定コントロール 1: 対称だが正定値でない diag(1, −2) と x = (3/5, 4/5) では m_1 = −23/25 < 0 で正値性が外れ、
# m_2^2 = 5329/625 > m_1m_3 = 2737/625 で対数凸性も外れる（【P = W の不等式】に半正定値性が効く）
N = diagonal_matrix(QQ, [1, -2])
x = vector(QQ, [3/5, 4/5])
mm = [bil(x, N**k, x) for k in range(4)]
assert mm[1] == -23/25 and mm[1] < 0
assert mm[2]**2 == 5329/625 and mm[1] * mm[3] == 2737/625 and mm[2]**2 > mm[1] * mm[3]
# 否定コントロール 2: 対称でない T = [[1, 1], [0, 1]] では、【二つの冪で挟んだ値】の (W^b)_il = (W^b)_li の行が外れ、
# x^⊤(T^b(TT^a))x ≠ (T^bx)^⊤T(T^ax) となる組がある（冪の実対称性が効く）
T = matrix(QQ, [[1, 1], [0, 1]])
x = vector(QQ, [3/5, 4/5])
assert any(bil(x, T**(a + b + 1), x) != bil(T**b * x, T, T**a * x) for a in range(3) for b in range(1, 3))
# 否定コントロール 3: 半正定値だが正定値でない diag(1, 1, 0) と x = e_3 では Wx = 0、x^⊤Wx = 0 となり、
# 【W^ax は零でない】の段と m_1 > 0 が外れる（正定値性が効く）
S = diagonal_matrix(QQ, [1, 1, 0])
x = vector(QQ, [0, 0, 1])
assert S * x == 0 and bil(x, S, x) == 0 and bil(x, S**0, x) == 1
print("否定コントロール 3 件")
print("RESULT: PASS")
