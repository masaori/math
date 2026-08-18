# SageMath 検算: 安定ファイバー上の一周期写像が定める根付き木

## 対象

**対象ラベル**: `claim_iterate_monoid_one_period_map_preserves_fiber`

- 併せて検証するラベル: `claim_iterate_monoid_period_multiple_propagates`、`claim_iterate_monoid_one_period_map_reaches_root`、`claim_iterate_monoid_one_period_map_unique_fixed_point`、`claim_iterate_monoid_fiber_tree_edge_count`、`claim_iterate_monoid_fiber_tree_depth_decrement`、`claim_iterate_monoid_fiber_tree_no_cycle`、`claim_iterate_monoid_fiber_tree_finite_decidability`
- 全数範囲: セル数 0 の唯一の大域写像、および `1 <= |V| <= 3` の巡回舞台上の全 256 初等 CA 規則（計 769 個の大域写像）

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_one_period_table.sage` | 周期倍数の伝播と一周期写像の逐次合成 | PASS | 769 写像・周期伝播 29,444 組・逐次合成 4,984 段で成立 |
| `check_fiber_preservation.sage` | 一周期写像による全安定ファイバーの保存 | PASS | 769 写像・ファイバー元 3,585 個で成立 |
| `check_root_reachability.sage` | 根到達指数回で全ファイバー元が根へ到達 | PASS | 769 写像・ファイバー元 3,585 個で成立 |
| `check_unique_fixed_point.sage` | 根の不動性とファイバー内不動点の一意性 | PASS | 769 写像・安定ファイバー 2,201 個で成立 |
| `check_edge_count.sage` | 非根から辺への全単射と辺数 | PASS | 769 写像・安定ファイバー 2,201 個・辺 1,384 本で成立 |
| `check_depth_and_acyclicity.sage` | 深さ零、辺での一段減少、有向閉路不存在 | PASS | 769 写像・頂点 3,585 個・辺 1,384 本で成立 |
| `check_finite_decidability.sage` | 一周期写像表・辺・深さ・分岐数の有限走査 | PASS | 一周期写像表の $F$ 適用 7,897 回・深さ等号検査 5,249 回・分岐用辺比較 5,728 回で定義値と一致 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、任意の有限舞台・任意の大域写像に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- `|V|=1,2,3` では巡回舞台上の半径 1 の一様な初等 CA の全 256 真理値表を検査する。任意の非一様 CA の全数列挙とは主張しない。
- 全て有限集合上の写像表、有限集合の等号・所属・個数、非負整数の除法・大小比較として厳密に検査する。浮動小数点と `R/C` 脱出はない。
- `check_one_period_table.sage` の初回実行では、検査する最大指数より短い反復表を参照して `IndexError` になった。必要な最大指数を式から決定して反復表を生成するよう修正し、検査範囲や等号条件は変更せず再実行して PASS した。

## 実行方法

```bash
for file in sagemath/check/iterate-monoid-stable-fiber-rooted-tree/check_*.sage; do sage "$file"; done
```
