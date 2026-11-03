# 対象ラベル: matrix_multiplication_continuity_in_right_factor
# 証明の 3 行の鎖 ‖BA_N − BA‖ = ‖B(A_N − A)‖ ≤ ‖B‖‖A_N − A‖ → 0 を一行ずつ確かめる。
# 1 行目（左分配則）: 成分を QQ 上の多項式環の不定元に置き、本文の定義（mat_mult・def_matrix_difference）で組んだ両辺が等しい。
# 2 行目（劣乗法性）: 成分が QQ(i) の行列で、ノルムの 2 乗（def_matrix_norm の平方根の中身）どうしを厳密に比べる。
# 3 行目（→ 0）: A_N := A + 2^{-N}E とおくと ‖A_N − A‖^2 = 4^{-N}‖E‖^2 で、右辺の評価の 2 乗 ‖B‖^2·4^{-N}‖E‖^2 が
#   N について狭義に減り、任意の正の有理数を下回る N が取れることを厳密に確かめる（極限そのものは ℝ への脱出なので、
#   ここで確かめるのは評価の形だけである）。
# 否定コントロール: 左右を取り違えた A_N B − AB は B A_N − BA と一致しない。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")

count = 0
for n in [1, 2, 3]:
    P, _, (B, AN, A) = generic_ring([("B", n, n), ("AN", n, n), ("A", n, n)])
    lhs = body_difference(body_product(B, AN), body_product(B, A))
    rhs = body_product(B, body_difference(AN, A))
    assert lhs == rhs, n
    if n >= 2:
        assert lhs != body_difference(body_product(AN, B), body_product(A, B)), n
    count += 1

F.<I> = QuadraticField(-1)
def nsq(A):
    """def_matrix_norm の平方根の中身 Σ|a_ij|^2（QQ の元）。"""
    return sum(QQ((a * a.conjugate())) for a in A.list())

import random
random.seed(int(20261103))
def rnd():
    return F(QQ(int(random.randint(-9, 9))) / int(random.randint(1, 5))) + I * QQ(int(random.randint(-9, 9))) / int(random.randint(1, 5))

for n in [1, 2, 3, 4]:
    for trial in range(5):
        A = matrix(F, n, n, [rnd() for _ in range(n*n)])
        B = matrix(F, n, n, [rnd() for _ in range(n*n)])
        E = matrix(F, n, n, [rnd() for _ in range(n*n)])
        if E == 0:
            continue
        prev = None
        for N in range(0, 12):
            AN = A + QQ(2)**(-N) * E
            d = body_difference(body_product(B, AN), body_product(B, A))
            mid = body_product(B, body_difference(AN, A))
            assert d == mid
            bound = nsq(B) * nsq(body_difference(AN, A))
            assert nsq(mid) <= bound, (n, trial, N)
            assert nsq(body_difference(AN, A)) == QQ(4)**(-N) * nsq(E)
            if prev is not None:
                assert bound < prev
            prev = bound
            count += 1
        # 任意の正の有理数 δ を下回る N が取れる: bound(N) = 4^{-N}‖B‖^2‖E‖^2
        for delta in [QQ(1)/10, QQ(1)/1000, QQ(1)/10**6]:
            C = nsq(B) * nsq(E)
            N = 0
            while C * QQ(4)**(-N) >= delta:
                N += 1
            assert C * QQ(4)**(-N) < delta
print(f"checked {count} cases")
print("RESULT: PASS")
