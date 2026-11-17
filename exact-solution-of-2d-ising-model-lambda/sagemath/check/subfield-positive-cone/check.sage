# 対象ラベル: def_subfield_positive_cone
# QQ の厳密計算だけを使う。浮動小数点を使わない。
# 定義の三条件（和で閉じる・積で閉じる・F の各元の三分法）を、二つのモデルの有限標本で検査する。
#   モデル 1: F = QQ、C = 正の有理数の全体。
#   モデル 2: F = Q_s（s*s = 2）。元 a + b*s を有理数の組 (a, b) で表し、
#             C = 二次体の正錐 P_s（def_quadratic_positive_cone の三つの有理条件）。
# 反例として、F = QQ、C = 負の有理数の全体が積で閉じないことも確かめる
# （三条件が実際に部分集合を選り分けることの確認）。普遍量化された条件の証明ではない。

from itertools import product

RATIONAL_SAMPLES = [QQ(0), QQ(1), QQ(-1), QQ(2), QQ(-3), QQ(1)/2, QQ(-5)/7, QQ(7)/3]


def check_exactly_one(flags):
    return sum(1 for f in flags if f) == 1


def check_rational_model():
    cone = lambda a: a > 0
    for a, b in product(RATIONAL_SAMPLES, repeat=2):
        if cone(a) and cone(b):
            assert cone(a + b) and cone(a * b)
    for z in RATIONAL_SAMPLES:
        assert check_exactly_one([z == 0, cone(z), cone(-z)])
    print("モデル 1（F = QQ、C = 正の有理数）: 標本 %d 点で三条件が通過" % len(RATIONAL_SAMPLES), flush=True)


def quadratic_positive(ab):
    a, b = ab
    return ((0 <= a and 0 <= b and (a, b) != (0, 0)) or
            (0 < a and b < 0 and 2 * b * b < a * a) or
            (a < 0 and 0 < b and a * a < 2 * b * b))


def quadratic_add(x, y):
    return (x[0] + y[0], x[1] + y[1])


def quadratic_mul(x, y):
    # (a + b s)(c + d s) = (a c + 2 b d) + (a d + b c) s  （s*s = 2）
    return (x[0] * y[0] + 2 * x[1] * y[1], x[0] * y[1] + x[1] * y[0])


def quadratic_neg(x):
    return (-x[0], -x[1])


def check_quadratic_model():
    samples = [(a, b) for a in RATIONAL_SAMPLES for b in RATIONAL_SAMPLES]
    pairs = 0
    for x, y in product(samples, repeat=2):
        if quadratic_positive(x) and quadratic_positive(y):
            assert quadratic_positive(quadratic_add(x, y))
            assert quadratic_positive(quadratic_mul(x, y))
            pairs += 1
    for z in samples:
        assert check_exactly_one([z == (0, 0), quadratic_positive(z), quadratic_positive(quadratic_neg(z))])
    print("モデル 2（F = Q_s、C = P_s）: 正の対 %d 組で和・積、標本 %d 点で三分法が通過" % (pairs, len(samples)), flush=True)


def check_negative_rationals_not_cone():
    cone = lambda a: a < 0
    witness = (QQ(-1), QQ(-2))
    assert cone(witness[0]) and cone(witness[1])
    assert not cone(witness[0] * witness[1])
    print("反例（C = 負の有理数）: (-1)*(-2) = 2 が C に入らず、積で閉じない", flush=True)


check_rational_model()
check_quadratic_model()
check_negative_rationals_not_cone()
print("def_subfield_positive_cone: 全検査通過")
