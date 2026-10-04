# 対象ラベル: claim_one_sided_closure_junction_pairs
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(check_directory, 'check_lift_repetition.sage'))
load(os.path.join(check_directory, 'check_upper_fixed.sage'))
load(os.path.join(check_directory, 'check_return_repetition.sage'))
load(os.path.join(check_directory, 'check_lower_fixed.sage'))
load(os.path.join(check_directory, 'check_last_expand.sage'))
load(os.path.join(check_directory, 'check_last_period_remove.sage'))
load(os.path.join(check_directory, 'check_last_residue.sage'))
load(os.path.join(check_directory, 'check_pairs_substitute.sage'))
load(os.path.join(check_directory, 'check_pairs_last.sage'))
load(os.path.join(check_directory, 'check_pairs_first.sage'))
load(os.path.join(check_directory, 'check_whole_closure.sage'))
