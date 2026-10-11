# 対象ラベル: claim_quadratic_addition_mem
if not globals().get('_quadratic_addition_lines_ready', False):
    load('sagemath/check/quadratic-addition/_prelude.sage')
for s, a, b, ap, bp, xi, eta in qa_cases:
    lhs = j(a) + (j(b)*s + (j(ap) + j(bp)*s))
    rhs = j(a) + ((j(b)*s + j(ap)) + j(bp)*s)
    assert lhs == rhs, (s, a, b, ap, bp)
print('PASS inner_association_left: {} exact equalities'.format(len(qa_cases)))
