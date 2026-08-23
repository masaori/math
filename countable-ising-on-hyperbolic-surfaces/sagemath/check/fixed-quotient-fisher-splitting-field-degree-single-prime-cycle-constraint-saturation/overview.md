# 固定剰余類格子の Fisher 分解体次数に対する単一有限体分解型制約の飽和

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_degree_single_prime_cycle_constraint_saturation`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_single_prime_cycle_constraint_saturation`）
- 範囲: 次数四十四の既約因子に対する任意の非分岐素数の有限体分解型から、一つの置換位数だけを追加する経路の飽和
- 依存: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_709_modular_cycle_constraint`、`theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_degree_divisor_saturation.sage` | 既存次数因子 `D`、一から四十四までの最小公倍数 `L`、次数表示 `44d` の最大公約数による因子消去 | PASS | `L=11D` であり、`D` と `11D` のどちらからも `214081549063691400 | d` だけが得られることを確認した。 |
| `check_all_cycle_types.sage` | 四十四の全整数分割が表す全巡回型について、置換位数を既存次数因子へ追加した後の `d` の強制因子 | PASS | 全 `75175` 巡回型、相異なる `678` 位数の全てで強制因子が `214081549063691400` のまま変わらないことを確認した。 |

## 探索中の ERROR 記録

- 最初の `sage -c` 探索は、読み込んだ既約分解検算内の相対 `load` が SageMath 実行ファイル基準に解決され、`OSError` で停止した。
- `/tmp` に置いた通常の SageMath ファイルによる探索も、同じ相対 `load` が `/tmp` 基準に解決され、`OSError` で停止した。
- 既存検算と同じディレクトリに探索ファイルを置く経路へ修復した。素数十万未満では候補を強めるものを返さなかったが、有限探索は証明に用いず、全巡回型の有限検算と一般の最小公倍数による証明へ置き換えた。

## 備考

- Dedekind の有限体分解型定理は、非分岐素数の分解型から四十四根上の一つの置換を得るためだけに使う。
- 結論は単一素数から得る置換位数制約の飽和であり、複数の共役類を組み合わせた群構造の同定が不可能だとは主張しない。
- 浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-degree-single-prime-cycle-constraint-saturation/check_*.sage; do sage "$file"; done
```
