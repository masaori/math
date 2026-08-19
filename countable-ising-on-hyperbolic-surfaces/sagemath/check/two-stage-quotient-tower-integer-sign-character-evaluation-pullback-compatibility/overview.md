# 商の塔における整数符号文字評価と引き戻しの整合性の検算

**対象ラベル**: `theorem_quotient_tower_integer_sign_character_evaluation_pullback_compatibility`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_integer_sign_character_evaluation_pullback_compatibility`）
- 範囲: 粗段文字を第一ホモロジー押し出し像で整数符号評価する経路と、文字を引き戻して細段類で整数符号評価する経路の一致
- 併せて検証: `def_quotient_tower_f2_character_pullback_map`、`def_integer_sign_character_realization`

## チェック一覧

実行日: 2026-08-19

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_compatibility.sage` | 全粗段文字と全細段第一ホモロジー類について、押し出し後の文字値、引き戻し後の文字値、両者の整数符号実現を順に照合する | PASS | 二つの評価経路が全て一致した |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。
- 有限第一ホモロジー群、有限文字空間、`F_2`、`Z` 上の有限演算だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-integer-sign-character-evaluation-pullback-compatibility/check_compatibility.sage
```
