# 商の塔に沿う二段 Fisher 零点重複度差の形式的因子の検算

**対象ラベル**: `def_quotient_tower_two_stage_fisher_zero_multiplicity_difference_formal_divisor`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_two_stage_fisher_zero_multiplicity_difference_formal_divisor`）
- 範囲: 有限台上の重複度差を整数係数とする形式和と、共有零点における係数の相殺

## チェック一覧

実行日: 2026-08-20

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_formal_divisor.sage` | `QQbar` 上の各零点をキー、重複度差を `ZZ` 係数とする有限台写像を構成し、共有零点の相殺を照合する | PASS | 互いに素な二段零点台では六項、共有零点を加えた例でも `-1` が消えて六項となり、全係数が非零整数である |

## 備考

- 四頂点サイクルと二頂点二重辺グラフの二段零点台、および両多項式へ共通因子 `2(1+x)` を掛けた共有零点例を再利用した。
- 形式的因子は `QQbar` の厳密な代数的数をキー、`ZZ` を値とする有限台写像として表現した。
- 複素平面への埋め込み、浮動小数点近似、距離、偏角、数値描画、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-fisher-zero-multiplicity-difference-formal-divisor/check_formal_divisor.sage
```
