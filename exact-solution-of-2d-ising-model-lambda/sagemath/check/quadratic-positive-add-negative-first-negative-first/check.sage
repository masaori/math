# 対象ラベル: claim_quadratic_positive_add_negative_first_negative_first
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 6
positive = sorted(set(QQ(n) / QQ(d) for n in range(1, BOUND + 1) for d in range(1, BOUND + 1)))
negative = [-q for q in positive]

checked = 0
for a in negative:
    for b in positive:
        if not a * a < 2 * b * b:
            continue
        for ap in negative:
            for bp in positive:
                if not ap * ap < 2 * bp * bp:
                    continue
                A = a + ap
                B = b + bp
                cross_left = a * ap
                cross_right = 2 * b * bp
                assert A < 0
                assert B > 0
                assert cross_left >= 0
                assert cross_right >= 0
                # 交差項の平方比較の鎖を一段ずつ検査する（本文の四段に対応）
                assert cross_left * cross_left == (a * a) * (ap * ap)
                assert (a * a) * (ap * ap) < (2 * b * b) * (ap * ap)
                assert (2 * b * b) * (ap * ap) < (2 * b * b) * (2 * bp * bp)
                assert (2 * b * b) * (2 * bp * bp) == cross_right * cross_right
                assert cross_left < cross_right
                # 和の平方展開の鎖を一段ずつ検査する（本文の五段に対応）
                assert A * A == a * a + 2 * cross_left + ap * ap
                assert a * a + 2 * cross_left + ap * ap < 2 * b * b + 2 * cross_left + ap * ap
                assert 2 * b * b + 2 * cross_left + ap * ap < 2 * b * b + 2 * cross_right + ap * ap
                assert 2 * b * b + 2 * cross_right + ap * ap < 2 * b * b + 2 * cross_right + 2 * bp * bp
                assert 2 * b * b + 2 * cross_right + 2 * bp * bp == 2 * B * B
                assert A * A < 2 * B * B
                checked += 1

assert checked == 99856
print(f"RESULT: PASS (負の第一係数条件どうしの和: {checked} cases)")

from pathlib import Path
import sys
qpf_check_dir = Path(__file__).resolve().parent
if not (qpf_check_dir / '_prelude.sage').is_file():
    qpf_check_dir = Path(sys.argv[0]).resolve().parent
qpf_check_names = (
    "check_sum_representation.sage",
    "check_first_sum_negative.sage",
    "check_first_zero_add.sage",
    "check_second_zero_add.sage",
    "check_second_sum_positive.sage",
    "check_first_product_positive.sage",
    "check_first_product_nonnegative.sage",
    "check_second_product_positive.sage",
    "check_cross_positive.sage",
    "check_cross_nonnegative.sage",
    "check_first_prime_square_positive.sage",
    "check_second_square_positive.sage",
    "check_weighted_second_square_positive.sage",
    "check_product_square_expand.sage",
    "check_product_square_left.sage",
    "check_product_square_right.sage",
    "check_product_square_fold.sage",
    "check_cross_comparison.sage",
    "check_cross_twice.sage",
    "check_sum_square_expand.sage",
    "check_sum_square_first.sage",
    "check_sum_square_cross.sage",
    "check_sum_square_second.sage",
    "check_sum_square_fold.sage",
    "check_cone_membership.sage",
)
qpf_check_paths = tuple(qpf_check_dir / name for name in qpf_check_names)
assert len(qpf_check_paths) == 25
assert set(qpf_check_paths) == set(qpf_check_dir.glob("check_*.sage"))
for qpf_check_path in qpf_check_paths:
    __file__ = str(qpf_check_path)
    load(__file__)
print("RESULT: PASS (負の第一係数条件どうしの和: 本文25行すべて通過)")
