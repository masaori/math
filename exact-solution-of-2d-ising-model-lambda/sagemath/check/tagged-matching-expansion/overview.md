# 標識付き完全マッチング展開の SageMath 検算

**対象ラベル**: `claim_tagged_matching_expansion`

対象は変換後の端末行列の二寄与、有限積の帰納段、Pfaffian の外側の有限和である。すべて有理係数多項式上の厳密計算である。任意の有限集合についての証明は本文と Lean が担う。

| ファイル | 検証内容 | ステータス | 結果 |
|---|---|---|---|
| `check_pair_contributions.sage` | 同一対で重なる二寄与の分配 | PASS | 2026-10-25、厳密多項式等号 |
| `check_finite_product_step.sage` | 有限積へ一対を加える等号 | PASS | 2026-10-25、厳密多項式等号 |
| `check_distributive_induction.sage` | 帰納段の分配則 | PASS | 2026-10-25、厳密多項式等号 |
| `check_tagged_subset_split.sage` | 標識集合の二分 | PASS | 2026-10-25、厳密多項式等号 |
| `check_outer_sum.sage` | 符号因子の有限和への分配 | PASS | 2026-10-25、厳密多項式等号 |
