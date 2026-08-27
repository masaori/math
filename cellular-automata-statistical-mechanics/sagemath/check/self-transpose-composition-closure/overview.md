# SageMath 検算: 自己転置な近傍割り当ての合成閉性

## 対象

**対象ラベル**: `claim_self_transpose_neighborhood_assignments_not_composition_closed`

- 併せて検証するラベル:
  `claim_self_transpose_composition_iff_commute`、
  `def_self_transpose_composition_nonclosure_witness`、
  `claim_self_transpose_composition_loop_witness_is_self_transpose`、
  `claim_self_transpose_composition_edge_witness_is_self_transpose`、
  `claim_self_transpose_composition_closure_finitely_decidable`
- 本文の各段（合成の自己転置性と可換性の同値、二つの証人の自己転置性、二元舞台での明示反例の
  式変形、有限決定の手続き）を別々の検算に分け、最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_composition_self_transpose_iff_commute.sage` | 自己転置な `N, M` について `(N star M)^T = N star M ⟺ N star M = M star N`。転置が合成順序を反転する段、自己転置性 `N^T = N`・`M^T = M` を代入する段、等号の対称性の段を分けて検査 | PASS |
| `check_two_cell_witnesses_self_transpose.sage` | 二元舞台の証人 `N(a) = {a}, N(b) = ∅` と `M(a) = {b}, M(b) = {a}` が自己転置であること。有限表から所属条件（`w ∈ N(v) ⟺ v = w = a`、`w ∈ M(v) ⟺ {v,w} = {a,b}`）を出す段と、その条件が `v, w` について対称であることから転置表の一致を出す段を分けて検査 | PASS |
| `check_two_cell_nonclosure.sage` | `(N star M)(a) = M(a) = {b}` と `(M star N)(a) = N(b) = ∅` の各等号を合成近傍の定義から段ごとに検査し、`b ∈ {b}`・`b ∉ ∅` から `N star M ≠ M star N` を出し、同値により `N star M` が自己転置でないことを結論する。転置表の直接計算による独立確認も行う | PASS |
| `check_finite_decision.sage` | 自己転置な割り当ての有限列挙（個数 `2^{n(n+1)/2}`、全体は `2^{n^2}`）、各順序対の合成表を定義の合併で計算する段（各セルで高々 `n` 項）、`n` 個の値の比較による自己転置性の判定を分けて検査 | PASS |

## 検証範囲

- 走査は `|V| = 0, 1, 2, 3` の全数検査である。自己転置な近傍割り当てはそれぞれ 1、2、8、64 個で、
  その順序対 4,165 組を尽くしている。
- `|V| >= 4` は走査していない。したがってこれらは有限範囲の全数検査であって、
  任意の有限舞台に対する一般証明ではない。一般の場合の根拠は構造化記述である。
- 二元舞台の反例検査は本文が与えた個別の証人についての検査であり、反例全体の分類ではない。

## 走査で分かったこと（本文の記述との差）

- 合成が自己転置になる（＝可換な）自己転置割り当ての順序対の個数は、`|V| = 0, 1, 2, 3` で
  それぞれ 1、4、42、1,204 であり、全順序対数 1、4、64、4,096 と比べると `|V| >= 2` で真に少ない。
  すなわち走査範囲では、自己転置な割り当て全体が合成で閉じるのは `|V| <= 1` のときだけである。
  本文は二元舞台の反例だけを主張しており、この観測はそれと矛盾しない。
  `|V| <= 1` で必ず閉じることは本章では主張していない（走査で観測しただけである）。
- 本文の記述に修正を要する差は見つからなかった。

## 限界と帰属

- 有限集合、有限部分集合、有限写像表、`ZZ` の等号だけを使う。浮動小数点と `R/C` 脱出はない。
- 有限決定は判定回数の一致（合成の各セルで高々 `n` 項の合併、自己転置性の判定で `n` 回の値の比較）
  まで検査したものであり、計算コストモデルそのものは検査していない。

## 実行方法

```bash
for file in sagemath/check/self-transpose-composition-closure/check_*.sage; do sage "$file"; done
```
