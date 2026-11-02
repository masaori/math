# 対象ラベル: extract_taylor_coefficient_of_check_Z_Y
# 共通の準備は _shared/half_integer_check_operators.sage（Ž_μ・Y̌_μ・H_1^(+)・H_2 を本文の成分の式で、位相を円分体 QQ(ζ_{4M}) の 1 の冪根で持つ。
# cosh_sinh_coefficient_conversion_for_check の検算と共有）、_shared/complex_as_real_pairs.sage（definition_of_cc の ℂ を実数の対で持つ）、
# _shared/one_by_one_matrix.sage（本文の実数の exp を囲むボール body_real_exp_ball）。
load("../../_shared/half_integer_check_operators.sage")
load("../../_shared/complex_as_real_pairs.sage")
load("../../_shared/one_by_one_matrix.sage")


def pw(x, e):
    """冪の約束 x^0 := 1、x^{m+1} := x^m x のとおりに右から 1 つずつ掛けて作る。"""
    out = x.parent()(1)
    for _ in range(e):
        out = out * x
    return out


def run_chain(lines, label):
    for (n0, v0), (n1, v1) in zip(lines, lines[1:]):
        report(v0 == v1, f"{label}: 「{n0}」=「{n1}」")
