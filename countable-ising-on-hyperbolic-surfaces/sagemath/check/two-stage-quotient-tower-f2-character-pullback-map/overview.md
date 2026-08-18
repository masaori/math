# 商の塔が誘導する F_2 値文字の引き戻し写像の検算

**対象ラベル**: `def_quotient_tower_f2_character_pullback_map`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_f2_character_pullback_map`）
- 範囲: 粗段第一ホモロジー群の `F_2` 値文字と第一ホモロジー押し出し写像の合成、および合成が細段の線形文字になること
- 併せて検証: `def_f2_linear_character_space`、`def_quotient_tower_first_homology_pushforward_map_over_f2`、`theorem_quotient_tower_first_homology_pushforward_additivity_over_f2`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_definition_and_linearity.sage` | 全粗段文字と全細段第一ホモロジー類について合成写像の作用を照合し、全スカラー・全類対について引き戻した写像の `F_2` 線形性を照合する | PASS | 全ての引き戻しが細段文字空間に属し、作用と線形性が一致した |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。
- 有限第一ホモロジー群、有限文字空間、`F_2` 上の有限演算だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- 引き戻し写像の単射性と全射性は主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-f2-character-pullback-map/check_definition_and_linearity.sage
```
