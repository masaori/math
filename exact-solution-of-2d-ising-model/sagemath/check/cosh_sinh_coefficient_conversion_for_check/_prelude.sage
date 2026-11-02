# 対象ラベル: cosh_sinh_coefficient_conversion_for_check
# 共通の準備は _shared/half_integer_check_operators.sage（nesting_of_commutator_of_H_and_check_Z と共有）と
# _shared/complex_as_real_pairs.sage（definition_of_cc の ℂ を実数の対で持つ）。
load("../../_shared/half_integer_check_operators.sage")
load("../../_shared/complex_as_real_pairs.sage")


def pw(x, e):
    """冪の約束 x^0 := 1、x^{m+1} := x^m x（scalar_exp_is_limit_of_partial_sums）のとおりに右から 1 つずつ掛けて作る。"""
    out = x.parent()(1)
    for _ in range(e):
        out = out * x
    return out


def run_chain(lines, label):
    for (n0, v0), (n1, v1) in zip(lines, lines[1:]):
        report(v0 == v1, f"{label}: 「{n0}」=「{n1}」")
