# 固定剰余類格子の Fisher 分解体 Galois 群の非可解性

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_galois_group_nonsolvable`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_galois_group_nonsolvable`）
- 範囲: 四十四根上の全対称群の第一導来群が交代群であり、その後の導来列が非自明な交代群で安定すること
- 併せて検証: `theorem_fixed_quotient_fisher_splitting_field_full_symmetric_galois_group`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-23

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_derived_series.sage` | `Sym(44)` の導来列が非自明な単純群 `Alt(44)` で安定し、`Sym(44)` が可解群でないこと | PASS | 第一導来群と `Alt(44)` の相互包含、`Alt(44)` の単純性、`Sym(44)` の非可解性を確認 |

## 備考

- 全対称群同定と四十四根の濃度は構造化本文の既存定理を参照する。SageMath は四十四元有限集合上の置換群について、導来列、交代群の単純性、非可解性を厳密検算する。
- 探索時に `derived_subgroup()` を呼び出したところ、この SageMath の置換群にはそのメソッドが存在せず `AttributeError` となった。利用可能な `derived_series()` へ修正した。
- 初回実行時の `is_isomorphic()` は位数 `44!/2` を GAP の小整数範囲へ収められず失敗した。同じ四十四点上の置換部分群なので、抽象同型ではなく相互包含を検査する形へ修正した。
- 有限置換群と整数だけを用い、浮動小数点、複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-galois-group-nonsolvable/check_derived_series.sage
```
