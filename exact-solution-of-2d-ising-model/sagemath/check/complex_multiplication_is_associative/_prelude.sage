# 対象ラベル: complex_multiplication_is_associative
# definition_of_cc の積を、成分の組 (a, b) どうしの式としてそのまま組む。
def cc_mul(z, w):
    (a, b), (c, d) = z, w
    return (a * c - b * d, a * d + b * c)
