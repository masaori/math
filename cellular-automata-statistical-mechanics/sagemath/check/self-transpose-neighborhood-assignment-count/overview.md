# SageMath 検算: 自己転置な近傍割り当ての個数

## 対象

**対象ラベル**: `claim_self_transpose_neighborhood_assignment_count`

- 併せて検証するラベル:
  `def_self_transpose_neighborhood_assignment`、
  `claim_self_transpose_iff_symmetric_membership`、
  `def_unordered_cell_pairs`、
  `def_self_transpose_pair_encoding`、
  `def_pair_set_neighborhood_reconstruction`、
  `claim_self_transpose_pair_encoding_bijection`、
  `claim_unordered_cell_pair_count`、
  `claim_self_transpose_neighborhood_assignments_finitely_decidable`
- 本文の各段（自己転置性と近傍所属の対称性の同値、非順序対符号と復元が互いに逆であること、
  非順序対の個数、最終個数、有限決定）を別々の検算に分け、最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_self_transpose_iff_symmetric_membership.sage` | `N^T = N ⟺ (∀ v,w, w ∈ N(v) ⟺ v ∈ N(w))`。順方向（`N^T = N` の所属への適用と転置の所属同値）と逆方向（転置の所属同値、仮定した対称性、集合と写像の二回の外延性）を段ごとに分けて検査 | PASS |
| `check_unordered_pair_count.sage` | `|U(V)| = n + C(n,2) = n(n+1)/2`。一元・二元部分集合への非交和、`v ↦ {v}` の全単射、二項係数、通分と分配律の各等号、`n(n+1)` の偶数性を分けて検査 | PASS |
| `check_pair_encoding_bijection.sage` | `ε_V` と `ρ_V` が互いに逆であること。所属条件が非順序対の表示順序に依存しないこと、`ρ_V(B)` の自己転置性、`ε_V(ρ_V(B)) = B`、`ρ_V(ε_V(N)) = N` を所属ごとに検査してから外延性で等号にする段を分けて検査 | PASS |
| `check_self_transpose_count.sage` | `|{N | N^T = N}| = 2^{|U(V)|} = 2^{n(n+1)/2}`。全単射による個数の一致、部分集合の個数、非順序対の個数を分けて検査 | PASS |
| `check_finite_decision.sage` | `N(V)` の有限列挙（`|N(V)| = 2^{n^2}`）、転置表が `n^2` 回の所属判定で決まること、自己転置性が `n` 回の値の比較で決まること、走査で集めた有限集合の個数が `2^{n(n+1)/2}` になることを分けて検査 | PASS |

## 検証範囲

- 走査は `|V| = 0, 1, 2, 3, 4` の全数検査である（`check_unordered_pair_count.sage` だけは
  近傍割り当てを走査しないので `|V| = 0..7`）。近傍割り当ては各サイズで 1、2、16、512、65,536 個、
  自己転置なものは 1、2、8、64、1,024 個であり、この範囲は尽くしている。
- `|V| >= 5` は走査していない。したがってこれらは有限範囲の全数検査であって、
  任意の有限舞台に対する一般証明ではない。一般の場合の根拠は構造化記述である。

## 走査で分かったこと（本文の記述との差）

- 自己転置な近傍割り当ての個数は `|V| = 0..4` でそれぞれ 1、2、8、64、1,024 であり、
  本文の `2^{n(n+1)/2}` と一致した。前対象の検算で `|V| <= 3` について観測した値を
  `|V| = 4` まで延長して確認したことになる。
- 本文の記述に修正を要する差は見つからなかった。

## 限界と帰属

- 有限集合、有限部分集合、有限写像表、`ZZ` の等号だけを使う。浮動小数点と `R/C` 脱出はない。
- 有限決定は判定回数の一致（所属判定 `n^2` 回、値の比較 `n` 回）まで検査したものであり、
  計算コストモデルそのものは検査していない。

## 実行方法

```bash
for file in sagemath/check/self-transpose-neighborhood-assignment-count/check_*.sage; do sage "$file"; done
```
