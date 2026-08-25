/-
「破れ数がちょうど 1 の配位は存在しない」の Lean 具体版の後半の土台。

人手証明の第一段は、辺 `(a,i)` に対して方向 `j\ne i` を取り、点 `c` を軸 `j` 方向へ
一つずらしたり戻したりして、四隅 `c, c+ε_j, c+ε_i, c+ε_i+ε_j` の正方形を作る。
このファイルは、その「方向を一つ選ぶ」ことと「一つの座標だけを増やす」ことを、
人手証明と同じ具体度（座標の値そのもの）で用意する。
次の段でこれを使って四隅と三辺を構成し、`brokenCount_ne_one_of_alternate_three_edges` へ渡す。

住処: `Fin`、`Nat`、有限集合だけ。ℝ / ℂ は現れない。
-/
import Ising3DCut.NullModel.OneBreakageImpossible

namespace Ising3DCut.NullModel

/-- 与えられた方向と異なる方向を一つ選ぶ。人手証明の
「方向 `j\in\{1,2,3\}\setminus\{i\}` を一つ取る」に対応する。 -/
def otherAxis (i : Fin 3) : Fin 3 := if i = 0 then 1 else 0

/-- 選んだ方向は元の方向と異なる。 -/
lemma otherAxis_ne (i : Fin 3) : otherAxis i ≠ i := by
  fin_cases i <;> decide

/-- 一辺が二以上の箱では、任意の座標について正方向へ一つ進めるか、負方向へ一つ戻れる。
正方形を元の辺の正側と負側のどちらへ置くかを、この二つの場合で決める。 -/
lemma shiftUp_available_or_shiftDown_available {L : ℕ} (hL : 2 ≤ L) (a : Site L) (j : Fin 3) :
    a.1 j + 1 < L ∨ 1 ≤ a.1 j := by
  omega

/-- 点の第 `j` 座標だけを 1 増やした点。`ε_j` を足す操作に対応する。 -/
def shiftUp {L : ℕ} (a : Site L) (j : Fin 3) (h : a.1 j + 1 < L) : Site L :=
  ⟨Function.update a.1 j (a.1 j + 1), by
    intro k
    by_cases hk : k = j
    · subst k; simpa using h
    · rw [Function.update_of_ne hk]; exact a.2 k⟩

/-- 増やした方向の座標は 1 大きい。 -/
@[simp] lemma shiftUp_apply_self {L : ℕ} (a : Site L) (j : Fin 3) (h : a.1 j + 1 < L) :
    (shiftUp a j h).1 j = a.1 j + 1 := by
  simp [shiftUp]

/-- 他の方向の座標は変わらない。 -/
@[simp] lemma shiftUp_apply_of_ne {L : ℕ} (a : Site L) (j k : Fin 3) (h : a.1 j + 1 < L)
    (hk : k ≠ j) : (shiftUp a j h).1 k = a.1 k := by
  simp [shiftUp, Function.update_of_ne hk]

/-- 辺の第二端点は、始点をその方向へ一つずらした点である。 -/
lemma endpoint1_eq_shiftUp {L : ℕ} (e : Edge L) :
    endpoint1 e = shiftUp e.start e.axis e.next_lt := rfl

/-- 異なる二方向へ一つずつずらす操作は順序によらない。正方形の向かい合う二隅が
同じ点であること（人手証明の `a+\varepsilon_i+\varepsilon_j` の二通りの書き方）に対応する。 -/
lemma shiftUp_comm {L : ℕ} (a : Site L) (j k : Fin 3) (hjk : j ≠ k)
    (hj : a.1 j + 1 < L) (hk : a.1 k + 1 < L)
    (hj' : (shiftUp a k hk).1 j + 1 < L) (hk' : (shiftUp a j hj).1 k + 1 < L) :
    shiftUp (shiftUp a j hj) k hk' = shiftUp (shiftUp a k hk) j hj' := by
  apply Subtype.ext
  funext m
  by_cases hmk : m = k <;> by_cases hmj : m = j <;>
    simp_all [shiftUp, Function.update_apply]

/-- 点の第 `j` 座標だけを 1 減らした点。人手証明の `c=a-\varepsilon_j` に対応する。 -/
def shiftDown {L : ℕ} (a : Site L) (j : Fin 3) : Site L :=
  ⟨Function.update a.1 j (a.1 j - 1), by
    intro k
    by_cases hk : k = j
    · subst k
      simp only [Function.update_self]
      exact Nat.lt_of_le_of_lt (Nat.sub_le _ _) (a.2 j)
    · rw [Function.update_of_ne hk]; exact a.2 k⟩

/-- 減らした方向の座標は 1 小さい。 -/
@[simp] lemma shiftDown_apply_self {L : ℕ} (a : Site L) (j : Fin 3) :
    (shiftDown a j).1 j = a.1 j - 1 := by
  simp [shiftDown]

/-- 他の方向の座標は変わらない。 -/
@[simp] lemma shiftDown_apply_of_ne {L : ℕ} (a : Site L) (j k : Fin 3) (hk : k ≠ j) :
    (shiftDown a j).1 k = a.1 k := by
  simp [shiftDown, Function.update_of_ne hk]

/-- 第 `j` 座標が 1 以上なら、一つ減らしてから一つ増やすと元の点に戻る。
人手証明の `c+\varepsilon_j=a` に対応する。 -/
lemma shiftUp_shiftDown {L : ℕ} (a : Site L) (j : Fin 3) (hpos : 1 ≤ a.1 j)
    (h : (shiftDown a j).1 j + 1 < L) : shiftUp (shiftDown a j) j h = a := by
  apply Subtype.ext
  funext m
  by_cases hm : m = j
  · subst m
    rw [shiftUp_apply_self, shiftDown_apply_self]
    omega
  · rw [shiftUp_apply_of_ne _ _ _ _ hm, shiftDown_apply_of_ne _ _ _ hm]

/-- 正側に置いた正方形の、元の辺 `(a,i)` と隣り合う一本目 `(a,j)`。人手証明の三辺のうち
始点を共有するものに対応する。 -/
def squareUpEdgeFromStart {L : ℕ} (e : Edge L) (j : Fin 3) (hj : e.start.1 j + 1 < L) : Edge L :=
  ⟨e.start, j, hj⟩

/-- 正側に置いた正方形の二本目 `(a+ε_j, i)`。始点をずらしても `i` 成分は変わらないので、
第二端点が箱内にあることは元の辺の条件からそのまま従う。 -/
def squareUpEdgeShifted {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hj : e.start.1 j + 1 < L) : Edge L :=
  ⟨shiftUp e.start j hj, e.axis, by
    rw [shiftUp_apply_of_ne e.start j e.axis hj (Ne.symm hji)]
    exact e.next_lt⟩

/-- 正側に置いた正方形の三本目 `(a+ε_i, j)`。 -/
def squareUpEdgeOpposite {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hj : e.start.1 j + 1 < L) : Edge L :=
  ⟨shiftUp e.start e.axis e.next_lt, j, by
    rw [shiftUp_apply_of_ne e.start e.axis j e.next_lt hji]
    exact hj⟩

/-- 三本目の始点は一本目の始点を `i` 方向へずらした点であり、元の辺の第二端点に等しい。 -/
lemma squareUpEdgeOpposite_start {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hj : e.start.1 j + 1 < L) :
    (squareUpEdgeOpposite e j hji hj).start = endpoint1 e :=
  (endpoint1_eq_shiftUp e).symm

/-- 二本目の始点は一本目の第二端点に等しい。 -/
lemma squareUpEdgeShifted_start {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hj : e.start.1 j + 1 < L) :
    (squareUpEdgeShifted e j hji hj).start = endpoint1 (squareUpEdgeFromStart e j hj) :=
  (endpoint1_eq_shiftUp (squareUpEdgeFromStart e j hj)).symm

/-- 正方形が閉じること。二本目と三本目の第二端点はどちらも `a+ε_i+ε_j` であり一致する。
人手証明の「四隅のうち向かい合う一隅が二通りに書ける」に対応する。 -/
theorem squareUp_closes {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hj : e.start.1 j + 1 < L) :
    endpoint1 (squareUpEdgeShifted e j hji hj) = endpoint1 (squareUpEdgeOpposite e j hji hj) := by
  rw [endpoint1_eq_shiftUp, endpoint1_eq_shiftUp]
  exact shiftUp_comm e.start j e.axis hji hj e.next_lt _ _

/-- 正側の正方形の三辺は、いずれも元の辺とは異なる。一本目と三本目は方向が `j\ne i` で異なり、
二本目は方向が同じでも始点の `j` 成分が 1 だけ大きい。 -/
lemma squareUp_edges_ne {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hj : e.start.1 j + 1 < L) :
    squareUpEdgeFromStart e j hj ≠ e ∧
    squareUpEdgeShifted e j hji hj ≠ e ∧
    squareUpEdgeOpposite e j hji hj ≠ e := by
  refine ⟨?_, ?_, ?_⟩
  · intro h; exact hji (congrArg Edge.axis h)
  · intro h
    have hs : (squareUpEdgeShifted e j hji hj).start = e.start := congrArg Edge.start h
    have := congrFun (congrArg Subtype.val hs) j
    rw [show (squareUpEdgeShifted e j hji hj).start = shiftUp e.start j hj from rfl] at this
    rw [shiftUp_apply_self e.start j hj] at this
    omega
  · intro h; exact hji (congrArg Edge.axis h)

/-- 正側の正方形の三辺が、元の辺の始点から第二端点までを向きによらずつなぐこと。
一本目と二本目は始点から進み、三本目は元の辺の第二端点から向かい合う隅へ向かうので、
向きを問わない `Connects` で述べる。 -/
theorem squareUp_connects_chain {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hj : e.start.1 j + 1 < L) :
    ∃ (f₁ f₂ f₃ : Edge L) (p q : Site L),
      f₁ ≠ e ∧ f₂ ≠ e ∧ f₃ ≠ e ∧
      Connects f₁ (endpoint0 e) p ∧ Connects f₂ p q ∧ Connects f₃ q (endpoint1 e) := by
  obtain ⟨h₁, h₂, h₃⟩ := squareUp_edges_ne e j hji hj
  refine ⟨squareUpEdgeFromStart e j hj, squareUpEdgeShifted e j hji hj,
    squareUpEdgeOpposite e j hji hj,
    endpoint1 (squareUpEdgeFromStart e j hj), endpoint1 (squareUpEdgeShifted e j hji hj),
    h₁, h₂, h₃, Or.inl ⟨rfl, rfl⟩, Or.inl ⟨?_, rfl⟩, Or.inr ⟨?_, ?_⟩⟩
  · exact squareUpEdgeShifted_start e j hji hj
  · exact squareUpEdgeOpposite_start e j hji hj
  · exact (squareUp_closes e j hji hj).symm

/-- 第 `j` 座標が正なら、一つ戻した点から `j` 方向へ進む辺は箱内にある。 -/
lemma shiftDown_next_lt {L : ℕ} (a : Site L) (j : Fin 3) (hpos : 1 ≤ a.1 j) :
    (shiftDown a j).1 j + 1 < L := by
  rw [shiftDown_apply_self]
  rw [Nat.sub_add_cancel hpos]
  exact a.2 j

/-- 負側に置いた正方形の、元の辺の始点へ戻る一本目 `(a-ε_j,j)`。 -/
def squareDownEdgeToStart {L : ℕ} (e : Edge L) (j : Fin 3) (hpos : 1 ≤ e.start.1 j) :
    Edge L :=
  ⟨shiftDown e.start j, j, shiftDown_next_lt e.start j hpos⟩

/-- 負側に置いた正方形の二本目 `(a-ε_j,i)`。 -/
def squareDownEdgeFromLower {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hpos : 1 ≤ e.start.1 j) : Edge L :=
  ⟨shiftDown e.start j, e.axis, by
    rw [shiftDown_apply_of_ne e.start j e.axis (Ne.symm hji)]
    exact e.next_lt⟩

/-- 負側に置いた正方形の三本目 `(a-ε_j+ε_i,j)`。 -/
def squareDownEdgeOpposite {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hpos : 1 ≤ e.start.1 j) : Edge L :=
  ⟨shiftUp (shiftDown e.start j) e.axis (by
      rw [shiftDown_apply_of_ne e.start j e.axis (Ne.symm hji)]
      exact e.next_lt),
    j, by
      rw [shiftUp_apply_of_ne _ e.axis j _ hji]
      exact shiftDown_next_lt e.start j hpos⟩

/-- 一本目の第二端点は元の辺の始点に戻る。 -/
lemma squareDownEdgeToStart_endpoint {L : ℕ} (e : Edge L) (j : Fin 3)
    (hpos : 1 ≤ e.start.1 j) :
    endpoint1 (squareDownEdgeToStart e j hpos) = e.start := by
  rw [endpoint1_eq_shiftUp]
  exact shiftUp_shiftDown e.start j hpos _

/-- 二本目の第二端点は三本目の始点に等しい。 -/
lemma squareDownEdgeOpposite_start {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hpos : 1 ≤ e.start.1 j) :
    (squareDownEdgeOpposite e j hji hpos).start =
      endpoint1 (squareDownEdgeFromLower e j hji hpos) :=
  (endpoint1_eq_shiftUp (squareDownEdgeFromLower e j hji hpos)).symm

/-- 負側の正方形が閉じること。三本目の第二端点は元の辺の第二端点に等しい。 -/
theorem squareDown_closes {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hpos : 1 ≤ e.start.1 j) :
    endpoint1 (squareDownEdgeOpposite e j hji hpos) = endpoint1 e := by
  apply Subtype.ext
  funext m
  by_cases hmj : m = j <;> by_cases hmi : m = e.axis <;>
    simp_all [endpoint1, squareDownEdgeOpposite, shiftUp, shiftDown, Function.update_apply]

/-- 負側の正方形の三辺も、いずれも元の辺とは異なる。一本目と三本目は方向が `j\ne i` で異なり、
二本目は方向が同じでも始点の `j` 成分が 1 だけ小さい。 -/
lemma squareDown_edges_ne {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hpos : 1 ≤ e.start.1 j) :
    squareDownEdgeToStart e j hpos ≠ e ∧
    squareDownEdgeFromLower e j hji hpos ≠ e ∧
    squareDownEdgeOpposite e j hji hpos ≠ e := by
  refine ⟨?_, ?_, ?_⟩
  · intro h; exact hji (congrArg Edge.axis h)
  · intro h
    have hs : (squareDownEdgeFromLower e j hji hpos).start = e.start := congrArg Edge.start h
    have := congrFun (congrArg Subtype.val hs) j
    rw [show (squareDownEdgeFromLower e j hji hpos).start = shiftDown e.start j from rfl] at this
    rw [shiftDown_apply_self e.start j] at this
    omega
  · intro h; exact hji (congrArg Edge.axis h)

/-- 負側の正方形の三辺が、元の辺の始点から第二端点までを向きによらずつなぐこと。
一本目は元の辺の始点へ向かって戻る辺なので、ここでも向きを問わない `Connects` が要る。 -/
theorem squareDown_connects_chain {L : ℕ} (e : Edge L) (j : Fin 3) (hji : j ≠ e.axis)
    (hpos : 1 ≤ e.start.1 j) :
    ∃ (f₁ f₂ f₃ : Edge L) (p q : Site L),
      f₁ ≠ e ∧ f₂ ≠ e ∧ f₃ ≠ e ∧
      Connects f₁ (endpoint0 e) p ∧ Connects f₂ p q ∧ Connects f₃ q (endpoint1 e) := by
  obtain ⟨h₁, h₂, h₃⟩ := squareDown_edges_ne e j hji hpos
  refine ⟨squareDownEdgeToStart e j hpos, squareDownEdgeFromLower e j hji hpos,
    squareDownEdgeOpposite e j hji hpos,
    shiftDown e.start j, endpoint1 (squareDownEdgeFromLower e j hji hpos),
    h₁, h₂, h₃, Or.inr ⟨rfl, ?_⟩, Or.inl ⟨rfl, rfl⟩, Or.inl ⟨?_, ?_⟩⟩
  · exact squareDownEdgeToStart_endpoint e j hpos
  · exact squareDownEdgeOpposite_start e j hji hpos
  · exact squareDown_closes e j hji hpos

/-- 箱の一辺が二以上なら、どの辺についても、その両端を結ぶ別の三辺が取れる。
補助方向 `j` は元の方向と異なるものを選び、`j` 方向へ進めるなら正側の正方形を、
進めないなら（一辺が二以上なので）戻れるので負側の正方形を使う。 -/
theorem alternate_three_edges_exists {L : ℕ} (hL : 2 ≤ L) (e : Edge L) :
    ∃ (f₁ f₂ f₃ : Edge L) (p q : Site L),
      f₁ ≠ e ∧ f₂ ≠ e ∧ f₃ ≠ e ∧
      Connects f₁ (endpoint0 e) p ∧ Connects f₂ p q ∧ Connects f₃ q (endpoint1 e) := by
  have hji : otherAxis e.axis ≠ e.axis := otherAxis_ne e.axis
  rcases shiftUp_available_or_shiftDown_available hL e.start (otherAxis e.axis) with hup | hdown
  · exact squareUp_connects_chain e (otherAxis e.axis) hji hup
  · exact squareDown_connects_chain e (otherAxis e.axis) hji hdown

/-- 一辺が二以上の箱では、破れ数がちょうど 1 の配位は存在しない。
すなわち多重度 `Ω_L(1)` は零である。 -/
theorem brokenCount_ne_one {L : ℕ} (hL : 2 ≤ L) (σ : Config L) : brokenCount σ ≠ 1 :=
  brokenCount_ne_one_of_alternate_three_edges σ (alternate_three_edges_exists hL)

end Ising3DCut.NullModel
