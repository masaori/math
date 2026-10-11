# 対象ラベル: claim_quadratic_addition_representation
if not globals().get('_quadratic_addition_lines_ready', False):
    load('sagemath/check/quadratic-addition/_prelude.sage')
for s, a, b, ap, bp, xi, eta in qa_cases:
    lhs = (j(a) + j(ap)) + (j(b) + j(bp))*s
    rhs = j(a + ap) + (j(b) + j(bp))*s
    assert lhs == rhs, (s, a, b, ap, bp)
print('PASS sum_representation_first_coefficient_map_add: {} exact equalities'.format(len(qa_cases)))
