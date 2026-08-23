# 固定剰余類格子の Fisher 分解体 Galois 群の全対称群同定

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_full_symmetric_galois_group`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_full_symmetric_galois_group`）
- 範囲: `389` 進分解型による原始性、`131` 進分解型による素数四十一巡回、`107` 進分解型による奇置換の有限置換前提
- 併せて検証: `theorem_fixed_quotient_fisher_splitting_field_degree_prime_389_modular_cycle_constraint`、`theorem_fixed_quotient_fisher_splitting_field_degree_prime_131_modular_cycle_constraint`、`theorem_fixed_quotient_fisher_splitting_field_degree_modular_cycle_constraint`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_long_cycle_primitivity_premises.sage` | 巡回長 `1,43` の置換が一根を固定し、残り四十三根上で推移的に作用すること | PASS | 一根の固定、残り四十三根の軌道一致を確認 |
| `check_prime_cycle_jordan_premises.sage` | 巡回長 `1,2,41` の置換の二乗が三不動点をもつ素数四十一巡回であり、`41 <= 44-3` を満たすこと | PASS | 二乗の巡回型、四十一の素数性、Jordan の不等式条件を確認 |
| `check_odd_cycle_type.sage` | 巡回長 `1,2,5,13,23` の置換の符号が `(-1)^39=-1` であること | PASS | 符号が負で交代群に属さないことを確認 |

## 備考

- Jordan の素数巡回定理と、既約多項式の Galois 群が根上で推移的に作用することは証明本文の群論的入力である。SageMath は、それらへ適用する巡回型、素数条件、符号を有限集合上で厳密検算する。
- `ZZ`、`NN`、有限置換群だけを用い、浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-full-symmetric-galois-group/check_*.sage; do sage "$file"; done
```
