# 対象ラベル: antiperiodic_exp_sum
# 主張を本文の exp で確かめる。ℝ への脱出はここだけ（π と exp の値）。
# 本文の exp（def_scalar_exp。部分和の極限）の値 exp(i(x)_C) を、x を囲む実数のボール（π は Arb の 512 bit のボール）から
# 部分和 Σ_{p=0}^{N} (ix)^p/p! を冪を右から 1 つずつ掛けて組み、尾 Σ_{p>N} r^p/p! ≤ 2r^{N+1}/(N+1)!（N + 2 ≥ 2r、r は |x| の上界）を
# 半径に足したボールで囲む。N = 4⌈r⌉ + 60 とし、ボールの半径が 2^{-100} 未満であることも確かめる。
# (1) E(q)（UCF の 1 の冪根）が、本文の exp(i(2πq)_C) のボールに入る（M_col = 2..8 で証明に現れる全ての q）。
# (2) 主張の左辺 Σ_μ exp(i(k_R θ̃_μ)_C) を θ̃ の定義の式のままボールで組み、右辺の場合分け（l の偶奇、非整除）の値と重なる。
# 対照: 右辺の (-1)^l を外すと、l が奇数の k で交わらない。
load("_prelude.sage")
RB = RealBallField(512)
CB = ComplexBallField(512)
PI = RB.pi()


def body_exp_i_ball(xb, N=None):
    xb = RB(xb)
    r = xb.abs().upper()
    if N is None:
        N = 4 * ceil(r) + 60
    assert N + 2 >= 2 * r
    z = CB(0, 1) * CB(xb)
    S = CB(0)
    power = CB(1)
    for p in range(N + 1):
        S = S + power / factorial(p)
        power = power * z
    tail = 2 * RB(r) ** (N + 1) / factorial(N + 1)
    return S.add_error(tail.upper())


def ucf_to_ball(u):
    return CB(QQbar(u))


def rhs(M, k):
    if k % M == 0:
        return to_C(M) * minus_one_power(k // M)
    return UCF(0)


for M in M_RANGE:
    qs = set()
    for k in K_RANGE(M):
        for mu in range(1, M + 1):
            qs.add(QQ(k) * theta_tilde_over_2pi(M, mu))
        for r in range(1, 2 * M + 1):
            qs.add(QQ(r) * QQ(k) / QQ(2 * M))
    for q in qs:
        assert ucf_to_ball(E(q)).overlaps(body_exp_i_ball(2 * PI * q))
        assert RR(body_exp_i_ball(2 * PI * q).rad()) < RR(2) ** -100
    broke = False
    for k in K_RANGE(M):
        lhs = sum(body_exp_i_ball(RB(k) * (2 * PI * (RB(mu) - RB(1) / 2) / RB(M))) for mu in range(1, M + 1))
        assert lhs.overlaps(ucf_to_ball(rhs(M, k)))
        if k % M == 0 and (k // M) % 2 != 0:
            if not lhs.overlaps(ucf_to_ball(to_C(M))):
                broke = True
    assert broke
    print(f"  M_col={M}: E(q) が本文の exp のボールに入り（{len(qs)} 個の q）、主張の両辺のボールが k = {-3*M}..{3*M} で重なる。(-1)^l を外すと交わらない")
print("RESULT: PASS")
