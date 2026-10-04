# 対象ラベル: claim_one_sided_closure_cyclic_sum
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(check_directory, '_prelude.sage'))
for name in (
        'lift_repetition', 'upper_fixed', 'return_repetition', 'lower_fixed',
        'selected_index_bounds', 'step_four_parts', 'substitute_lift',
        'substitute_upper', 'substitute_return', 'substitute_lower',
        'cyclic_definition', 'internal_substitution', 'closing_substitution',
        'cyclic_fold', 'independent_points'):
    load(os.path.join(check_directory, 'check_' + name + '.sage'))
