# 固定剰余類格子の Fisher 分解体次数の素数二百三十三における有限体分解型による絞り込み

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_233_modular_cycle_constraint`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_233_modular_cycle_constraint`）
- 範囲: 次数四十四の既約因子の `233` 進非分岐分解型と、既存の `101`・`103`・`107`・`131`・`149`・`163`・`167`・`229` 進分解型を併用した分解体次数候補の絞り込み
- 依存: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_229_modular_cycle_constraint`、`theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_modular_factorization_cycle_order.sage` | `Q_Q` の先頭係数と判別式が `233` で非零であり、`GF(233)[x]` 上の既約因子次数が `1,2,3,3,4,14,17`、その最小公倍数が `1428` であること | PASS | `ZZ[x]`、`GF(233)[x]`、`NN` による厳密照合 |
| `check_combined_degree_divisor_cancellation.sage` | 位数 `1428` と既存の次数因子 `9447136007400` から `40150328031450 | d` を得て、次数を `1766614433383800n` に書き換える有限整数計算 | PASS | `ZZ` と `NN` による厳密照合 |

## 探索中の ERROR 記録

- `sage -c` から既存の既約分解検算を相対 `load` した初回は、読み込み先を SageMath 実行ファイル基準に解決して対象ファイルを見つけられず ERROR となった。
- 絶対パスの内容を Python の `exec` へ渡した二回目は、Sage 前処理前の `^` が排他的論理和として扱われ ERROR となった。
- 絶対パスと Sage の `preparse_file` を併用した三回目は、`229` より大きい非分岐素数を昇順に検査し、最初の素数 `233` で候補が真に縮小することを確認して PASS した。
- `math-prover` の汎用チェック一覧にある `structured-latex/tools/verify-no-lost-proofs.ts` を実行したが、このプロジェクトには同ファイルが存在せず `MODULE_NOT_FOUND` となった。プロジェクト固有 runbook が指定する `npm run gen`、`npm run check`、`npm run build:pdf`、SageMath 対応検査は全て PASS した。

## 備考

- Dedekind の有限体分解型定理、有限置換の巡回分解による位数公式、Lagrange の定理、最小公倍数の性質、Euclid の補題は構造化本文で適用する。
- 浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-233-modular-cycle-constraint/check_*.sage; do sage "$file"; done
```
