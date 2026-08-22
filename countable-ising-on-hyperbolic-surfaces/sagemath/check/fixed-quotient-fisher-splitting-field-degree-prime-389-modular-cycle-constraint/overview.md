# 固定剰余類格子の Fisher 分解体次数の素数三百八十九における有限体分解型による絞り込み

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_389_modular_cycle_constraint`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_389_modular_cycle_constraint`）
- 範囲: 次数四十四の既約因子の `389` 進非分岐分解型と、既存の `101`・`103`・`107`・`131`・`149`・`163`・`167`・`229`・`233`・`293`・`367` 進分解型を併用した分解体次数候補の絞り込み
- 依存: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_367_modular_cycle_constraint`、`theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_first_stronger_prime.sage` | `367` より大きい素数を昇順に調べ、`373`・`379`・`383` は候補を縮めず、`389` が最初に真に縮めること | PASS | `ZZ[x]`、各 `GF(p)[x]`、`ZZ`、`NN` による厳密探索 |
| `check_modular_factorization_cycle_order.sage` | `Q_Q` の先頭係数と判別式が `389` で非零であり、`GF(389)[x]` 上の既約因子次数が `1,43`、その最小公倍数が `43` であること | PASS | `ZZ[x]`、`GF(389)[x]`、`NN` による厳密照合 |
| `check_combined_degree_divisor_cancellation.sage` | 位数 `43` と既存の次数因子 `9957281351799600` から `107040774531845700 | d` を得て、次数を `4709794079401210800t` に書き換える有限整数計算 | PASS | `ZZ` と `NN` による厳密照合 |

## 探索中の ERROR 記録

- 最初の `sage -c` 探索は、読み込んだ既約分解検算内の相対 `load` が SageMath 実行ファイル基準に解決され、前処理の読み込み前に `OSError` となった。
- 標準入力を対話的な `sage` へ渡した二回の探索は、複合文の終端が評価されず結果を出力しなかった。
- `sage -` による標準入力実行は、SageMath の内部 `sage-site` パスが存在せず ERROR となった。
- 固定した次数四十四の既約因子を独立した SageMath ファイルへ置いた探索、および最終的な通常ファイル実行は PASS した。

## 備考

- Dedekind の有限体分解型定理、有限置換の巡回分解による位数公式、Lagrange の定理、最小公倍数の性質、Euclid の補題は構造化本文で適用する。
- 浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-389-modular-cycle-constraint/check_*.sage; do sage "$file"; done
```
