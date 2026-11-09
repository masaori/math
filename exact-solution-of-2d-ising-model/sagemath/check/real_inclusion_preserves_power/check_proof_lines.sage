# 対象ラベル: real_inclusion_preserves_power
# r ∈ ℝ、m ∈ ℤ_{≥0} について (r^m)_ℂ = (r_ℂ)^m。m = 0 の 3 行と帰納法の段の 4 行を一行ずつ確かめる。
# ℂ を実数の対として持ち（definition_of_cc）、r を QQ 上の多項式環の不定元に置く。ℝ の冪は def_power_of_real_number の再帰、
# ℂ の冪は def_power_of_complex_number の再帰（対の積は definition_of_cc の式）で作る。不定元の多項式の等号は厳密に決まり、
# 任意の実数を代入しても保たれる（代入は環準同型である）。帰属: QQ[r]。
load("../../_shared/inclusion_zz_to_rr_by_definition.sage")
R.<r> = PolynomialRing(QQ)

def incl(x):
    """inclusion_rr_to_cc: x_C := (x, 0)。"""
    return (R(x), R(0))

def pair_mul(z, w):
    """definition_of_cc の積。"""
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

ONE_C = incl(1)

def cpow(z, m):
    """def_power_of_complex_number: z^0 := 1_C、z^{m+1} := z^m z。"""
    out = ONE_C
    for _ in range(m):
        out = pair_mul(out, z)
    return out

rpow = lambda m: power_of_real_by_definition(r, m)
K.<I> = QuadraticField(-1)
S.<s> = PolynomialRing(K)
cnt = 0
# m = 0 の 3 行: (r^0)_C = (1_R)_C = 1_C = (r_C)^0
L = [incl(rpow(0)), incl(R(1)), ONE_C, cpow(incl(r), 0)]
for x, y in zip(L, L[1:]):
    assert x == y; cnt += 1
for m in range(0, 13):
    ih = incl(rpow(m)) == cpow(incl(r), m)
    assert ih; cnt += 1                                            # 帰納法の仮定（m で主張が成り立つ）
    # 帰納法の段の 4 行: (r^{m+1})_C = (r^m r)_C = (r^m)_C r_C = (r_C)^m r_C = (r_C)^{m+1}
    L = [incl(rpow(m + 1)), incl(rpow(m) * r), pair_mul(incl(rpow(m)), incl(r)),
         pair_mul(cpow(incl(r), m), incl(r)), cpow(incl(r), m + 1)]
    for x, y in zip(L, L[1:]):
        assert x == y; cnt += 1
    # 独立な経路: QQ(i)[s] の組み込みの冪の実部・虚部
    p = (s + 0 * I) ** m
    re = sum(c.real() * r ** e for c, e in zip(p.coefficients(sparse=False), range(p.degree() + 1)))
    im = sum(c.imag() * r ** e for c, e in zip(p.coefficients(sparse=False), range(p.degree() + 1)))
    assert (R(re), R(im)) == cpow(incl(r), m); cnt += 1
# 否定コントロール: 虚部が 0 でない数の 2 乗は、実部の 2 乗の包含にならない
assert cpow((r, R(1)), 2) != incl(r ** 2)
print(f"real_inclusion_preserves_power: 等号 {cnt} 個")
print("RESULT: PASS")
