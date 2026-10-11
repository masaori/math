# 対象ラベル: claim_quadratic_addition_mem
if not globals().get('_quadratic_addition_lines_ready', False):
    load('sagemath/check/quadratic-addition/_prelude.sage')
for s, a, b, ap, bp, xi, eta in qa_cases:
    assert qa_rep(j(a + ap) + j(b + bp)*s, s) == (a + ap, b + bp)
print('PASS coefficient_witness: {} membership checks'.format(len(qa_cases)))
