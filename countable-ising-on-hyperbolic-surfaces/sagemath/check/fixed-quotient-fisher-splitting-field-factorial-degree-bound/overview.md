# 固定剰余類格子の Fisher 分解体次数の階乗上界

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_factorial_degree_bound`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_factorial_degree_bound`）
- 範囲: 既知の相異なる根を順に除いた剰余因子の次数、各単拡大次数の上界、その有限積
- 依存: `theorem_fixed_quotient_fisher_splitting_field_finite_degree`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_residual_factor_degrees.sage` | 第 `r` 段までに既知の `r-1` 根を除いた因子の次数が `45-r` であること | PASS | `r=1,...,44` の各整数等式と正値性を厳密照合 |
| `check_factorial_product.sage` | 四十四段の単拡大次数上界の積が `44!` であること | PASS | 有限積と階乗を厳密照合 |
| `check_strict_improvement.sage` | 新しい上界 `44!` が既存上界 `44^44` より真に小さいこと | PASS | 正整数の厳密不等式を照合 |

## 備考

- 因数定理、最小多項式の整除性、体の塔の次数公式は構造化本文で証明し、SageMath ではそこから生じる有限整数計算を一行ずつ厳密検算する。
- `ZZ` と `NN` の厳密演算だけを用い、浮動小数点を用いない。
- 複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。
- 全体規約の拡張子 `.mjs` の検証コマンドを実行した試行は、このプロジェクトに当該ファイルが存在せず `MODULE_NOT_FOUND` で ERROR となった。正本の `CLAUDE.md` と実ファイルが指定する `.ts` の検証コマンドへ戻して実行した。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-factorial-degree-bound/check_*.sage; do sage "$file"; done
```
