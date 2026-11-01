# 本文 definition_of_cc の ℂ を、実数の対 (a, b) とその和・積の定義式どおりに持つ。
# Sage の複素数（CC・QQ(i)）は使わず、対の成分の環 R（QQ、QQ 上の多項式環、AA など）だけを使う。
# 本文の inclusion_rr_to_cc の r_C = (r, 0)（1_C・-1_C はその略記の r = 1, -1）と、multiply_by_minus_one の
# -z := (-1_C) z もここに置く。ℂ の差 z - w := z + (-w) は本文に定義が無く、証明が使う形をここで置いたもの。


def cc_add(z, w):
    """definition_of_cc の和 (a,b) + (c,d) := (a+c, b+d)。"""
    return (z[0] + w[0], z[1] + w[1])


def cc_mul(z, w):
    """definition_of_cc の積 (a,b)(c,d) := (ac - bd, ad + bc)。"""
    return (z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0])


def iota(r, R):
    """inclusion_rr_to_cc の r_C := (r, 0)。R は成分の環。"""
    return (R(r), R(0))


def cc_neg(z, R):
    """multiply_by_minus_one の -z := (-1_C) z。-1_C は inclusion_rr_to_cc の略記 r_C の r = -1。"""
    return cc_mul(iota(-1, R), z)


def cc_sub(z, w, R):
    """ℂ の差 z - w := z + (-w)。"""
    return cc_add(z, cc_neg(w, R))


def cc_power(z, m, R):
    """scalar_exp_is_limit_of_partial_sums の冪の約束 z^0 := 1_C、z^{m+1} := z^m z を K = ℂ で。"""
    p = iota(1, R)
    for _ in range(m):
        p = cc_mul(p, z)
    return p


def cc_abs_aa(z):
    """def_abs_arg の |z| を abs_basic_properties (1) の √(x^2+y^2)（非負の平方根）として AA の中で厳密に取る。"""
    total = AA(z[0])^2 + AA(z[1])^2
    r = total.sqrt()
    assert r >= 0 and r^2 == total
    return r
