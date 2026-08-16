# 偶辺部分集合の係数写像が一次サイクルになることの検算

**対象ラベル**: `claim_even_edge_subset_maps_to_first_cycle`

## 対象

- 構造化本文: 「偶辺部分集合の係数写像は一次サイクルである」
- 検算範囲: 証明の四つの等号を一行ずつ検査する
- 帰属: 形式的有限頂点・辺・辺端ラベル集合と `GF(2)` の有限行列・有限和。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_matrix_product_definition.sage` | 一次境界行列と係数列の積が成分ごとの有限和に等しいこと | PASS | 全ての辺部分集合と頂点で一致した |
| `check_coefficient_map_reindexing.sage` | 係数写像が選択辺だけを残し、端点 incidence の有限和へ添字を付け替えられること | PASS | 全ての辺部分集合と頂点で一致した |
| `check_boundary_parity_definition.sage` | 端点 incidence の `GF(2)` 和が境界偶奇の定義に等しいこと | PASS | 全ての辺部分集合と頂点で一致した |
| `check_even_subset_zero_boundary.sage` | 偶辺部分集合では境界偶奇が全頂点で零となり、係数写像が一次境界行列の核へ入ること | PASS | 全ての偶辺部分集合で零境界を確認した |

実行日: 2026-08-16

## 実行記録

- 初回実行では `check_even_subset_zero_boundary.sage` の零ベクトル生成に誤った `vector` 呼び出しを用いたため `TypeError` となった。数学的な等式判定へ到達する前の検算コード上のエラーであり、零係数を明示した有限列へ修正した。

## 実行方法

```bash
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/even-edge-subset-maps-to-first-cycle/check_*.sage; do
  sage "$f"
done
```
