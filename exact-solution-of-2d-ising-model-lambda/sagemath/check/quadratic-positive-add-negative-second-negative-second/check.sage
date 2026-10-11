# 対象ラベル: claim_quadratic_positive_add_negative_second_negative_second
# 帰属: QQ の厳密計算。浮動小数点を使わない。

BOUND = 6
positive = sorted(set(QQ(n) / QQ(d) for n in range(1, BOUND + 1) for d in range(1, BOUND + 1)))
negative = [-q for q in positive]

checked = 0
for a in positive:
    for b in negative:
        if not 2 * b * b < a * a:
            continue
        for ap in positive:
            for bp in negative:
                if not 2 * bp * bp < ap * ap:
                    continue
                A = a + ap
                B = b + bp
                cross_left = 2 * b * bp
                cross_right = a * ap
                assert A > 0
                assert B < 0
                assert cross_left >= 0
                assert cross_right >= 0
                assert cross_left * cross_left == (2 * b * b) * (2 * bp * bp)
                assert (2 * b * b) * (2 * bp * bp) < (a * a) * (2 * bp * bp)
                assert (a * a) * (2 * bp * bp) < (a * a) * (ap * ap)
                assert (a * a) * (ap * ap) == cross_right * cross_right
                assert cross_left < cross_right
                # 和の平方展開の鎖を一段ずつ検査する（本文の五段に対応）
                assert 2 * B * B == 2 * b * b + 2 * cross_left + 2 * bp * bp
                assert 2 * b * b + 2 * cross_left + 2 * bp * bp < a * a + 2 * cross_left + 2 * bp * bp
                assert a * a + 2 * cross_left + 2 * bp * bp < a * a + 2 * cross_right + 2 * bp * bp
                assert a * a + 2 * cross_right + 2 * bp * bp < a * a + 2 * cross_right + ap * ap
                assert a * a + 2 * cross_right + ap * ap == A * A
                assert 2 * B * B < A * A
                checked += 1

assert checked == 45369
print(f"RESULT: PASS (負の第二係数条件どうしの和: {checked} cases)")

from pathlib import Path
qps_check_dir = Path("sagemath/check/quadratic-positive-add-negative-second-negative-second")
if not qps_check_dir.is_dir():
    qps_check_dir = Path(".")
qps_check_paths = sorted(qps_check_dir.resolve().glob("check_*.sage"))
assert len(qps_check_paths) == 25
for qps_check_path in qps_check_paths:
    __file__ = str(qps_check_path)
    load(__file__)
print("RESULT: PASS (負の第二係数条件どうしの和: 本文25行すべて通過)")
