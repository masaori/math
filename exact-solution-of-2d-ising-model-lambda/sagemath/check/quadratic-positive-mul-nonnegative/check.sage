# 対象ラベル: claim_quadratic_positive_mul_nonnegative
from pathlib import Path
import sys
qpm_directory = Path(__file__).resolve().parent
if not (qpm_directory / '_prelude.sage').is_file():
    qpm_directory = Path(sys.argv[0]).resolve().parent
qpm_checks = ['check_representation_first.sage', 'check_representation_second.sage', 'check_nonnegative_aa.sage', 'check_nonnegative_bb.sage', 'check_nonnegative_weighted_bb.sage', 'check_nonnegative_ab.sage', 'check_nonnegative_ba.sage', 'check_nonnegative_first_sum.sage', 'check_nonnegative_first_result.sage', 'check_nonnegative_second_sum.sage', 'check_nonnegative_second_result.sage', 'check_left_positive_to_nonzero.sage', 'check_left_demorgan.sage', 'check_left_pair_nonzero.sage', 'check_left_truth.sage', 'check_right_positive_to_nonzero.sage', 'check_right_demorgan.sage', 'check_right_pair_nonzero.sage', 'check_right_truth.sage', 'check_positive_aa.sage', 'check_aa_add_zero.sage', 'check_aa_bound.sage', 'check_aa_result.sage', 'check_positive_ab.sage', 'check_ab_add_zero.sage', 'check_ab_bound.sage', 'check_ab_result.sage', 'check_positive_ba.sage', 'check_ba_zero_add.sage', 'check_ba_bound.sage', 'check_ba_result.sage', 'check_positive_bb.sage', 'check_positive_weighted_bb.sage', 'check_weighted_bb_zero_add.sage', 'check_weighted_bb_bound.sage', 'check_weighted_bb_result.sage', 'check_product_pair_coordinates.sage', 'check_product_pair_demorgan.sage', 'check_product_pair_positive.sage', 'check_product_pair_truth.sage', 'check_product_membership.sage']
assert len(qpm_checks) == 41
for qpm_filename in qpm_checks:
    load(str(qpm_directory / qpm_filename))
load(str(qpm_directory / 'check_global.sage'))
print("RESULT: PASS (41 line checks and the integrated check)")
