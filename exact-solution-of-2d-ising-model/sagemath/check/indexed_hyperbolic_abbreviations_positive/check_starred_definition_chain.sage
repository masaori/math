load('_prelude.sage')

assertion_count = 0
for dual_coupling in positive_couplings:
    c_i_star = cosh(2 * dual_coupling)
    s_i_star = sinh(2 * dual_coupling)
    assert_strictly_positive(s_i_star, 's_i*')
    assert_strictly_positive(c_i_star - s_i_star, 'c_i* - s_i*')
    assertion_count += 2

report_pass('c_i* > s_i* > 0 after abbreviation substitution', assertion_count)
