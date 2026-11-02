# 対象ラベル: real_inclusion_preserves_product
# 証明の五つの等号（六つの項）:
#   a_C b_C = (a,0)(b,0) = (ab - 0·0, a·0 + 0·b) = (ab - 0, 0 + 0) = (ab, 0) = (ab)_C
# ℂ を実数の対として持ち（definition_of_cc）、a, b を QQ 上の多項式環の不定元に置く。対の積は
# definition_of_cc の式 (x,y)(u,v) = (xu - yv, xv + yu) を書いた関数と、QQ(i)[a,b] の積の二つの経路で作る。
# 不定元の多項式の等号は厳密に決まり、任意の実数を代入しても保たれる。帰属: QQ[a,b]。
R.<a, b> = PolynomialRing(QQ)

def incl(r):
    """inclusion_rr_to_cc: r_C := (r, 0)。"""
    return (r, R(0))

def pair_mul(z, w):
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])

chain = [pair_mul(incl(a), incl(b)),
         pair_mul((a, R(0)), (b, R(0))),
         (a * b - 0 * 0, a * 0 + 0 * b),
         (a * b - 0, R(0) + 0),
         (a * b, R(0)),
         incl(a * b)]
assert all(c == chain[0] for c in chain)
# 独立な経路: QQ(i)[a,b] で a·b を計算し、実部・虚部を読む
K.<I> = QuadraticField(-1)
S.<A, B> = PolynomialRing(K)
p = (A + 0 * I) * (B + 0 * I)
re = sum(c.real() * m for c, m in zip(p.coefficients(), p.monomials()))
im = sum(c.imag() * m for c, m in zip(p.coefficients(), p.monomials()))
assert re == A * B and im == 0
# 対照: 虚部が 0 でない数どうしの積は実部が積にならない
assert pair_mul((a, R(1)), (b, R(1)))[0] != a * b
print("checked the chain of 6 terms with indeterminates a, b")
print("RESULT: PASS")
