# ブロック対角行列の行列式と小行列式の積

**対象ラベル**: `claim_block_diagonal_determinant_product`

添字集合の大きさ 0〜4 と三つのファイバーへの全写像について、本文の四つの等号を有理係数多項式で一行ずつ検算する。一般の有限集合についての証明は本文と Lean に置く。

| ファイル | 対象の等号 | 実行状態 |
|---|---|---|
| `check_reindex.sage` | 行列式から置換の組の和 | PASS（2026-10-27、121例） |
| `check_terms.sage` | 置換項のファイバー別分解 | PASS（2026-10-27、121例） |
| `check_distributivity.sage` | 有限和の積の分配 | PASS（2026-10-27、121例） |
| `check_fiber_determinants.sage` | 各ファイバーの行列式 | PASS（2026-10-27、121例） |
