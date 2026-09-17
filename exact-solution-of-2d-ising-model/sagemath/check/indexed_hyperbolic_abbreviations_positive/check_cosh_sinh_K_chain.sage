load('_prelude.sage')

assertion_count = 0
for coupling in positive_couplings:
    sinh_value = sinh(2 * coupling)
    cosh_value = cosh(2 * coupling)
    assert_strictly_positive(sinh_value, 'sinh(2K_i)')
    assert_strictly_positive(cosh_value - sinh_value, 'cosh(2K_i) - sinh(2K_i)')
    assertion_count += 2

report_pass('cosh(2K_i) > sinh(2K_i) > 0', assertion_count)
