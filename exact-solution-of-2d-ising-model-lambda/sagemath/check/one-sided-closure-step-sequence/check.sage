# 対象ラベル: claim_one_sided_closure_step_sequence
import os
import sys
check_directory = os.path.dirname(os.path.abspath(sys.argv[0]))
check_files = ['check_first_inside_points.sage', 'check_first_inside_step.sage', 'check_first_inside_join.sage', 'check_first_seam_points.sage', 'check_first_seam_endpoint.sage', 'check_first_seam_step.sage', 'check_first_seam_join.sage', 'check_second_inside_points.sage', 'check_second_inside_step.sage', 'check_second_inside_join.sage', 'check_second_seam_points.sage', 'check_second_seam_endpoint.sage', 'check_second_seam_step.sage', 'check_second_seam_join.sage', 'check_third_inside_points.sage', 'check_third_inside_step.sage', 'check_third_inside_join.sage', 'check_third_seam_points.sage', 'check_third_seam_endpoint.sage', 'check_third_seam_step.sage', 'check_third_seam_join.sage', 'check_fourth_points.sage', 'check_fourth_indices.sage', 'check_fourth_step.sage', 'check_fourth_join.sage']
for check_file in check_files:
    load(os.path.join(check_directory, check_file))
print('RESULT: PASS (all one-sided-closure-step-sequence line checks)')
