# 対象ラベル: claim_mode_small_matrix_determinant_dispersion
import os
import sys
directory = os.path.dirname(os.path.abspath(sys.argv[0]))
load(os.path.join(directory, "check_permutation_expansion.sage"))
load(os.path.join(directory, "check_zero_terms.sage"))
load(os.path.join(directory, "check_admissible_list.sage"))
load(os.path.join(directory, "check_permutation_signs.sage"))
load(os.path.join(directory, "check_remaining_products.sage"))
load(os.path.join(directory, "check_four_cycles.sage"))
load(os.path.join(directory, "check_algebra.sage"))
print("RESULT: PASS determinant dispersion")
