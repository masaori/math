load('_prelude.sage')

assertion_count = 0
for coupling in positive_couplings:
    c_i = cosh(2 * coupling)
    s_i = sinh(2 * coupling)
    assert_strictly_positive(s_i, 's_i')
    assert_strictly_positive(c_i - s_i, 'c_i - s_i')
    assertion_count += 2

report_pass('c_i > s_i > 0 after abbreviation substitution', assertion_count)
