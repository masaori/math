load('_prelude.sage')

assertion_count = 0
for dual_coupling in positive_couplings:
    sinh_value = sinh(2 * dual_coupling)
    cosh_value = cosh(2 * dual_coupling)
    assert_strictly_positive(sinh_value, 'sinh(2K_i*)')
    assert_strictly_positive(cosh_value - sinh_value, 'cosh(2K_i*) - sinh(2K_i*)')
    assertion_count += 2

report_pass('cosh(2K_i*) > sinh(2K_i*) > 0', assertion_count)
