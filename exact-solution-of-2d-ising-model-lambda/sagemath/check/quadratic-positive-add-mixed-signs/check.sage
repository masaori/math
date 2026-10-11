# 対象ラベル: claim_quadratic_positive_add_mixed_signs
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 6
positive = sorted(set(QQ(n) / QQ(d) for n in range(1, BOUND + 1) for d in range(1, BOUND + 1)))
negative = [-q for q in positive]

checked = 0
first = 0
second = 0
third = 0
for a in positive:
    for b in negative:
        if not 2 * b * b < a * a:
            continue
        for ap in negative:
            for bp in positive:
                if not ap * ap < 2 * bp * bp:
                    continue
                c = -ap
                u = -b
                A = a + ap
                B = b + bp
                assert c > 0
                assert u > 0
                # 交差積の平方比較を本文の各段に合わせて検査する。
                assert (c * u) * (c * u) == (c * c) * (u * u)
                assert (c * c) * (u * u) < (2 * bp * bp) * (u * u)
                assert (2 * bp * bp) * (u * u) == (2 * u * u) * (bp * bp)
                assert (2 * u * u) * (bp * bp) < (a * a) * (bp * bp)
                assert (a * a) * (bp * bp) == (a * bp) * (a * bp)
                assert c * u < a * bp

                if A >= 0 and B >= 0:
                    assert (A, B) != (0, 0)
                    first += 1
                elif B < 0:
                    assert A > 0
                    U = u - bp
                    assert U > 0
                    # 比の比較 a·U < u·A を本文の三段に合わせて検査する。
                    assert a * U == a * u - a * bp
                    assert a * u - a * bp < a * u - c * u
                    assert a * u - c * u == u * A
                    assert a * U < u * A
                    assert (a * U) * (a * U) < (u * A) * (u * A)
                    assert (u * u) * (2 * U * U) < (u * u) * (A * A)
                    assert 2 * B * B < A * A
                    second += 1
                else:
                    assert A < 0
                    assert B > 0
                    C = c - a
                    assert C > 0
                    # 比の比較 b'·C < c·B を本文の三段に合わせて検査する。
                    assert bp * C == c * bp - a * bp
                    assert c * bp - a * bp < c * bp - c * u
                    assert c * bp - c * u == c * B
                    assert bp * C < c * B
                    assert (bp * C) * (bp * C) < (c * B) * (c * B)
                    assert (bp * bp) * (C * C) < (bp * bp) * (2 * B * B)
                    assert A * A < 2 * B * B
                    third += 1
                checked += 1

assert checked == 67308
assert (first, second, third) == (46944, 10182, 10182)
print(f"OK: 二つの混合符号条件の和を {checked} 組で厳密検査した "
      f"(第一条件 {first}, 第二条件 {second}, 第三条件 {third})")

from pathlib import Path
import sys
qpm_check_dir = Path(__file__).resolve().parent
if not (qpm_check_dir / '_prelude.sage').is_file():
    qpm_check_dir = Path(sys.argv[0]).resolve().parent
qpm_names = (
    "check_sum_representation.sage",
    "check_first_sum_definition.sage",
    "check_first_sum_subtraction.sage",
    "check_first_sum_replace.sage",
    "check_second_sum_definition.sage",
    "check_second_sum_commute.sage",
    "check_second_sum_subtraction.sage",
    "check_second_sum_replace.sage",
    "check_first_positive.sage",
    "check_negated_first_positive.sage",
    "check_negated_second_positive.sage",
    "check_second_prime_positive.sage",
    "check_second_square_definition.sage",
    "check_second_square_signs.sage",
    "check_first_square_definition.sage",
    "check_first_square_signs.sage",
    "check_left_square_replace.sage",
    "check_left_square_bound.sage",
    "check_right_square_replace.sage",
    "check_right_square_bound.sage",
    "check_second_square_positive.sage",
    "check_second_prime_square_positive.sage",
    "check_cross_left_positive.sage",
    "check_cross_left_nonnegative.sage",
    "check_cross_right_positive.sage",
    "check_cross_right_nonnegative.sage",
    "check_cross_square_expand.sage",
    "check_cross_square_expand_middle.sage",
    "check_cross_square_expand_finish.sage",
    "check_cross_square_right_condition.sage",
    "check_cross_square_rearrange.sage",
    "check_cross_square_rearrange_middle.sage",
    "check_cross_square_rearrange_finish.sage",
    "check_cross_square_left_condition.sage",
    "check_cross_square_fold.sage",
    "check_cross_square_fold_middle.sage",
    "check_cross_square_fold_finish.sage",
    "check_cross_comparison.sage",
    "check_nonnegative_zero_first.sage",
    "check_nonnegative_zero_second.sage",
    "check_nonnegative_first_equal.sage",
    "check_nonnegative_second_equal.sage",
    "check_nonnegative_cross_first.sage",
    "check_nonnegative_cross_second.sage",
    "check_nonnegative_pair_nonzero.sage",
    "check_nonnegative_membership.sage",
    "check_negative_second_order.sage",
    "check_negative_second_zero_first.sage",
    "check_negative_second_opposite_strict.sage",
    "check_negative_second_opposite_equal.sage",
    "check_negative_second_first_positive.sage",
    "check_negative_second_magnitude_definition.sage",
    "check_negative_second_magnitude_negate.sage",
    "check_negative_second_magnitude_replace.sage",
    "check_negative_second_magnitude_positive.sage",
    "check_negative_second_ratio_definition.sage",
    "check_negative_second_ratio_expand.sage",
    "check_negative_second_ratio_strict.sage",
    "check_negative_second_ratio_factor.sage",
    "check_negative_second_ratio_commute.sage",
    "check_negative_second_ratio_replace.sage",
    "check_negative_second_ratio_left_positive.sage",
    "check_negative_second_ratio_right_positive.sage",
    "check_negative_second_square_positive.sage",
    "check_negative_second_ratio_square_right.sage",
    "check_negative_second_ratio_square_left.sage",
    "check_negative_second_scaled_rearrange.sage",
    "check_negative_second_scaled_rearrange_middle.sage",
    "check_negative_second_scaled_condition.sage",
    "check_negative_second_scaled_fold.sage",
    "check_negative_second_scaled_fold_middle.sage",
    "check_negative_second_scaled_fold_finish.sage",
    "check_negative_second_scaled_ratio.sage",
    "check_negative_second_scaled_expand.sage",
    "check_negative_second_scaled_expand_middle.sage",
    "check_negative_second_scaled_expand_finish.sage",
    "check_negative_second_cancel.sage",
    "check_negative_second_square_replace.sage",
    "check_negative_second_square_negations.sage",
    "check_negative_second_final_replace.sage",
    "check_negative_second_final_bound.sage",
    "check_negative_second_membership.sage",
    "check_negative_first_order.sage",
    "check_negative_first_nonpositive_second.sage",
    "check_negative_first_opposite_strict.sage",
    "check_negative_first_opposite_weak.sage",
    "check_negative_first_second_positive.sage",
    "check_negative_first_magnitude_definition.sage",
    "check_negative_first_magnitude_negate.sage",
    "check_negative_first_magnitude_replace.sage",
    "check_negative_first_magnitude_positive.sage",
    "check_negative_first_ratio_definition.sage",
    "check_negative_first_ratio_expand.sage",
    "check_negative_first_ratio_commute.sage",
    "check_negative_first_ratio_strict.sage",
    "check_negative_first_ratio_factor.sage",
    "check_negative_first_ratio_replace.sage",
    "check_negative_first_ratio_left_positive.sage",
    "check_negative_first_ratio_right_positive.sage",
    "check_negative_first_square_positive.sage",
    "check_negative_first_ratio_square_right.sage",
    "check_negative_first_ratio_square_left.sage",
    "check_negative_first_scaled_fold.sage",
    "check_negative_first_scaled_fold_middle.sage",
    "check_negative_first_scaled_fold_finish.sage",
    "check_negative_first_scaled_ratio.sage",
    "check_negative_first_scaled_expand.sage",
    "check_negative_first_scaled_expand_middle.sage",
    "check_negative_first_scaled_expand_finish.sage",
    "check_negative_first_scaled_condition.sage",
    "check_negative_first_scaled_rearrange.sage",
    "check_negative_first_scaled_rearrange_middle.sage",
    "check_negative_first_cancel.sage",
    "check_negative_first_square_replace.sage",
    "check_negative_first_square_negations.sage",
    "check_negative_first_final_replace.sage",
    "check_negative_first_final_bound.sage",
    "check_negative_first_membership.sage",
)
qpm_paths = tuple(qpm_check_dir / name for name in qpm_names)
assert len(qpm_paths) == 118
assert set(qpm_paths) == set(qpm_check_dir.glob('check_*.sage'))
for qpm_path in qpm_paths:
    __file__ = str(qpm_path)
    load(__file__)
print("RESULT: PASS (二つの混合符号条件の和: 本文118行すべて通過)")
