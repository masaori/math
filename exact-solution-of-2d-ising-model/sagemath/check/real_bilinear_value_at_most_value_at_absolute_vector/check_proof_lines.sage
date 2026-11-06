# 対象ラベル: real_bilinear_value_at_most_value_at_absolute_vector
# 証明の準備（各 k の |Σ_l x_kP_klx_l| ≤ Σ_l |x_kP_klx_l|、|P_kl| = P_kl）と、
# 主張の 9 行の鎖 x^⊤Px ≤ |x^⊤Px| = |ΣΣ x_kP_klx_l| ≤ Σ_k|Σ_l …| ≤ ΣΣ|x_kP_klx_l|
#   = ΣΣ|x_kP_kl||x_l| = ΣΣ|x_k||P_kl||x_l| = ΣΣ|x_k|P_kl|x_l| = ΣΣ u_kP_klu_l = u^⊤Pu
# を、n = 1, …, 5 で成分が非負の有理数の行列 P と有理数のベクトル x について QQ で厳密に確かめる。


def bil(x, P, y):
    """def_real_bilinear_value: x^⊤Py := Σ_k Σ_l (x_k P_kl) y_l。"""
    n = len(x)
    return sum(sum((x[k] * P[k, l]) * y[l] for l in range(n)) for k in range(n))


def check(P, x):
    n = len(x)
    assert all(P[k, l] >= 0 for k in range(n) for l in range(n))
    u = [abs(x[k]) for k in range(n)]                                   # u_k := |x_k|
    t = lambda k, l: (x[k] * P[k, l]) * x[l]                            # 項 x_kP_klx_l
    steps = 0
    for k in range(n):                                                  # 準備の不等式
        assert abs(sum(t(k, l) for l in range(n))) <= sum(abs(t(k, l)) for l in range(n))
        steps += 1
        for l in range(n):                                              # 準備の |P_kl| = P_kl
            assert abs(P[k, l]) == P[k, l]
            steps += 1
    S = lambda f: sum(sum(f(k, l) for l in range(n)) for k in range(n))
    chain = [
        bil(x, P, x),
        abs(bil(x, P, x)),
        abs(S(t)),
        sum(abs(sum(t(k, l) for l in range(n))) for k in range(n)),
        S(lambda k, l: abs(t(k, l))),
        S(lambda k, l: abs(x[k] * P[k, l]) * abs(x[l])),
        S(lambda k, l: (abs(x[k]) * abs(P[k, l])) * abs(x[l])),
        S(lambda k, l: (abs(x[k]) * P[k, l]) * abs(x[l])),
        S(lambda k, l: (u[k] * P[k, l]) * u[l]),
        bil(u, P, u),
    ]
    rel = ['<=', '==', '<=', '<=', '==', '==', '==', '==', '==']        # 9 行の関係
    for i, r in enumerate(rel):
        a, b = chain[i], chain[i + 1]
        assert (a <= b) if r == '<=' else (a == b), (n, i + 1, a, b)
        steps += 1
    assert chain[0] <= chain[-1]
    return steps

set_random_seed(20261107)
total = 0
cases = 0
for n in range(1, 6):
    for _ in range(8):
        P = matrix(QQ, n, n, [QQ.random_element(num_bound=7, den_bound=4).abs() for _ in range(n * n)])
        x = [QQ.random_element(num_bound=9, den_bound=5) for _ in range(n)]
        total += check(P, x)
        cases += 1
# 否定コントロール: 成分が負の P では主張が崩れる例がある（P = [[0,-1],[-1,0]], x = (1,-1) で x^⊤Px = 2 > u^⊤Pu = -2）
Pn = matrix(QQ, 2, 2, [0, -1, -1, 0])
xn = [QQ(1), QQ(-1)]
assert bil(xn, Pn, xn) > bil([abs(c) for c in xn], Pn, [abs(c) for c in xn])
print(f"{cases} 組の (P, x)（n = 1..5）で準備と 9 行の鎖の {total} 段が成り立った。否定コントロール 1 件")
print("RESULT: PASS")
