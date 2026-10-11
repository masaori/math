# 対象ラベル: claim_quadratic_addition_representation
if not globals().get('_quadratic_addition_lines_ready', False):
    load('sagemath/check/quadratic-addition/_prelude.sage')
for s, a, b, ap, bp, xi, eta in qa_cases:
    lhs = qa_rep(xi+eta, s)
    rhs = (a+ap, b+bp)
    assert lhs == rhs, (s, a, b, ap, bp)
print('PASS sum_representation_unique: {} exact equalities'.format(len(qa_cases)))
