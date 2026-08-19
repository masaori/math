# 商の塔に沿う二段 Fisher 零点重複度差の有限台の検算

**対象ラベル**: `theorem_quotient_tower_two_stage_fisher_zero_multiplicity_difference_finite_support`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_two_stage_fisher_zero_multiplicity_difference_finite_support`）
- 範囲: 二段 Fisher 零点重複度差が非零となる零点の集合と、二段零点台への包含および有限性

## チェック一覧

実行日: 2026-08-20

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_finite_support.sage`（初回） | 二つの零点台の対称差を集合演算子 `^` で照合する | ERROR | SageMath の前処理が `^` を冪演算 `**` へ変換し、集合には適用できず `TypeError` となった |
| `check_finite_support.sage` | `QQbar` 上で重複度差が非零となる零点を抽出し、二段零点台の有限部分集合であることを照合する | PASS | 互いに素な二段零点台では六元全てが台に属し、共有零点を加えた七元零点台では差が零となる `-1` を除く六元が台に属する |

## 備考

- 四頂点サイクルと二頂点二重辺グラフの二段零点台、および両多項式へ共通因子 `2(1+x)` を掛けた共有零点例を再利用した。
- 初回の集合演算子による型エラーは、集合の `symmetric_difference` メソッドへ置き換えて修正した。
- 根は `QQbar` の厳密な代数的数として構成し、浮動小数点近似へ変換しない。
- 複素平面への埋め込み、距離、偏角、数値描画、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-fisher-zero-multiplicity-difference-finite-support/check_finite_support.sage
```
