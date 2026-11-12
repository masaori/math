# 対象ラベル: claim_existence_of_orthogonal_basis_for_nondegenerate_quadratic_form ほか（overview.md を見よ）
# V:=QQ^n、q(x):=x^T A x（A は有理数の対称行列）とし、偏極 B_q は定義 B_q(x,y)=q(x+y)-q(x)-q(y) のまま計算する。
# 本文の証明の手順（第 k+1 元の取り替え → 後ろの元の直交化）をそのまま実装し、各主張と鎖の行を厳密計算で確かめる。
set_random_seed(20261112)

def make_q(A):
    return lambda x: x * A * x

def make_B(q):
    return lambda x, y: q(x + y) - q(x) - q(y)            # def_polarization_of_map_to_complex_numbers

def lin_comb(nu, fam, n):                                   # def_linear_combination（左から足す）
    L = vector(QQ, [0] * n)
    for k in range(len(fam)):
        L = L + nu[k] * fam[k]
    return L

def ordered_sum(alpha):                                     # def_ordered_sum_in_complex_numbers
    S = QQ(0)
    for a in alpha:
        S = S + a
    return S

def is_basis(fam, n):                                       # def_basis（n 個の元で、行列の階数が n）
    return len(fam) == n and (n == 0 or matrix(QQ, fam).rank() == n)

def add_multiples(b, s, c):                                 # def_family_adding_multiples_of_one_member（s は 0 始まり）
    return [b[r] + c[r] * b[s] for r in range(len(b))]

def orthogonalized_up_to(e, k, q, B):                       # def_basis_orthogonalized_up_to_index（k 個まで）
    n = len(e)
    c1 = all(B(e[i], e[ip]) == 0 for i in range(k) for ip in range(k) if i != ip)
    c2 = all(q(e[i]) != 0 for i in range(k))
    c3 = all(B(e[i], e[j]) == 0 for i in range(k) for j in range(k, n))
    return c1 and c2 and c3

stats = {"cases": 0, "replaced": 0, "t_minus_one": 0, "wrong": 0}

def check_lemmas(A, n, q, B):
    for _ in range(5):
        x = random_vector(QQ, n, num_bound=5, den_bound=3)
        y = random_vector(QQ, n, num_bound=5, den_bound=3)
        z = random_vector(QQ, n, num_bound=5, den_bound=3)
        lam = QQ.random_element(num_bound=5, den_bound=3)
        t = QQ.random_element(num_bound=5, den_bound=3)
        assert B(x, y + z) == B(x, y) + B(x, z)                       # 第二引数の加法
        assert B(x, lam * y) == lam * B(x, y)                         # 第二引数のスカラー倍
        assert B(x, x) == (1 + 1) * q(x)                              # 同じ元の組での値
        assert q(x + t * y) == (q(x) + t * (t * q(y))) + t * B(x, y)  # 和とスカラー倍での値
    E = [vector(QQ, [1 if i == j else 0 for i in range(n)]) for j in range(n)]
    # 張る族のどの元とも直交する元は零：{x : B(x,E_k)=0 ∀k} の次元を、B の表現行列 2A の核で見る
    G = matrix(QQ, n, n, lambda i, j: B(E[i], E[j]))
    assert G == 2 * A and G.right_kernel().dimension() == 0

def run(A, label):
    n = A.nrows()
    q = make_q(A)
    B = make_B(q)
    check_lemmas(A, n, q, B)
    b = [vector(QQ, [1 if i == j else 0 for i in range(n)]) for j in range(n)]
    e = list(b)
    assert is_basis(e, n) and orthogonalized_up_to(e, 0, q, B)      # k=0 は条件が空
    for k in range(n):                                              # 本文の k（0 始まりの添字では第 k+1 元が e[k]）
        assert all(v != 0 for v in e)                               # 一次独立な族の元は零でない
        if q(e[k]) != 0:
            et = e
        else:
            js = [j for j in range(k + 1, n) if B(e[k], e[j]) != 0]
            assert js, "nondegenerate form must give such j"        # 第 k+1 元と直交しない元が後ろにある
            j = js[0]
            beta, gamma = B(e[k], e[j]), q(e[j])
            vals = {}
            for t in [QQ(1), QQ(-1)]:
                lhs = q(e[k] + t * e[j])
                assert lhs == (q(e[k]) + t * (t * gamma)) + t * beta == gamma + t * beta
                vals[t] = lhs
            assert (1 + 1) * beta == vals[QQ(1)] + (-1) * vals[QQ(-1)]
            assert not (vals[QQ(1)] == 0 and vals[QQ(-1)] == 0)
            t = QQ(1) if vals[QQ(1)] != 0 else QQ(-1)
            if t == -1:
                stats["t_minus_one"] += 1
            c = [t if r == k else QQ(0) for r in range(n)]
            et = add_multiples(e, j, c)
            assert is_basis(et, n)
            assert all(et[r] == e[r] for r in range(n) if r != k)  # 係数 0 の元は変わらない
            nu = [QQ.random_element(num_bound=5, den_bound=3) for _ in range(n)]
            assert lin_comb(nu, et, n) == lin_comb(nu, e, n) + ordered_sum([nu[r] * c[r] for r in range(n)]) * e[j]
            assert orthogonalized_up_to(et, k, q, B) and q(et[k]) != 0
            stats["replaced"] += 1
        v = et[k]
        d = B(v, v)
        assert d == (1 + 1) * q(v) and d != 0
        c = [QQ(0) if r <= k else -(B(et[r], v) * d ** -1) for r in range(n)]
        ep = add_multiples(et, k, c)
        assert is_basis(ep, n)
        nu = [QQ.random_element(num_bound=5, den_bound=3) for _ in range(n)]
        assert lin_comb(nu, ep, n) == lin_comb(nu, et, n) + ordered_sum([nu[r] * c[r] for r in range(n)]) * et[k]
        for r in range(k + 1, n):
            alpha = B(et[r], v)
            assert B(ep[k], ep[r]) == alpha + c[r] * d == alpha + (-(alpha * (d ** -1 * d))) == 0
        assert orthogonalized_up_to(ep, k + 1, q, B)
        # 否定の対照：係数の 2 を落とす（d の代わりに q(v) で割る）と、後ろに直交しない元が残る
        wrong = add_multiples(et, k, [QQ(0) if r <= k else -(B(et[r], v) * q(v) ** -1) for r in range(n)])
        if any(B(et[r], v) != 0 for r in range(k + 1, n)):
            assert not orthogonalized_up_to(wrong, k + 1, q, B)
            stats["wrong"] += 1
        e = ep
    assert is_basis(e, n)
    assert all(B(e[i], e[j]) == 0 for i in range(n) for j in range(n) if i != j)
    assert all(q(e[i]) != 0 for i in range(n))
    stats["cases"] += 1

half = QQ(1) / 2
fixed = [
    matrix(QQ, [[1]]),
    matrix(QQ, [[0, half], [half, 0]]),                            # 対による二次形式の形。第一元が 0 になる
    matrix(QQ, [[0, half], [half, -1]]),                           # t=1 では 0 になり、t=-1 が要る
    block_diagonal_matrix([matrix(QQ, [[0, half], [half, 0]])] * 2),
    block_diagonal_matrix([matrix(QQ, [[0, half], [half, 0]])] * 3),
    matrix(QQ, [[0, 1, 2], [1, 0, 3], [2, 3, 0]]),
]
for A in fixed:
    run(A, "fixed")
count = 0
while count < 40:
    n = ZZ.random_element(1, 6)
    M = random_matrix(ZZ, n, n, x=-3, y=4)
    A = M + M.transpose()
    for i in range(n):
        if ZZ.random_element(0, 2) == 0:
            A[i, i] = 0                                            # 対角を 0 にして取り替えの段を通す
    if A.det() == 0:
        continue
    run(A, "random")
    count += 1
assert stats["replaced"] > 0 and stats["t_minus_one"] > 0 and stats["wrong"] > 0

# 否定の対照：退化した二次形式では、第一元と直交しない元が後ろに無い
Adeg = matrix(QQ, [[0, 0], [0, 1]])
qd = make_q(Adeg); Bd = make_B(qd)
e = [vector(QQ, [1, 0]), vector(QQ, [0, 1])]
assert qd(e[0]) == 0 and all(Bd(e[0], e[j]) == 0 for j in range(2))
# 否定の対照：足す元自身の係数が 0 でないと基底にならないことがある
e = [vector(QQ, [1, 0]), vector(QQ, [0, 1])]
assert not is_basis(add_multiples(e, 0, [QQ(-1), QQ(5)]), 2)
print("cases=%d replaced=%d t_minus_one=%d wrong=%d" % (stats["cases"], stats["replaced"], stats["t_minus_one"], stats["wrong"]))
print("ALL PASS")
