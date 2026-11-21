# 対象ラベル: kernel_of_matrix_is_subspace（ker Q := {x ∈ ℂ^n | Qx = O_{m,1}} は ℂ^n の部分空間）
# 証明の (i) Q O_{n,1} = O_{m,1}、(ii) の 3 行の鎖、(iii) の 3 行の鎖を、核の元 x, y（核の基底の乱数の線型結合）と乱数の a で確かめる。
# 階数の落ちた Q（核が 0 でない）を作る。帰属: K = QQ(i)。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(37))
for m in [1, 2, 3]:
    for n in [1, 2, 3, 4]:
        for _ in range(3):
            r = rng.randint(0, min(m, n))
            Q = rand_mat(rng, m, r) * rand_mat(rng, r, n) if r > 0 else zero(m, n)
            ok(Q * zero(n, 1) == zero(m, 1), "(i)")
            ker = Q.right_kernel().basis()
            if len(ker) == 0:
                continue
            mk = lambda: matrix(K, n, 1, list(sum(small_K(rng) * v for v in ker)))
            x = mk(); y = mk(); a = small_K(rng)
            ok(Q * x == zero(m, 1) and Q * y == zero(m, 1), "x, y ∈ ker Q")
            chain = [Q * (x + y), Q * x + Q * y, zero(m, 1) + zero(m, 1), zero(m, 1)]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], ("(ii)", t))
            chain = [Q * (a * x), a * (Q * x), a * zero(m, 1), zero(m, 1)]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], ("(iii)", t))
# 対照: {x | Qx = b}（b ≠ O）は和で閉じない
Q = matrix(K, [[1, 0]]); b = matrix(K, [[1]]); x = matrix(K, [[1], [0]])
ok(Q * x == b and Q * (x + x) != b, "対照")
print("checked", count(), "items")
print("RESULT: PASS")
