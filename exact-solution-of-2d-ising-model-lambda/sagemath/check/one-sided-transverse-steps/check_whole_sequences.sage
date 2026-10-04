# 単位歩を積み上げた独立の列との全列照合。
# 対象ラベル: claim_one_sided_transverse_steps_base_independent
import os
import sys
if 'transverse_geometries' not in globals():
    load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), 'construction.sage'))
count = 0
for g in transverse_geometries:
    wh, wv, n, t, Q, d, C, origin = g
    b = t*n
    for reverse in (False, True):
        index = list(range(b, -1, -1)) if reverse else list(range(b+1))
        actual = [staircase(g,Q,index[i+1])-staircase(g,Q,index[i]) for i in range(b)]
        expected = [origin[index[i+1]]-origin[index[i]] for i in range(b)]
        assert actual == expected
        count += 1
print('check_whole_sequences: PASS (' + str(count) + ' sequences)')
