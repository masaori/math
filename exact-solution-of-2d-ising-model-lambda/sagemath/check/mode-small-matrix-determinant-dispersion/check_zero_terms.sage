# 対象ラベル: claim_mode_small_matrix_determinant_dispersion
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), "_prelude.sage"))
assert all(term(p) == 0 for p in all_perms if p not in admissible)
assert permutation_sum == admissible_sum
print("RESULT: PASS zero_terms")
