# 対象ラベル: claim_quadratic_addition_mem
if not globals().get('_quadratic_addition_lines_ready', False):
    load('sagemath/check/quadratic-addition/_prelude.sage')
for s, a, b, ap, bp, xi, eta in qa_cases:
    assert (b + bp) in QQ
print('PASS second_sum_rational: {} membership checks'.format(len(qa_cases)))
