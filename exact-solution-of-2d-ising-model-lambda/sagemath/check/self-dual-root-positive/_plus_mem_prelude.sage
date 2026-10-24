# 対象ラベル: claim_self_dual_root_plus_mem
# 帰属: QQ・QQbar・二次数体のみ。両平方根を別の埋込みとして扱う。
R_plus_mem = PolynomialRing(QQ, 'z_plus_mem')
z_plus_mem = R_plus_mem.gen()
plus_mem_roots = (z_plus_mem**2 - 2).roots(QQbar, multiplicities=False)
assert len(plus_mem_roots) == 2
j = QQbar
one_q = QQ(1)
one_k = QQbar(1)
minus_one_q = -one_q


def plus_mem_cases():
    for s in plus_mem_roots:
        assert s*s == j(QQ(2))
        yield s, -one_k + s


def reconstruct_in_quadratic_field(value, s):
    field = NumberField(z_plus_mem**2 - 2, 'r_plus_mem', embedding=s)
    embedded = field.hom([s], QQbar)
    # 期待する係数対を入力せず、QQbar の値を埋込み付き数体へ逆変換する。
    element = field(value)
    coefficients = element.polynomial()
    a = QQ(coefficients[0])
    b = QQ(coefficients[1])
    assert embedded(element) == value
    assert j(a) + j(b)*s == value
    return a, b
