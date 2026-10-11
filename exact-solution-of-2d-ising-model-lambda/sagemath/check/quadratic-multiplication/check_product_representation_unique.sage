# 対象ラベル: claim_quadratic_multiplication_representation
# 本文の行: 表示一意性による係数対の一致
if not globals().get('_quadratic_product_representation_ready', False):
    load('sagemath/check/quadratic-multiplication/_representation_prelude.sage')

for s, a, b, ap, bp, xi, eta, field_product, embedding, c, d in qm_representation_cases:
    lhs = (c, d)
    rhs = (a*ap + 2*(b*bp), a*bp + b*ap)
    assert lhs == rhs, (s, a, b, ap, bp, c, d)
print('RESULT: PASS (表示一意性による係数対の一致: %s 等式)' % len(qm_representation_cases))
