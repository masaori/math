# 固定剰余類格子の Fisher 分解体次数の素数二百九十三における有限体分解型による絞り込み

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_293_modular_cycle_constraint`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_293_modular_cycle_constraint`）
- 範囲: 次数四十四の既約因子の `293` 進非分岐分解型と、既存の `101`・`103`・`107`・`131`・`149`・`163`・`167`・`229`・`233` 進分解型を併用した分解体次数候補の絞り込み
- 依存: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_233_modular_cycle_constraint`、`theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_modular_factorization_cycle_order.sage` | `Q_Q` の先頭係数と判別式が `293` で非零であり、`GF(293)[x]` 上の既約因子次数が `1,12,31`、その最小公倍数が `372` であること | PASS | `ZZ[x]`、`GF(293)[x]`、`NN` による厳密照合 |
| `check_combined_degree_divisor_cancellation.sage` | 位数 `372` と既存の次数因子 `160601312125800` から `1244660168974950 | d` を得て、次数を `54765047434897800r` に書き換える有限整数計算 | PASS | `ZZ` と `NN` による厳密照合 |

## 探索中の ERROR 記録

- `sage -c` から既存の既約分解検算を絶対パスで読み込んだ初回は、読み込まれた検算内の相対 `load` が SageMath 実行ファイル基準に解決され、前処理の読み込み前に ERROR となった。
- 一時探索スクリプトから既存の既約分解検算を読み込んだ二回目は、読み込まれた検算の `__file__` が探索スクリプトを指したため、前処理への相対パスが一階層ずれて ERROR となった。
- 固定分配多項式の前処理を探索スクリプトから直接読み込み、次数四十四の既約因子を厳密因数分解から選んだ三回目は、`233` より大きい非分岐素数を昇順に検査した。素数 `239` は分解体次数の直接整除因子を増やすが `44d` から得る `d` の因子を増やさないため採用せず、最初に次数候補を真に縮める素数 `293` を得て PASS した。

## 備考

- Dedekind の有限体分解型定理、有限置換の巡回分解による位数公式、Lagrange の定理、最小公倍数の性質、Euclid の補題は構造化本文で適用する。
- 浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-293-modular-cycle-constraint/check_*.sage; do sage "$file"; done
```
