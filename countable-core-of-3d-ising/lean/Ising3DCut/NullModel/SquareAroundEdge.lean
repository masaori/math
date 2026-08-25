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

end Ising3DCut.NullModel
