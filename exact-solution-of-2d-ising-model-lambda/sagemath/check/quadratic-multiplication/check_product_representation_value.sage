# 対象ラベル: claim_quadratic_multiplication_representation
# 本文の行: 閉性の証明の鎖の始点と終点
if not globals().get('_quadratic_product_representation_ready', False):
    load('sagemath/check/quadratic-multiplication/_representation_prelude.sage')

for s, a, b, ap, bp, xi, eta, field_product, embedding, c, d in qm_representation_cases:
    lhs = xi*eta
    rhs = j(a*ap + 2*(b*bp)) + j(a*bp + b*ap)*s
    assert lhs == rhs, (s, a, b, ap, bp)
print('RESULT: PASS (閉性の証明の鎖の始点と終点: %s 等式)' % len(qm_representation_cases))
