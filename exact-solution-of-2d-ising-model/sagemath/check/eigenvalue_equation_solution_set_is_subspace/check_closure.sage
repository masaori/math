# 対象ラベル: eigenvalue_equation_solution_set_is_subspace（E_λ(A) := {x ∈ ℂ^n | Ax = λx} は ℂ^n の部分空間）
# 証明の (i) の 2 行、(ii) の 3 行、(iii) の 5 行の鎖を、固有値を持つ A（A := P D P^{-1}、D は QQ(i) の対角行列）と、
# E_λ(A) の元 x, y（A − λI の核の基底の乱数の線型結合）、乱数の a で確かめる。λ を固有値でない値に取った場合（E_λ = {O}）も含める。
# 帰属: K = QQ(i)。
load("../../_shared/linear_algebra_families.sage")
import random
rng = random.Random(int(41))
for n in [1, 2, 3, 4]:
    for _ in range(3):
        P = rand_mat(rng, n, n)
        while P.det() == 0:
            P = rand_mat(rng, n, n)
        ev = [small_K(rng) for _ in range(n)]
        if n >= 2:
            ev[1] = ev[0]                       # 重複する固有値も入れる
        A = P * diagonal_matrix(K, ev) * P.inverse()
        for lam in [ev[0], ev[-1], small_K(rng) + 7]:
            O = zero(n, 1)
            chain = [A * O, O, lam * O]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], ("(i)", t))
            ker = (A - lam * identity_matrix(K, n)).right_kernel().basis()
            if len(ker) == 0:
                continue
            mk = lambda: matrix(K, n, 1, list(sum(small_K(rng) * v for v in ker)))
            x = mk(); y = mk(); a = small_K(rng)
            ok(A * x == lam * x and A * y == lam * y, "x, y ∈ E_λ(A)")
            chain = [A * (x + y), A * x + A * y, lam * x + lam * y, lam * (x + y)]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], ("(ii)", t))
            chain = [A * (a * x), a * (A * x), a * (lam * x), (a * lam) * x, (lam * a) * x, lam * (a * x)]
            for t in range(len(chain) - 1):
                ok(chain[t] == chain[t + 1], ("(iii)", t))
# 対照: {x | Ax = λx + b}（b ≠ O）は O を含まない
A = identity_matrix(K, 2); b = matrix(K, [[1], [0]])
ok(A * zero(2, 1) != K(1) * zero(2, 1) + b, "対照")
print("checked", count(), "items")
print("RESULT: PASS")
