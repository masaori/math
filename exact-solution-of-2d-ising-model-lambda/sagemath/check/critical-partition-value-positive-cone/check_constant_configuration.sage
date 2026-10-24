# 対象ラベル: claim_critical_partition_value_mem_positive_cone
# 対象行: b(σ₊)=0
# 帰属: ZZ / QQ / QQbar（厳密計算）
import os, sys
load(os.path.join(os.path.dirname(os.path.abspath(sys.argv[0])), "_prelude.sage"))
for L, omega, terms, partials in fixtures:
    assert broken_bond_count(L, {v: 1 for v in vertices(L)}) == 0
print("RESULT: PASS (constant_configuration)")
