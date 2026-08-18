# 商の塔が誘導する第一ホモロジー押し出し写像の加法性の検算

**対象ラベル**: `theorem_quotient_tower_first_homology_pushforward_additivity_over_f2`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_theorem_first_homology_pushforward_additivity_over_f2`）
- 範囲: 辺係数押し出しの加法性と、それが誘導する第一ホモロジー押し出し写像の加法性
- 併せて検証: `def_quotient_tower_edge_coefficient_pushforward_over_f2`、`def_quotient_tower_first_cycle_pushforward_map_over_f2`、`def_quotient_tower_first_homology_pushforward_map_over_f2`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_additivity.sage` | 全ての細段一次サイクル対について辺係数押し出しの成分ごとの加法性を照合し、全ての細段第一ホモロジー類対について誘導写像が商加法を保存することを照合する | PASS | 全サイクル対・全粗段辺成分と全ホモロジー類対で左右辺が一致した |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。
- 有限剰余類セル集合、`F_2` 上の係数写像、有限なサイクル空間・面境界空間・剰余集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- 単射性、全射性、局所全単射性、被覆次数は主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
sage countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-first-homology-pushforward-additivity-over-f2/check_additivity.sage
```
