# 商の塔が誘導する一次サイクル押し出し写像の検算

**対象ラベル**: `def_quotient_tower_first_cycle_pushforward_map_over_f2`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_first_cycle_pushforward_map_over_f2`）
- 範囲: 辺係数押し出しを細段一次サイクル空間へ制限し、粗段一次サイクル空間を終域とする写像の始域・終域・作用
- 併せて検証: `def_first_cycle_space_over_f2`、`def_quotient_tower_edge_coefficient_pushforward_over_f2`、`theorem_quotient_tower_first_cycle_pushforward_over_f2`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_restricted_map_definition.sage` | 全ての細段一次サイクルについて、制限写像の値が粗段一次サイクル空間に属し、辺係数押し出しの値と一致することを照合する | PASS | 全ての細段一次サイクルで始域・終域・作用が定義どおりに一致した |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。
- 有限剰余類辺セル集合と `F_2` 上の厳密有限写像だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- 第一ホモロジーへの作用、局所全単射性、被覆次数は主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-first-cycle-pushforward-map-over-f2/check_restricted_map_definition.sage
```
