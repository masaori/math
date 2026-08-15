# SageMath 検算: 依存順序から得る部分構造

## 対象

**対象ラベル**: `claim_down_set_order_convex`

- 併せて検証: `claim_up_set_order_convex`、`claim_order_convex_intersection`、`claim_antichain_order_convex`、`claim_time_slice_antichain`、`claim_down_set_no_incoming_edge`、`claim_down_set_boundary_outgoing`
- 検証範囲: 下方集合・上方集合・順序凸部分集合・非比較関係・反鎖・時刻切片・一段境界の定義と、構造化記述にある七つの claim
- 全数範囲: $|V|\leq2$、$0\leq\tau\leq2$ の隣接時刻間の全ての関係と、各イベント集合の全ての部分集合

## チェック一覧

| ファイル | 検証内容 | ステータス | 結果 |
| --- | --- | --- | --- |
| `check_down_and_up_sets_are_order_convex.sage` | 下方集合と上方集合が順序凸 | PASS | 283 関係の下方集合 5,993 個・上方集合 5,993 個で成立 |
| `check_order_convex_intersection.sage` | 順序凸部分集合の共通部分が順序凸 | PASS | 283 関係の順序凸集合対 732,529 組で成立 |
| `check_antichain_order_convex.sage` | 反鎖が順序凸 | PASS | 283 関係の反鎖 5,993 個で成立 |
| `check_time_slice_antichain.sage` | 各時刻切片が反鎖 | PASS | 824 切片の相異なるイベント対 1,602 組で成立 |
| `check_down_set_no_incoming_edge.sage` | 下方集合へ外から入る一段依存がない | PASS | 5,993 下方集合で成立 |
| `check_down_set_boundary_outgoing.sage` | 下方集合の一段境界が外向き依存だけで定まる | PASS | 5,993 下方集合の境界元 5,871 個で成立 |

## 限界と帰属

- 全数検査は上記の有限範囲に限られ、一般の有限舞台・任意の $\tau\in\mathbb{N}$ に対する証明ではない。一般の場合の根拠は構造化記述の人手証明である。
- 検査対象を CA から得る関係より広い「隣接時刻間の任意の関係」とした。局所規則の内容は仮定せず、一段依存で時刻が一つ増える性質だけを使う。
- 全て有限集合、有限関係、非負整数の等号・大小比較として厳密に検査する。浮動小数点と $\mathbb{R}/\mathbb{C}$ 脱出はない。

## 実行方法

```bash
for file in sagemath/check/dependency-order-substructures/check_*.sage; do sage "$file"; done
```
