# inclusion_zz_to_rr の ι_{ℤ→ℝ} を、定義の三つの式のとおり再帰で作る。
# 値の側の ℝ は QQ（有理数。厳密な比較）で表す。Sage の組み込みの埋め込み QQ(n) とは別の経路で作り、両者が一致することも確かめる。


def iota_zz_to_rr(n):
    """ι(0) := 0_ℝ、ι(n + 1) := ι(n) + 1_ℝ（n ≥ 0）、ι(-n) := -ι(n)（n ≥ 1）。"""
    n = ZZ(n)
    if n < 0:
        return -iota_zz_to_rr(-n)
    v = QQ(0)
    for _ in range(n):
        v = v + QQ(1)
    return v


def finite_sum_by_definition(terms):
    """def_finite_sum_of_real_numbers: Σ_{j=1}^{1} r_j := r_1、Σ_{j=1}^{m+1} r_j := (Σ_{j=1}^{m} r_j) + r_{m+1}。"""
    assert len(terms) >= 1
    s = terms[0]
    for t in terms[1:]:
        s = s + t
    return s


def power_of_real_by_definition(a, m):
    """def_power_of_real_number: a^0 := 1、a^{m+1} := a^m a。"""
    p = a.parent()(1)
    for _ in range(m):
        p = p * a
    return p


def power_of_integer_by_definition(a, m):
    """def_power_of_integer: a^0 := 1_ℤ、a^{m+1} := a^m a（ZZ）。"""
    p = ZZ(1)
    for _ in range(m):
        p = p * ZZ(a)
    return p
