# 対象ラベル: complex_conjugate_of_sum
# 準備（二つの和）の鎖と、帰納法の m = 1 の鎖・m → m+1 の鎖を一行ずつ。
# ℂ を本文 definition_of_cc どおり実数の対で持つ（_shared/complex_as_real_pairs.sage）。成分は QQ 上の多項式環の不定元。
# 比べる側: 対 (x, y) を QQ(i) 係数の多項式 x + i y へ送り、Sage の係数の共役（x, y は実の不定元なので複素共役に当たる）と比べる。
load("../../_shared/complex_as_real_pairs.sage")

K = QuadraticField(-1, 'i')
i_K = K.gen()


def to_gauss(z, PK):
    return PK(z[0]) + i_K * PK(z[1])


def sage_conj(p):
    return p.map_coefficients(lambda c: c.conjugate())


# 準備（二つの和）
P = PolynomialRing(QQ, ['x', 'y', 'u', 'v'])
x, y, u, v = P.gens()
z, w = (x, y), (u, v)
lines = [
    cc_conj(cc_add(z, w)),                 # conj(z + w)
    cc_conj((x + u, y + v)),               # conj((x+u, y+v))      (definition_of_cc の和)
    (x + u, -(y + v)),                     # (x+u, -(y+v))         (def_complex_conjugate)
    (x + u, (-y) + (-v)),                  # (x+u, (-y)+(-v))      (ℝ)
    cc_add((x, -y), (u, -v)),              # (x,-y) + (u,-v)       (definition_of_cc の和)
    cc_add(cc_conj(z), cc_conj(w)),        # conj z + conj w       (def_complex_conjugate)
]
for t in range(len(lines) - 1):
    assert lines[t] == lines[t + 1], t
PK = PolynomialRing(K, ['x', 'y', 'u', 'v'])
assert to_gauss(lines[0], PK) == sage_conj(to_gauss(z, PK) + to_gauss(w, PK))
print("準備（二つの和）: 鎖の 5 個の等号と両端を不定元で確かめた")


def body_finite_sum(zs):
    """def_finite_sum_of_complex_numbers の有限和: Σ_{j=1}^{1} z_j := z_1、Σ_{j=1}^{m+1} := (Σ_{j=1}^{m}) + z_{m+1}。"""
    s = zs[0]
    for q in zs[1:]:
        s = cc_add(s, q)
    return s


MAX_M = 7
for m in range(1, MAX_M + 1):
    Pm = PolynomialRing(QQ, [f"{c}{j}" for j in range(1, m + 2) for c in "xy"])
    g = Pm.gens()
    zs = [(g[2 * j], g[2 * j + 1]) for j in range(m + 1)]   # z_1, …, z_{m+1}
    if m == 1:
        chain1 = [cc_conj(body_finite_sum(zs[:1])), cc_conj(zs[0]), body_finite_sum([cc_conj(q) for q in zs[:1]])]
        assert chain1[0] == chain1[1] == chain1[2]
    # m → m+1 の鎖。帰納法の仮定の行は、m 項の主張が成り立つことを直接確かめてから使う
    hyp_l = cc_conj(body_finite_sum(zs[:m]))
    hyp_r = body_finite_sum([cc_conj(q) for q in zs[:m]])
    assert hyp_l == hyp_r
    step = [
        cc_conj(body_finite_sum(zs[:m + 1])),                     # conj(Σ^{m+1})
        cc_conj(cc_add(body_finite_sum(zs[:m]), zs[m])),          # conj(Σ^m + z_{m+1})   (def_finite_sum_of_complex_numbers)
        cc_add(cc_conj(body_finite_sum(zs[:m])), cc_conj(zs[m])),  # conj Σ^m + conj z_{m+1} (準備)
        cc_add(hyp_r, cc_conj(zs[m])),                            # (Σ^m conj) + conj z_{m+1} (帰納法の仮定)
        body_finite_sum([cc_conj(q) for q in zs[:m + 1]]),        # Σ^{m+1} conj          (def_finite_sum_of_complex_numbers)
    ]
    for t in range(len(step) - 1):
        assert step[t] == step[t + 1], (m, t)
    PKm = PolynomialRing(K, Pm.variable_names())
    assert to_gauss(step[0], PKm) == sage_conj(sum(to_gauss(q, PKm) for q in zs[:m + 1]))
    print(f"m = {m} → {m+1}: 鎖の 4 個の等号と、両端の Sage の共役との一致を不定元で確かめた")

# 具体の QQ(i) の点で、主張の両端を Sage の conjugate と比べる
set_random_seed(5)
for m in range(1, MAX_M + 2):
    vals = [K(QQ.random_element(10, 10)) + i_K * K(QQ.random_element(10, 10)) for _ in range(m)]
    pairs = [(QQ(a.real()), QQ(a.imag())) for a in vals]
    lhs = cc_conj(body_finite_sum(pairs))
    rhs = body_finite_sum([cc_conj(q) for q in pairs])
    s_conj = sum(vals).conjugate()
    assert lhs == rhs == (QQ(s_conj.real()), QQ(s_conj.imag()))
print(f"m = 1,…,{MAX_M+1} の具体の QQ(i) の点で、主張の両端が Sage の conjugate と一致した")
print("RESULT: PASS")
