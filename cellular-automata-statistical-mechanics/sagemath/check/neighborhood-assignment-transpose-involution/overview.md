# SageMath 検算: 近傍割り当ての転置対合

## 対象

**対象ラベル**: `claim_neighborhood_assignment_transpose_involutive`

- 併せて検証するラベル:
  `def_neighborhood_assignment_transpose`、
  `claim_neighborhood_assignment_transpose_membership`、
  `claim_neighborhood_assignment_transpose_reverses_composition`、
  `claim_neighborhood_assignment_transpose_preserves_lattice_operations`、
  `claim_neighborhood_assignment_transpose_finitely_decidable`
- 本文の各段（所属の向きの反転、対合性、合成順序の反転、点ごとの和・積と自己近傍割り当ての保存、
  転置表の有限決定）を別々の検算に分け、最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_transpose_membership.sage` | 転置の値が `V` の部分集合であること（`N^T` が近傍割り当てであること）と、`v ∈ N^T(w) ⟺ w ∈ N(v)` を全数検査 | PASS |
| `check_transpose_involution.sage` | `(N^T)^T = N`。所属の向きの反転を `N^T` と `N` へ順に適用する二段、集合の外延性、写像の外延性を分けて検査 | PASS |
| `check_transpose_reverses_composition.sage` | `(N⋆M)^T = M^T ⋆ N^T`。所属の向きの反転、合成近傍の定義による存在文、証人の条件の書き換え（各 `u` について同値を個別に検査）、逆順の合成への所属を分けて検査 | PASS |
| `check_transpose_preserves_lattice_operations.sage` | `(N⊔M)^T = N^T ⊔ M^T`、`(N⊓M)^T = N^T ⊓ M^T`、`I_V^T = I_V`。合併・共通部分への所属と等号の対称性を段ごとに分けて検査 | PASS |
| `check_transpose_finite_decision.sage` | `|N(V)| = 2^{|V|^2}`、`N^T` の全値が `|V|^2` 回の所属判定で決まること、転置表が `N(V)` に閉じて全単射になること、各法則を有限表の全入力で比較できることを検査 | PASS |

## 検証範囲

- 走査は `|V| = 0, 1, 2, 3` の全数検査である。近傍割り当ては各サイズで 1、2、16、512 個、
  組は 1、4、256、262,144 組であり、この範囲は尽くしている。
- `|V| >= 4` は走査していない。したがってこれらは有限範囲の全数検査であって、
  任意の有限舞台に対する一般証明ではない。一般の場合の根拠は構造化記述である。

## 走査で分かったこと（本文の記述との差）

- **順序を反転しない等式 `(N⋆M)^T = N^T ⋆ M^T` は一般には成り立たない。**
  `|V| = 0, 1` では反例なし、`|V| = 2` では 256 組のうち 156 組、`|V| = 3` では 262,144 組のうち
  245,214 組が反例である。反例が初めて現れる舞台元数は 2 である。
  本文は反転する側だけを主張しているので記述の誤りではないが、
  転置が合成について準同型ではなく反準同型であることの有限側の裏付けとして記録する。
- **自己転置な近傍割り当て（`N^T = N`）の個数は `|V| = 0, 1, 2, 3` でそれぞれ 1、2、8、64 であり、
  `2^{|V|(|V|+1)/2}` に一致する。** これは対称な二項関係の個数である。
  本文はこの数え上げを主張していない。主張として立てるかは次の対象の判断に回す。

## 限界と帰属

- 有限集合、有限写像表、自然数の等号だけを使う。浮動小数点と `R/C` 脱出はない。
- 転置表の有限決定は判定回数の一致（`|N(V)|·|V|^2`）まで検査したものであり、
  計算コストモデルそのものは検査していない。

## 実行方法

```bash
for file in sagemath/check/neighborhood-assignment-transpose-involution/check_*.sage; do sage "$file"; done
```
