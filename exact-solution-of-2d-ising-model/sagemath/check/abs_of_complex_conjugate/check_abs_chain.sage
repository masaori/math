# 対象ラベル: abs_of_complex_conjugate
# 鎖の 4 行を一行ずつ。ℂ を本文 definition_of_cc どおり実数の対で持つ（_shared/complex_as_real_pairs.sage）。
# 根号の中の等式は QQ[x, y] の不定元で、根号を取った値は実代数的数 AA の具体の点で厳密に確かめる。
# 比べる側は Sage の QQbar の abs と conjugate。浮動小数点は使わない。
load("../../_shared/complex_as_real_pairs.sage")

P = PolynomialRing(QQ, ['x', 'y'])
x, y = P.gens()
cz = cc_conj((x, y))
assert cz == (x, -y)                                 # |conj z| = |(x,-y)|  (def_complex_conjugate)
rad = [cz[0]^2 + cz[1]^2, x^2 + (-y)^2, x^2 + y^2]   # 根号の中: abs_basic_properties (1) を (x,-y) に、ℝ で (-y)^2 = y^2、(x,y) に
assert rad[0] == rad[1] == rad[2]
print("根号の中の 2 個の等号を QQ[x, y] で確かめた")

set_random_seed(17)
pts = [(QQ(0), QQ(0)), (QQ(3), QQ(-4)), (QQ(-1), QQ(1)), (QQ(1)/2, QQ(-7)/3)]
pts += [(QQ.random_element(10, 10), QQ.random_element(10, 10)) for _ in range(20)]
for (a, b) in pts:
    z = (a, b)
    lines = [
        cc_abs_aa(cc_conj(z)),               # |conj z|
        cc_abs_aa((a, -b)),                  # |(x,-y)|                (def_complex_conjugate)
        AA(a^2 + (-b)^2).sqrt(),             # √(x^2 + (-y)^2)         (abs_basic_properties (1))
        AA(a^2 + b^2).sqrt(),                # √(x^2 + y^2)            (ℝ)
        cc_abs_aa(z),                        # |z|                     (abs_basic_properties (1))
    ]
    for t in range(len(lines) - 1):
        assert lines[t] == lines[t + 1], (z, t)
    q = QQbar(a) + QQbar(I) * QQbar(b)
    assert lines[0] == AA(q.conjugate().abs()) and lines[-1] == AA(q.abs())
print(f"{len(pts)} 個の具体の点で、鎖の 4 個の等号と両端の Sage の abs との一致を AA で確かめた")
print("RESULT: PASS")
