# 対象ラベル: claim_quadratic_addition_representation
if not globals().get('_quadratic_addition_lines_ready', False):
    load('sagemath/check/quadratic-addition/_prelude.sage')
for s, a, b, ap, bp, xi, eta in qa_cases:
    coefficients = qa_rep(xi+eta, s)
    assert all(t in QQ for t in coefficients)
    assert xi+eta == j(coefficients[0])+j(coefficients[1])*s
print('PASS sum_representation_membership: {} membership witnesses'.format(len(qa_cases)))
