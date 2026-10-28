import os
import sys
directory = os.path.dirname(os.path.abspath(sys.argv[0]))
for name in ('check_kw_square.sage', 'check_kw_square_simplification.sage', 'check_kw_cubic.sage', 'check_kw_cubic_simplification.sage', 'check_dispersion_definition.sage', 'check_substitution.sage', 'check_cancel_denominator.sage', 'check_difference_of_squares.sage', 'check_dispersion_return.sage'):
    load(os.path.join(directory, name))
print('RESULT: PASS dispersion KW duality')
