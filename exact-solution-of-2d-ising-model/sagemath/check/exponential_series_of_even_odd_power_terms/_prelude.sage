# 対象ラベル: exponential_series_of_even_odd_power_terms
# 共通の準備: hyperbolic_by_definition.sage（本文の実数の exp を囲むボール。one_by_one_matrix.sage の GAUSSIAN = QQ(i) も読む）、
# matrix_operations_by_definition.sage・matrix_negation_and_difference_by_definition.sage（行列の和・スカラー倍・差を本文の成分の式で組む）、
# complex_as_real_pairs.sage（definition_of_cc の ℂ を実数の対で持つ。real_inclusion_preserves_power の当てはめと実数の差の像を、包含 r ↦ (r, 0) を区別して確かめる）。
load("../../_shared/hyperbolic_by_definition.sage")
load("../../_shared/matrix_operations_by_definition.sage")
load("../../_shared/matrix_negation_and_difference_by_definition.sage")
load("../../_shared/complex_as_real_pairs.sage")


def report(ok, label):
    print(("PASS: " if ok else "FAIL: ") + label)
    assert ok, label


def run_chain(lines, label):
    """隣り合う行の値が等しいことを確かめる。lines は (行の式, 値) の列。"""
    for (n0, v0), (n1, v1) in zip(lines, lines[1:]):
        report(v0 == v1, f"{label}: 「{n0}」=「{n1}」")


def rpow(x, m):
    """冪の約束 y^0 := 1、y^{m+1} := y^m y を右から 1 つずつ掛けて作る（ℝ・ℂ 共通）。"""
    out = x.parent()(1)
    for _ in range(m):
        out = out * x
    return out
