# 固定剰余類格子の Fisher 既約因子の根式非可解性

**対象ラベル**: `theorem_fixed_quotient_fisher_irreducible_factor_not_solvable_by_radicals`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_irreducible_factor_not_solvable_by_radicals`）
- 範囲: 次数四十四の既約因子の根式可解性と分解体 Galois 群の可解性の同値、および既存の非可解性定理から得る根式非可解性
- 併せて検証: `theorem_fixed_quotient_fisher_zero_multiplicity_data`、`theorem_fixed_quotient_fisher_splitting_field_galois_group_nonsolvable`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_radical_solvability_obstruction.sage` | `Q_Q` の係数体の標数、次数、既約性、および既存同定先 `Sym(44)` の非可解性 | PASS | `char(QQ)=0`、次数四十四、既約性、`|Sym(44)|=44!`、`Sym(44)` の非可解性を確認 |

## 備考

- 標数零の多項式が根式で可解であることと、その分解体 Galois 群が可解であることの同値性は、本文で適用する Galois 理論の定理である。
- SageMath は、この同値性を適用する前提である `Q_Q\in QQ[x]`、`char(QQ)=0`、次数四十四、既約性、および既存定理で同定済みの `Sym(44)` の非可解性を厳密検算する。
- 有限置換群と厳密な係数体だけを用い、浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-irreducible-factor-not-solvable-by-radicals/check_radical_solvability_obstruction.sage
```
