load('_prelude.sage')

for coupling in positive_couplings:
    assert_strictly_positive(sinh(2 * coupling), 's_i')

report_pass('s_i > 0', len(positive_couplings))
