# 固定剰余類格子の Fisher 分解体次数の素数三百六十七における有限体分解型による絞り込み

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_367_modular_cycle_constraint`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_367_modular_cycle_constraint`）
- 範囲: 次数四十四の既約因子の `367` 進非分岐分解型と、既存の `101`・`103`・`107`・`131`・`149`・`163`・`167`・`229`・`233`・`293` 進分解型を併用した分解体次数候補の絞り込み
- 依存: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_293_modular_cycle_constraint`、`theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_modular_factorization_cycle_order.sage` | `Q_Q` の先頭係数と判別式が `367` で非零であり、`GF(367)[x]` 上の既約因子次数が `1,1,1,7,8,10,16`、その最小公倍数が `560` であること | PASS | `ZZ[x]`、`GF(367)[x]`、`NN` による厳密照合 |
| `check_combined_degree_divisor_cancellation.sage` | 位数 `560` と既存の次数因子 `4978640675899800` から `2489320337949900 | d` を得て、次数を `109530094869795600s` に書き換える有限整数計算 | PASS | `ZZ` と `NN` による厳密照合 |

## 探索中の ERROR 記録

- 最初の `sage -c` 探索は、複数行コードを通常の引用文字列へ `\\n` として渡したため改行へ復元されず、SageMath の前処理後に `SyntaxError` となった。
- ANSI-C 引用へ修正した二回目は、既存の既約分解検算を `sage -c` から読み込んだため、検算内の相対 `load` が SageMath 実行ファイル基準に解決され、前処理の読み込み前に `OSError` となった。
- 既約分解検算から次数四十四の既約因子の式だけを読み、SageMath 前処理を明示した三回目は PASS した。`293` より大きい非分岐素数を昇順に検査し、`307`、`311`、`313`、`317`、`331`、`337`、`347`、`349`、`353`、`359` では因子消去後の候補が縮まず、最初に候補を真に縮める素数 `367` を得た。

## 備考

- Dedekind の有限体分解型定理、有限置換の巡回分解による位数公式、Lagrange の定理、最小公倍数の性質、Euclid の補題は構造化本文で適用する。
- 浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-367-modular-cycle-constraint/check_*.sage; do sage "$file"; done
```
