# 対象ラベル: scalar_sequence_times_matrix_converges
# 証明の 3 行の鎖 ‖c_N A − cA‖ = ‖(c_N − c)A‖ = |c_N − c|‖A‖ → 0 を一行ずつ確かめる。
# 1 行目（difference_of_scalar_multiples_of_one_matrix）: c_N, c と A の成分を QQ 上の多項式環の不定元に置き、
#   本文の定義（def_matrix_scalar_multiple・def_matrix_difference）で組んだ両辺が等しい。
# 2 行目（matrix_norm_triangle_inequality (2)）: 成分が QQ(i) のとき、ノルムの 2 乗どうし
#   ‖(c_N − c)A‖^2 = |c_N − c|^2‖A‖^2 を厳密に比べる。
# 3 行目（→ 0）: c_N := c + 2^{-N}w とおくと右辺の 2 乗 4^{-N}|w|^2‖A‖^2 が N について狭義に減り、
#   任意の正の有理数を下回る N が取れることを厳密に確かめる（極限そのものは ℝ への脱出）。
# 否定コントロール: 係数の差の符号を逆にした (c − c_N)A は c_N A − cA と一致しない。
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")

count = 0
for n in [1, 2, 3]:
    P, (cN, c), (A,) = generic_ring([("A", n, n)], scalars=["cN", "c"])
    lhs = body_difference(body_scalar(cN, A), body_scalar(c, A))
    rhs = body_scalar(cN - c, A)
    assert lhs == rhs, n
    assert lhs != body_scalar(c - cN, A), n
    count += 1

F.<I> = QuadraticField(-1)
def nsq(A):
    return sum(QQ((a * a.conjugate())) for a in A.list())
def asq(z):
    return QQ(z * z.conjugate())

import random
random.seed(int(20261103))
def rnd():
    return F(QQ(int(random.randint(-9, 9))) / int(random.randint(1, 5))) + I * QQ(int(random.randint(-9, 9))) / int(random.randint(1, 5))

for n in [1, 2, 3, 4]:
    for trial in range(5):
        A = matrix(F, n, n, [rnd() for _ in range(n*n)])
        c = rnd()
        w = rnd()
        if w == 0:
            w = F(1)
        prev = None
        for N in range(0, 12):
            cN = c + QQ(2)**(-N) * w
            d = body_difference(body_scalar(cN, A), body_scalar(c, A))
            mid = body_scalar(cN - c, A)
            assert d == mid
            assert nsq(mid) == asq(cN - c) * nsq(A), (n, trial, N)
            assert asq(cN - c) == QQ(4)**(-N) * asq(w)
            val = asq(cN - c) * nsq(A)
            if prev is not None and A != 0:
                assert val < prev
            prev = val
            count += 1
        C = asq(w) * nsq(A)
        for delta in [QQ(1)/10, QQ(1)/1000, QQ(1)/10**6]:
            N = 0
            while C * QQ(4)**(-N) >= delta:
                N += 1
            assert C * QQ(4)**(-N) < delta
print(f"checked {count} cases")
print("RESULT: PASS")
