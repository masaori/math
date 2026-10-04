# 対象ラベル: claim_plane_projection_cyclic_turning
import os, sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(check_directory, '_prelude.sage'))
load(os.path.join(check_directory, 'check_direction_table.sage'))
load(os.path.join(check_directory, 'check_local_turn_table.sage'))
load(os.path.join(check_directory, 'check_cyclic_definition.sage'))
load(os.path.join(check_directory, 'check_total_definition.sage'))
load(os.path.join(check_directory, 'check_internal_substitution.sage'))
load(os.path.join(check_directory, 'check_closing_substitution.sage'))
load(os.path.join(check_directory, 'check_adjacent_definition.sage'))
load(os.path.join(check_directory, 'check_whole_word.sage'))
