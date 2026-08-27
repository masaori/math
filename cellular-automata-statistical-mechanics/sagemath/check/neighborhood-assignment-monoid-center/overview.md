# SageMath 検算: 有限近傍割り当てモノイドの中心

## 対象

**対象ラベル**: `claim_neighborhood_assignment_monoid_center_characterization`

- 併せて検証するラベル:
  `def_neighborhood_assignment_monoid_center`、
  `def_single_edge_neighborhood_assignment`、
  `claim_neighborhood_assignment_monoid_center_finite_decidability`、
  `def_composed_neighborhood`、
  `def_empty_neighborhood_assignment`、
  `def_identity_neighborhood_assignment`
- 本文の証明の四段（`O_V, I_V` が中心に属すること、`q ∈ N(p)` から `p = q` を出す段、
  自己ループから `I_V ⊆ N` を出す段、`N ⊆ I_V` を出す段）と、有限決定を別々の検算へ分け、
  最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_empty_and_identity_are_central.sage` | 本文の第一段。`O_V star M = O_V = M star O_V` の吸収律と `I_V star M = M = M star I_V` の単位律を、各セルの合成近傍の値へ展開して二つの向きに分けて検査し、そこから中心の定義の所属条件を出す。全数走査による所属の直接確認も行う | PASS |
| `check_self_loop_from_edge_witness.sage` | 本文の第二段と第四段。証人 `E_{q,q}` の値の表を定義から確認し、`q ∈ (N star E_{q,q})(p)` を出す段、中心の定義で二つの合成を入れ替える段、`p ≠ q` なら `E_{q,q}(p) = ∅` で右辺が空集合になり矛盾する段を分けて検査して `p = q`（すなわち `p ∈ N(p)`）を出す。同じ証人による `N(v) ⊆ I_V(v)` も同じ形で検査する | PASS |
| `check_identity_inclusion_from_edge_witness.sage` | 本文の第三段。自己ループを持つ `p` と任意の `b` について、`b ∈ (N star E_{p,b})(p)` を出す段、中心の定義による同値、`E_{p,b}(p) = {b}` と合成近傍の定義による `b ∈ N(b)` への同値を分けて検査し、`I_V(v) ⊆ N(v)` を出す | PASS |
| `check_center_characterization_finite_decision.sage` | 全数走査で得た `Z_star(V)` が `{O_V, I_V}` に一致すること、空舞台では `O_V = I_V` で一元集合、`|V| >= 1` では二元集合であること、特徴づけによる所属判定が全走査の判定と一致すること、写像の等号が `|V|^2` 回の所属判定へ展開できることを分けて検査する | PASS |

## 検証範囲

- 舞台元数は `|V| = 0, 1, 2, 3` である。近傍割り当ての総数は順に 1、2、16、512 で、合計 531 個を
  全て走った。中心の判定は各割り当てについて全ての `M ∈ N(V)` との合成を突き合わせている。
- 全数走査で見つかった中心の元は各舞台で `O_V` と `I_V` だけであり（`|V| = 0` では両者が一致して
  1 個、それ以外は 2 個）、合計 7 個である。うち `O_V` でない元は 3 個で、いずれも `I_V` である。
- `|V| = 4` は近傍割り当てが 65,536 個、その順序対が 4,294,967,296 組になるため全走査していない。
- したがってこれは有限範囲の全数検査であって、任意の有限舞台に対する一般証明ではない。
  一般の場合の根拠は構造化記述の証明である。

## 走査で分かったこと（本文の記述との差）

- 中心の元は走査した全ての舞台で `{O_V, I_V}` と一致し、本文の特徴づけと差はなかった。
- `|V| = 0` で右辺が一元集合になることは、本文が明記しているとおりである。
- 本文の記述に修正を要する差は見つからなかった。

## 限界と帰属

- 有限集合、有限部分集合、有限写像表、`ZZ` の等号だけを使う。浮動小数点と `R/C` 脱出はない。
- 有限決定は判定の手続き（写像の等号を `|V|^2` 回の所属判定へ展開すること）まで検査したもので
  あり、計算コストモデルそのものは検査していない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-assignment-monoid-center/check_*.sage; do sage "$file"; done
```
