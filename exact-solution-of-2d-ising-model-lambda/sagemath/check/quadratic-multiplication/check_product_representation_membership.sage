# 対象ラベル: claim_quadratic_multiplication_representation
# 本文の行: 積が二次体に属すること
if not globals().get('_quadratic_product_representation_ready', False):
    load('sagemath/check/quadratic-multiplication/_representation_prelude.sage')

for s, a, b, ap, bp, xi, eta, field_product, embedding, c, d in qm_representation_cases:
    assert field_product in qm_field
    assert c in QQ and d in QQ
    assert embedding(field_product) == xi*eta, (s, a, b, ap, bp)
print('RESULT: PASS (積が二次体に属すること: %s 所属)' % len(qm_representation_cases))
