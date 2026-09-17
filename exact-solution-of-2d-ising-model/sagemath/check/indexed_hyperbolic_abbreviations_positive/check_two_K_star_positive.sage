load('_prelude.sage')

for dual_coupling in positive_couplings:
    assert_strictly_positive(2 * dual_coupling, '2K_i*')

report_pass('2K_i* > 0', len(positive_couplings))
