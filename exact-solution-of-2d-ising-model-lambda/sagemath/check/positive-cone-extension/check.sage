# 対象ラベル: def_positive_cone_extension
# QQ の厳密計算だけを使う。浮動小数点を使わない。
# 延長の条件 C_E ∩ F = C_F を、F = QQ ⊆ E = Q_s（s*s = 2）の有限標本で検査する。
# E の元 a + b*s は有理数の組 (a, b) で表し、F の元 a は組 (a, 0) で表す。
#   C_F = 正の有理数の全体、
#   C_E = 二次体の正錐 P_s（def_quadratic_positive_cone）と、
#   C_E' = 共役の正錐 {(a, b) | (a, -b) ∈ P_s}（s を負とする側）。
# どちらの C_E も E の正錐の三条件を標本で満たし、C_F を延長すること、
# 一方で二つは s = (0, 1) で食い違う（延長は一つとは限らない）ことを確かめる。
# 普遍量化された条件の証明ではない。

from itertools import product

RATIONAL_SAMPLES = [QQ(0), QQ(1), QQ(-1), QQ(2), QQ(-3), QQ(1)/2, QQ(-5)/7, QQ(7)/3]


def quadratic_positive(ab):
    a, b = ab
    return ((0 <= a and 0 <= b and (a, b) != (0, 0)) or
            (0 < a and b < 0 and 2 * b * b < a * a) or
            (a < 0 and 0 < b and a * a < 2 * b * b))


def conjugate_positive(ab):
    return quadratic_positive((ab[0], -ab[1]))


def quadratic_add(x, y):
    return (x[0] + y[0], x[1] + y[1])


def quadratic_mul(x, y):
    return (x[0] * y[0] + 2 * x[1] * y[1], x[0] * y[1] + x[1] * y[0])


def check_cone(cone, name):
    samples = [(a, b) for a in RATIONAL_SAMPLES for b in RATIONAL_SAMPLES]
    for x, y in product(samples, repeat=2):
        if cone(x) and cone(y):
            assert cone(quadratic_add(x, y)) and cone(quadratic_mul(x, y))
    for z in samples:
        flags = [z == (0, 0), cone(z), cone((-z[0], -z[1]))]
        assert sum(1 for f in flags if f) == 1
    print("%s: 標本 %d 点で E の正錐の三条件が通過" % (name, len(samples)), flush=True)


def check_extends(cone, name):
    for a in RATIONAL_SAMPLES:
        # (a, 0) ∈ C_E ∩ F  ⇔  a ∈ C_F
        assert cone((a, QQ(0))) == (a > 0)
    print("%s: F の標本 %d 点で C_E ∩ F = C_F が通過" % (name, len(RATIONAL_SAMPLES)), flush=True)


check_cone(quadratic_positive, "C_E = P_s")
check_cone(conjugate_positive, "C_E' = 共役の正錐")
check_extends(quadratic_positive, "C_E = P_s")
check_extends(conjugate_positive, "C_E' = 共役の正錐")
s = (QQ(0), QQ(1))
assert quadratic_positive(s) and not conjugate_positive(s)
print("s = (0, 1) は P_s に入り共役の正錐に入らない: 延長は一つとは限らない", flush=True)
print("def_positive_cone_extension: 全検査通過")
