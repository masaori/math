# 二つの境界写像の積が零行列であることの検算

**対象ラベル**: `theorem_boundary_of_boundary_is_zero_over_f2`

## 対象

- 構造化本文: 「二つの境界写像の積は零行列である」
- 検算範囲: 証明の各等号を、反対向きの三角形二面と一頂点ループ面について一行ずつ照合する
- 帰属: 形式的な有限ラベル集合と `GF(2)` 上の有限行列。浮動小数点と非可算集合は使わない。

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_matrix_product_definition.sage` | 行列積を二つの境界写像の成分による有限和へ展開する | PASS | 三角形二面と自己ループ面の全頂点・全ての面で一致した |
| `check_finite_sum_reindexing.sage` | 有限和の分配と添字の付け替えを照合する | PASS | 二つの有限入力の全成分で一致した |
| `check_endpoint_selectors.sage` | 各向きラベルが二つの辺端を一度ずつ選ぶことを照合する | PASS | 二つの向きと全成分で一致した |
| `check_boundary_word_connection.sage` | 各境界位置の終点を後者位置の始点へ置き換える | PASS | 二つの有限入力の全成分で一致した |
| `check_successor_bijection.sage` | 後者写像による有限和の添字変更を照合する | PASS | 全ての面で後者写像が全単射であり、全成分で和が一致した |
| `check_characteristic_two_cancellation.sage` | 同じ有限和二つが `GF(2)` で相殺することを照合する | PASS | 全成分が `0` になった |

実行日: 2026-08-16

## 実行方法

```bash
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/boundary-of-boundary-is-zero-over-f2/check_*.sage; do sage "$f"; done
```
