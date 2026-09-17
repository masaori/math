load('_prelude.sage')

for coupling in positive_couplings:
    assert_strictly_positive(cosh(2 * coupling), 'c_i')

report_pass('c_i > 0', len(positive_couplings))
