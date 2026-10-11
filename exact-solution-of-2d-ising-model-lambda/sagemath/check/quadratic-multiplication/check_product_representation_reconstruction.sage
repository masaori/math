# 対象ラベル: claim_quadratic_multiplication_representation
# 本文の行: 表示写像から積の値を復元する等号
if not globals().get('_quadratic_product_representation_ready', False):
    load('sagemath/check/quadratic-multiplication/_representation_prelude.sage')

for s, a, b, ap, bp, xi, eta, field_product, embedding, c, d in qm_representation_cases:
    lhs = j(c) + j(d)*s
    rhs = xi*eta
    assert lhs == rhs, (s, a, b, ap, bp, c, d)
print('RESULT: PASS (表示写像から積の値を復元する等号: %s 等式)' % len(qm_representation_cases))
