# 対象ラベル: claim_one_step_dependency_finite_decidability
# supp(f_v) の一点反転走査が定義どおりの依存台を返し、比較回数が
# |N(v)|*2^|N(v)| 以下であることを、|N(v)|<=3 の全真理値表で検査する。
# 帰属: 非負整数、有限集合、0/1 の等号だけを使う。R/C 脱出なし。

import os

_dir = os.path.dirname(os.path.abspath(__file__))
load(os.path.join(_dir, "_prelude.sage"))

tested = 0
for neighborhood_size in range(4):
    local_inputs = configurations(neighborhood_size)
    for outputs in product((0, 1), repeat=len(local_inputs)):
        local_table = dict(zip(local_inputs, outputs))
        scanned_support, comparisons = scan_support_by_flips(local_table, local_inputs)
        assert scanned_support == support(local_table, local_inputs)
        assert comparisons <= neighborhood_size * 2**neighborhood_size
        tested += 1

print("support scans and bounds checked: {}".format(tested))
print("RESULT: PASS")
