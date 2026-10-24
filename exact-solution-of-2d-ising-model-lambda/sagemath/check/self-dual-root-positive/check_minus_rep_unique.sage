# 対象ラベル: claim_self_dual_root_minus_representation
# 本文の行: 表示一意性による係数対の一致
# 帰属: QQ と QQbar。係数は埋込み付き数体への逆変換から得る。
from pathlib import Path
load(str(Path(__file__).resolve().parent / "_plus_mem_prelude.sage"))
checked = 0
for s in plus_mem_roots:
    value = -one_k-s
    a, b = reconstruct_in_quadratic_field(value, s)
    assert (a,b) == (-one_q,-one_q), s
    checked += 1
assert checked == 2
print('RESULT: PASS (表示一意性による係数対の一致: 2 件)')
