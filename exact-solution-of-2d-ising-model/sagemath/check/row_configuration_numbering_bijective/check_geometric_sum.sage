# ---------------------------------------------------------
# SageMath: 証明の準備 Σ_{t=0}^{n-1} 2^t = 2^n - 1 と、その帰納法の各段
# 対象ラベル: row_configuration_numbering_bijective
# 対象: structured-latex/content/001_partition_function_2d_ising.ts
#       ブロック partition_function_2d_ising_claim_row_configuration_numbering_bijective の「準備」
# 帰属: n ∈ Z_{≥0}、各項は ZZ。厳密計算。
# ---------------------------------------------------------
import os
_dir = os.path.dirname(os.path.abspath(__file__)) if "__file__" in dir() else "."
load(os.path.join(_dir, "../../_shared/row_configurations.sage"))

ok_all = True
for n in range(0, 41):
    lhs = sum(ZZ(2) ** t for t in range(0, n))          # 空和は 0
    ok = (lhs == ZZ(2) ** n - 1)
    # 帰納法の段: Σ_{t=0}^{n} 2^t = Σ_{t=0}^{n-1} 2^t + 2^n = (2^n-1)+2^n = 2·2^n-1 = 2^{n+1}-1
    s_next = sum(ZZ(2) ** t for t in range(0, n + 1))
    steps = [s_next,
             lhs + ZZ(2) ** n,
             (ZZ(2) ** n - 1) + ZZ(2) ** n,
             2 * ZZ(2) ** n - 1,
             ZZ(2) ** (n + 1) - 1]
    ok = ok and all(x == steps[0] for x in steps)
    if not ok:
        print(f"  n={n}: FAIL {steps}")
    ok_all = ok_all and ok
print("  n = 0..40 で等比和と帰納法の 4 段がすべて ZZ で一致")
exact_result(ok_all)
