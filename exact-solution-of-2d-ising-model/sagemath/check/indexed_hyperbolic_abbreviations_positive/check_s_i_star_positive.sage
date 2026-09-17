load('_prelude.sage')

for dual_coupling in positive_couplings:
    assert_strictly_positive(sinh(2 * dual_coupling), 's_i*')

report_pass('s_i* > 0', len(positive_couplings))
