# SageMath 検算: 合成冪等な近傍割り当ての特徴づけ

## 対象

**対象ラベル**: `claim_composition_idempotent_neighborhood_assignment_characterization`

- 併せて検証するラベル:
  `def_composition_idempotent_neighborhood_assignment`、
  `def_transitive_neighborhood_assignment`、
  `def_two_step_factorable_neighborhood_assignment`、
  `claim_reflexive_neighborhood_assignment_idempotent_iff_transitive`、
  `claim_transitive_and_factorable_neighborhood_assignment_independent`、
  `claim_composition_idempotent_neighborhood_assignment_finite_decidable`、
  `def_composed_neighborhood`、
  `def_finite_neighborhood_assignment_space`
- 本文の証明を、特徴づけの前半（冪等 ⟹ 推移的かつ二段分解可能）、後半（逆向き）、自己近傍を
  含む場合、二つの反例、有限決定の五つへ分け、最終式だけの一致で済ませない。

## チェック一覧

| ファイル | 検証内容 | ステータス |
| --- | --- | --- |
| `check_idempotent_implies_transitive_and_factorable.sage` | 本文の前半。`u in N(v)` かつ `w in N(u)` から合成近傍の定義で `w in (N star N)(v)` を出す段、冪等性で `N(v)` へ書き換える段、`w in N(v)` から冪等性で `w in (N star N)(v)` を出す段、合成近傍の定義による存在文への同値の段を分けて検査する | PASS |
| `check_transitive_and_factorable_implies_idempotent.sage` | 本文の後半。`(N star N)(v) ⊆ N(v)` を証人の取り出しと推移性で出す段、`N(v) ⊆ (N star N)(v)` を二段分解の証人で出す段、集合の外延性による各点の等号、写像の外延性による `N star N = N` を分けて検査する | PASS |
| `check_reflexive_case.sage` | 自己近傍を含む場合。冪等ならば推移的であること、推移的なとき `u := w` が二段分解の存在証人になること（`w in N(v)` と `w in N(w)`）、そこから特徴づけで冪等が出ること、および同値そのものを分けて検査する | PASS |
| `check_independence_counterexamples.sage` | 本文の二つの反例。二元舞台 `N1(a) = {b}`, `N1(b) = ∅` に二段の辺が一つも無いこと（推移性の前提が空）と二段分解の証人が無いこと、三元舞台 `N2(a) = {a,b}`, `N2(b) = {b,c}`, `N2(c) = {c}` で `u := v` が証人になることと `b in N2(a)`, `c in N2(b)`, `c not in N2(a)` を分けて検査する。併せて各反例が現れる最小舞台元数を全数走査で記録する | PASS |
| `check_finite_decidability.sage` | 有限決定。推移性を `V^3` の全組の列挙で決める判定、二段分解可能性を `V^2` の全組と `N(v)` の走査で決める判定、その連言が合成近傍を作って比較する冪等性の判定と一致することを分けて検査する | PASS |

## 検証範囲

- 舞台元数は `|V| = 0, 1, 2, 3` である。近傍割り当ての総数は順に 1、2、16、512 で、合計 531 個を
  全て走った。
- 合成冪等な割り当ては合計 137 個で、推移的かつ二段分解可能な割り当ての個数と一致した。
  自己近傍を含む割り当ては 70 個で、そのすべてで冪等性と推移性の判定が一致した。
- `|V| = 4` は近傍割り当てが 65,536 個になるため全走査していない。
- したがってこれは有限範囲の全数検査であって、任意の有限舞台に対する一般証明ではない。
  一般の場合の根拠は構造化記述の証明である。

## 走査で分かったこと（本文の記述との差）

- **本文の三元舞台の反例より小さい反例が二元舞台に存在する。** 全数走査は、二段分解可能だが
  推移的でない割り当てが `|V| = 2` で既に現れることを示した（`N(a) = {a, b}`, `N(b) = {a}`。
  `a in N(b)` かつ `b in N(a)` だが `b not in N(b)`。各 `w in N(v)` には証人があるので
  二段分解可能である）。本文は存在だけを主張しており最小性は主張していないので誤りではないが、
  最小舞台元数は推移的だが二段分解可能でない側・二段分解可能だが推移的でない側ともに 2 である。
  検算はこの二元反例も定義へ戻って個別に検査する。
- 本文の三元舞台の反例は自己近傍を含むので、`claim_reflexive_neighborhood_assignment_idempotent_iff_transitive`
  と整合して「推移的でない ⟹ 冪等でない」が成り立つことも走査で確認した。
- 上記以外に本文の記述に修正を要する差は見つからなかった。

## 限界と帰属

- 有限集合、有限部分集合、有限写像表だけを使う。浮動小数点と `R/C` 脱出はない。
- 有限決定は判定手続きの一致まで検査したものであり、計算コストモデルそのものは検査していない。

## 実行方法

```bash
for file in sagemath/check/composition-idempotent-neighborhood-assignment/check_*.sage; do sage "$file"; done
```
