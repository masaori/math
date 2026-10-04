# 対象ラベル: claim_one_sided_transverse_steps_base_independent
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(check_directory, 'check_base_expand.sage'))
load(os.path.join(check_directory, 'check_base_associate.sage'))
load(os.path.join(check_directory, 'check_base_zero.sage'))
load(os.path.join(check_directory, 'check_base_fold.sage'))
load(os.path.join(check_directory, 'check_step_substitute.sage'))
load(os.path.join(check_directory, 'check_step_cancel.sage'))
load(os.path.join(check_directory, 'check_upper_definition.sage'))
load(os.path.join(check_directory, 'check_upper_origin.sage'))
load(os.path.join(check_directory, 'check_lower_definition.sage'))
load(os.path.join(check_directory, 'check_lower_origin.sage'))
load(os.path.join(check_directory, 'check_whole_sequences.sage'))
