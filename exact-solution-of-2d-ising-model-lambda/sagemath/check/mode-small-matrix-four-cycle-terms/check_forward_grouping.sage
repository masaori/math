# 対象ラベル: claim_mode_small_matrix_four_cycle_terms
# 本文の第一式鎖: 四つの負号と可換性による整理。
import os
import sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), '_prelude.sage'))
assert forward_substitution == forward_grouped
print('RESULT: PASS forward grouping')
