# 固定剰余類格子の Fisher 分解体次数の素数七百九における有限体分解型による絞り込み

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_709_modular_cycle_constraint`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_709_modular_cycle_constraint`）
- 範囲: 次数四十四の既約因子の `709` 進非分岐分解型と、既存の `101`・`103`・`107`・`131`・`149`・`163`・`167`・`229`・`233`・`293`・`367`・`389` 進分解型を併用した分解体次数候補の絞り込み
- 依存: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_389_modular_cycle_constraint`、`theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_first_stronger_prime.sage` | `389` より大きい非分岐素数を昇順に調べ、`709` が次数表示 `44d` を考慮した候補を最初に真に縮めること | PASS | `709` 以前の候補は不変で、`709` では既約因子次数 `12,32`、置換位数 `96`、`d` の強制因子 `214081549063691400` を得た。 |
| `check_modular_factorization_cycle_order.sage` | `Q_Q` の先頭係数と判別式が `709` で非零であり、`GF(709)[x]` 上の既約因子次数が `12,32`、その最小公倍数が `96` であること | PASS | 先頭係数の剰余 `63`、判別式の剰余 `489`、明示した二つのモニック既約因子の積、および最小公倍数 `96` を厳密計算で確認した。 |
| `check_combined_degree_divisor_cancellation.sage` | 位数 `96` と既存の次数因子 `428163098127382800` から `214081549063691400 | d` を得て、次数を `9419588158802421600u` に書き換える有限整数計算 | PASS | 最小公倍数 `856326196254765600`、`44` との最大公約数 `4`、残余因子 `214081549063691400` と次数係数 `9419588158802421600` を確認した。 |

## 探索中の ERROR 記録

- 最初の `sage -c` 探索は、入れ子文字列の引用符が SageMath 前処理後に不正となり `SyntaxError` で停止した。
- 引用符を修正した `sage -c` 探索は、読み込んだ既約分解検算内の相対 `load` が SageMath 実行ファイル基準に解決され、`OSError` で停止した。
- 通常の SageMath ファイルとして実行する同じ探索経路へ修復した。
- 生の Galois 群位数因子だけを比較した最初の探索判定は `397` を返したが、次数表示 `44d` で因子を消去すると既存候補を縮めなかった。比較対象を `d` の強制因子へ修正した結果、最初の真の強化素数は `709` となった。

## 備考

- Dedekind の有限体分解型定理、有限置換の巡回分解による位数公式、Lagrange の定理、最小公倍数の性質、Euclid の補題は構造化本文で適用する。
- 浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-709-modular-cycle-constraint/check_*.sage; do sage "$file"; done
```
