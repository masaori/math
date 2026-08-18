# 商の塔が誘導する第一ホモロジー押し出し写像の検算

**対象ラベル**: `def_quotient_tower_first_homology_pushforward_map_over_f2`

## 対象

- ファイル: `structured-latex/content/quotient-tower.ts`（ブロック `quotient_tower_definition_first_homology_pushforward_map_over_f2`）
- 範囲: 一次サイクル押し出し写像から、面境界による有限剰余集合上に誘導される写像の始域・終域・作用と代表元非依存性
- 併せて検証: `def_first_homology_group_over_f2`、`def_quotient_tower_first_cycle_pushforward_map_over_f2`、`theorem_quotient_tower_face_boundary_space_pushforward_over_f2`

## チェック一覧

実行日: 2026-08-18

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_representative_independence.sage` | 同じ細段第一ホモロジー類の全代表を押し出すと、一つの粗段第一ホモロジー類を与えることを照合する | PASS | 全ての細段類の全代表で像の剰余集合が一致した |
| `check_domain_codomain_and_action.sage` | 誘導写像の始域・終域と、各類を代表サイクルの押し出しの類へ送る作用を照合する | PASS | 全ての細段第一ホモロジー類が定義どおり粗段第一ホモロジー類へ移った |

## 備考

- `S_4` の Klein 四元部分群による六元商から交代群による二元商への有限データを用いる。
- 有限剰余類セル集合、`F_2` 上の係数写像、有限なサイクル空間・面境界空間・剰余集合だけを用いる。浮動小数点、実数、複素数、極限、積分を用いない。
- 誘導写像の単射性、全射性、局所全単射性、被覆次数は主張しない。
- Lean 具体版と Lean 必要十分版は未着手である。

## 実行方法

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/two-stage-quotient-tower-first-homology-pushforward-map-over-f2/check_*.sage; do
  sage "$f"
done
```
