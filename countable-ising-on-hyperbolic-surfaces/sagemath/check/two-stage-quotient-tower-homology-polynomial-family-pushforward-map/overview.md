# 商の塔に沿うホモロジー類別多項式族の押し出し写像の検算

**対象ラベル**: `def_quotient_tower_homology_polynomial_family_pushforward_map`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_homology_polynomial_family_pushforward_map`）
- 範囲: 細段第一ホモロジー類で添字付けた任意の整数係数多項式族を、第一ホモロジー押し出し写像の有限ファイバーごとに加える写像
- 併せて検証: `def_quotient_tower_first_homology_pushforward_map_over_f2`

## チェック一覧

実行日: 2026-08-19

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_finite_fiber_sum.sage` | 独立不定元で表した任意の細段多項式族について、全粗段成分が対応ファイバーの厳密な有限和であり、全ファイバーが細段類を重複なく分割することを照合する | PASS | 細段類 `1` 個、粗段成分 `1` 個について一致 |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。
- 有限第一ホモロジー群と `ZZ[u,v]` 上の有限和だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- この定義は、特定のセル分割から得た高温生成多項式族同士の等式を主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-homology-polynomial-family-pushforward-map/check_finite_fiber_sum.sage
```
