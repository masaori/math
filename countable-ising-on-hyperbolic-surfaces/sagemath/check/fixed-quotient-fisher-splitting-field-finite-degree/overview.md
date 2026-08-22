# 固定剰余類格子の Fisher 分解体の有限次性

**対象ラベル**: `theorem_fixed_quotient_fisher_splitting_field_finite_degree`

## 対象

- ファイル: `structured-latex/content/arithmetic-invariants.ts`（ブロック `arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_finite_degree`）
- 範囲: 四十四個の代数的 Fisher 零点が生成する分解体、その有限次性、次数上界
- 併せて検証: `theorem_fixed_quotient_partition_polynomial_irreducible_factorization`、`theorem_fixed_quotient_fisher_zero_multiplicity_data`

## チェック一覧

実行日: 2026-08-22

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_root_degrees.sage` | 四十四個の生成元が全て `QQ` 上次数 `44` の代数的数であること | PASS | 次数 `44` と `QQ[x]` 上の既約性を厳密照合 |
| `check_degree_bound.sage` | 四十四段の体の塔に対する帰納的上界が `44^44` になること | PASS | 各段の乗法的上界と最終有限自然数を照合 |
| `check_complete_linear_factorization.sage`（初回） | 四十四根に対応する一次因子を `QQbar[x]` で直接乗算し、次数 `44` の既約因子と比較すること | ERROR | 一次因子積の係数比較を exactify する段で PARI の 1 GiB スタック上限を超過 |
| `check_complete_linear_factorization.sage`（修正後） | 相異なる四十四個の厳密根が全て次数 `44` の因子を零にし、重根がないことから全一次因子を尽くすこと | PASS | 四十四根、零評価、形式微分との互いに素性を厳密照合 |
| `check_partition_root_support.sage` | 分配多項式の零点台が既約因子の四十四根と有理根 `-1` で尽くされること | PASS | 既約分解と `Q_Q(-1) != 0` を厳密照合 |

## 備考

- 全て `ZZ`、`QQ`、`QQbar` と有限集合の厳密演算で検算し、浮動小数点を用いない。
- 複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。
- 初回の直接的な一次因子積は `PariError: the PARI stack overflows` で停止した。検算を緩めず、次数、相異なる厳密根の個数、各根での零評価、形式微分との最大公約多項式を個別に照合する同値な厳密判定へ変更した。

## 実行方法

```sh
for file in countable-ising-on-hyperbolic-surfaces/sagemath/check/fixed-quotient-fisher-splitting-field-finite-degree/check_*.sage; do sage "$file"; done
```
