# 対象ラベル: factorization_of_A_theta_general
# Step 2・3 の鎖の末尾の 4 項（3 つの等号）:
#   (c_1)_C(c_2^*)_C - (s_1)_C(s_2^*)_C(cos θ)_C
#   = (c_1c_2^*)_C - (s_1s_2^*)_C(cos θ)_C      （real_inclusion_preserves_product を 2 箇所へ）
#   = (c_1c_2^*)_C - (s_1s_2^* cos θ)_C          （real_inclusion_preserves_product）
#   = (c_1c_2^* - s_1s_2^* cos θ)_C              （real_inclusion_preserves_difference）
# と、終点が def_A_theta の (1,1)・(2,2) 成分（実数 c_1c_2^* - s_1s_2^* cos θ の inclusion_rr_to_cc による像）であること。
# ℂ は definition_of_cc どおり実数の対で持ち（complex_as_real_pairs.sage）、c_1, c_2^*, s_1, s_2^*, cos θ を QQ 上の多項式環の
# 不定元に置く（実数の積は左から括る）。不定元の多項式の等号は、任意の実数を代入しても保たれる（代入は環準同型）。
load("../../_shared/complex_as_real_pairs.sage")


def report(ok, label):
    print(("PASS: " if ok else "FAIL: ") + label)
    assert ok, label


T = PolynomialRing(QQ, ['c1', 'c2s', 's1', 's2s', 'co'])
c1r, c2sr, s1r, s2sr, cor = T.gens()
inc = lambda r: iota(r, T)
lines = [
    ("(c_1)_C(c_2^*)_C - (s_1)_C(s_2^*)_C(cos θ)_C",
     cc_sub(cc_mul(inc(c1r), inc(c2sr)), cc_mul(cc_mul(inc(s1r), inc(s2sr)), inc(cor)), T)),
    ("(c_1c_2^*)_C - (s_1s_2^*)_C(cos θ)_C",
     cc_sub(inc(c1r * c2sr), cc_mul(inc(s1r * s2sr), inc(cor)), T)),
    ("(c_1c_2^*)_C - (s_1s_2^* cos θ)_C",
     cc_sub(inc(c1r * c2sr), inc((s1r * s2sr) * cor), T)),
    ("(c_1c_2^* - s_1s_2^* cos θ)_C",
     inc(c1r * c2sr - (s1r * s2sr) * cor)),
]
for (n0, v0), (n1, v1) in zip(lines, lines[1:]):
    report(v0 == v1, f"Step 2・3 の末尾: 「{n0}」=「{n1}」")
# 終点が def_A_theta の (1,1)・(2,2) 成分（実数の式の像）
A11_real = c1r * c2sr - s1r * s2sr * cor
report(lines[-1][1] == inc(A11_real) and lines[-1][1][1] == 0, "終点 = def_A_theta の (1,1)・(2,2) 成分 (c_1c_2^* - s_1s_2^* cos θ)_C（虚部 0）")
# 対照: 実数の像でない数（虚部が 0 でない）を一つ混ぜると、終点は実数の像にならない
bad = cc_sub(cc_mul(inc(c1r), (c2sr, T(1))), cc_mul(cc_mul(inc(s1r), inc(s2sr)), inc(cor)), T)
report(bad != inc(A11_real), "対照: c_2^* の位置に虚部 1 の数を置くと実数の像にならない")
print("RESULT: PASS")
