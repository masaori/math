# 対象ラベル: def_subfield_precone
# QQ の厳密計算だけを使う。浮動小数点を使わない。
# 前錐の四条件（和・積で閉じる、E の元の平方を含む、C_F を含む）を、二つのモデルの有限標本で検査する。
#   モデル 1: F = E = QQ、C_F = 正の有理数、T = 非負の有理数。
#   モデル 2: F = QQ ⊆ E = Q_s（s*s = 2）、C_F = 正の有理数、T = P_s ∪ {0}
#             （元 a + b*s を組 (a, b) で表す。P_s は def_quadratic_positive_cone の三つの有理条件）。
# 反例として、F = E = QQ で T = 正の有理数が平方の条件を満たさない（0*0 = 0 が T に入らない）ことも確かめる。
# 普遍量化された条件の証明ではない。

from itertools import product

RATIONAL_SAMPLES = [QQ(0), QQ(1), QQ(-1), QQ(2), QQ(-3), QQ(1)/2, QQ(-5)/7, QQ(7)/3]


def quadratic_positive(ab):
    a, b = ab
    return ((0 <= a and 0 <= b and (a, b) != (0, 0)) or
            (0 < a and b < 0 and 2 * b * b < a * a) or
            (a < 0 and 0 < b and a * a < 2 * b * b))


def quadratic_add(x, y):
    return (x[0] + y[0], x[1] + y[1])


def quadratic_mul(x, y):
    return (x[0] * y[0] + 2 * x[1] * y[1], x[0] * y[1] + x[1] * y[0])


def check_rational_model():
    T = lambda z: z >= 0
    for a, b in product(RATIONAL_SAMPLES, repeat=2):
        if T(a) and T(b):
            assert T(a + b) and T(a * b)
    for y in RATIONAL_SAMPLES:
        assert T(y * y)
        if y > 0:
            assert T(y)
    print("モデル 1（E = QQ、T = 非負の有理数）: 標本 %d 点で四条件が通過" % len(RATIONAL_SAMPLES), flush=True)


def check_quadratic_model():
    T = lambda z: z == (0, 0) or quadratic_positive(z)
    samples = [(a, b) for a in RATIONAL_SAMPLES for b in RATIONAL_SAMPLES]
    pairs = 0
    for x, y in product(samples, repeat=2):
        if T(x) and T(y):
            assert T(quadratic_add(x, y)) and T(quadratic_mul(x, y))
            pairs += 1
    for y in samples:
        assert T(quadratic_mul(y, y))
    for c in RATIONAL_SAMPLES:
        if c > 0:
            assert T((c, QQ(0)))
    print("モデル 2（E = Q_s、T = P_s ∪ {0}）: 対 %d 組で和・積、標本 %d 点で平方、C_F の標本で包含が通過" % (pairs, len(samples)), flush=True)


def check_positive_rationals_not_precone():
    T = lambda z: z > 0
    assert not T(QQ(0) * QQ(0))
    print("反例（T = 正の有理数）: 0*0 = 0 が T に入らず、平方の条件を満たさない", flush=True)


check_rational_model()
check_quadratic_model()
check_positive_rationals_not_precone()
print("def_subfield_precone: 全検査通過")
