/-
章「近傍割り当ての反射推移閉包」の必要十分版。

必要な構造の検査結果:
  - 合成冪、全ての有限長の合成冪の合併としての反射推移閉包、その反射性・包含・
    推移性・合成冪等性・最小性には、舞台の有限性も等号判定も要らない。近傍を
    `Set` 値で表せば、型にインスタンスを一つも要求しない。
  - 具体版の有限近似が `|V|²` までに安定することと、閉包を有限表として構成・判定
    することにだけ、舞台の有限性が要る。`Finset` 表現には等号判定も要る。
  - 具体版の `N^{≤|V|²}` は、必要十分版の「全ての有限長の合成冪の合併」と一致する。
    一致の逆包含だけが有限舞台上の安定化を使う。
  - 状態集合、局所規則、時間、順序、ℝ / ℂ は使わない。
-/
import CellularAutomata.NeighborhoodAssignmentReachabilityClosure
import CellularAutomata.NecSuf.NeighborhoodAssignmentCompositionIdempotents

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityClosure

open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NecSuf.NeighborhoodAssignmentCompositionIdempotents

/-- 合成冪の `Set` 版。有限性も等号判定も要求しない。 -/
def setCompositionPower {V : Type} (N : V → Set V) : ℕ → V → Set V
  | 0 => setIdentity V
  | k + 1 => setComp (setCompositionPower N k) N

/-- 全ての有限長の合成冪の合併として定める反射推移閉包。 -/
def setReachabilityClosure {V : Type} (N : V → Set V) : V → Set V :=
  fun v => {w | ∃ k : ℕ, w ∈ setCompositionPower N k v}

/-- 合成冪の指数加法則。第二の指数についての帰納法で示す。 -/
theorem setCompositionPower_additive {V : Type} (N : V → Set V) (i j : ℕ) :
    setComp (setCompositionPower N i) (setCompositionPower N j) =
      setCompositionPower N (i + j) := by
  induction j with
  | zero =>
      calc
        setComp (setCompositionPower N i) (setCompositionPower N 0)
            = setComp (setCompositionPower N i) (setIdentity V) := rfl
        _ = setCompositionPower N i := setComp_setIdentity _
        _ = setCompositionPower N (i + 0) := by rw [Nat.add_zero]
  | succ j ih =>
      calc
        setComp (setCompositionPower N i) (setCompositionPower N (j + 1))
            = setComp (setCompositionPower N i)
                (setComp (setCompositionPower N j) N) := rfl
        _ = setComp (setComp (setCompositionPower N i) (setCompositionPower N j)) N :=
              (setComp_assoc _ _ _).symm
        _ = setComp (setCompositionPower N (i + j)) N := by rw [ih]
        _ = setCompositionPower N (i + j + 1) := rfl
        _ = setCompositionPower N (i + (j + 1)) := by rw [Nat.add_assoc]

/-- 閉包は自己近傍を含む。長さ零の合成冪を使う。 -/
theorem setReachabilityClosure_self_mem {V : Type} (N : V → Set V) (v : V) :
    v ∈ setReachabilityClosure N v :=
  ⟨0, rfl⟩

/-- 閉包はもとの近傍割り当てを含む。長さ一の合成冪を使う。 -/
theorem setReachabilityClosure_contains_original {V : Type} (N : V → Set V) :
    ∀ v w : V, w ∈ N v → w ∈ setReachabilityClosure N v := by
  intro v w hw
  exact ⟨1, v, rfl, hw⟩

/-- 閉包は推移的である。二つの証人指数を足す。 -/
theorem setReachabilityClosure_transitive {V : Type} (N : V → Set V) :
    SetTransitive (setReachabilityClosure N) := by
  rintro v u w ⟨i, hu⟩ ⟨j, hw⟩
  refine ⟨i + j, ?_⟩
  rw [← setCompositionPower_additive N i j]
  exact ⟨u, hu, hw⟩

/-- 閉包は合成について冪等である。 -/
theorem setReachabilityClosure_idempotent {V : Type} (N : V → Set V) :
    SetCompositionIdempotent (setReachabilityClosure N) :=
  (setCompositionIdempotent_iff_transitive_of_self_mem
      (setReachabilityClosure N) (setReachabilityClosure_self_mem N)).mpr
    (setReachabilityClosure_transitive N)

/-- 自己近傍を含み推移的で `N` を含む割り当ては、全ての合成冪を含む。 -/
theorem setCompositionPower_included_of_upper_bound {V : Type} (N M : V → Set V)
    (hSelf : ∀ v : V, v ∈ M v) (hTrans : SetTransitive M)
    (hNM : ∀ v w : V, w ∈ N v → w ∈ M v) (k : ℕ) :
    ∀ v w : V, w ∈ setCompositionPower N k v → w ∈ M v := by
  induction k with
  | zero =>
      intro v w hw
      exact hw ▸ hSelf v
  | succ k ih =>
      rintro v w ⟨u, hu, hw⟩
      exact hTrans v u w (ih v u hu) (hNM u w hw)

/-- 反射推移閉包の最小性。 -/
theorem setReachabilityClosure_minimal {V : Type} (N M : V → Set V)
    (hSelf : ∀ v : V, v ∈ M v) (hTrans : SetTransitive M)
    (hNM : ∀ v w : V, w ∈ N v → w ∈ M v) :
    ∀ v w : V, w ∈ setReachabilityClosure N v → w ∈ M v := by
  rintro v w ⟨k, hw⟩
  exact setCompositionPower_included_of_upper_bound N M hSelf hTrans hNM k v w hw

/-! ### 有限表現との橋渡しと具体版の導出 -/

namespace Derivation

open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.NeighborhoodAssignmentCompositionIdempotents
open CellularAutomata.NeighborhoodAssignmentReachabilityClosure
open CellularAutomata.OrderedNeighborhoodAssignmentMonoid

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 具体版の合成冪を集合として読むと必要十分版の合成冪に一致する。 -/
theorem coe_compositionPower (N : NeighborhoodAssignment V) (k : ℕ) :
    (fun v => ((compositionPower N k v : Finset V) : Set V)) =
      setCompositionPower (fun v => ((N v : Finset V) : Set V)) k := by
  induction k with
  | zero =>
      funext v
      exact coe_identityNeighborhood v
  | succ k ih =>
      funext v
      rw [compositionPower, setCompositionPower]
      change ((hetComp (compositionPower N k) N v : Finset V) : Set V) = _
      rw [coe_hetComp, ih]

/-- 具体版の有限閉包は、全ての有限長の合成冪の合併に一致する。 -/
theorem coe_reachabilityClosure (N : NeighborhoodAssignment V) :
    (fun v => ((reachabilityClosure N v : Finset V) : Set V)) =
      setReachabilityClosure (fun v => ((N v : Finset V) : Set V)) := by
  funext v
  ext w
  constructor
  · intro hw
    obtain ⟨j, _hj, hwj⟩ :=
      (mem_reachabilityApproximation N (Fintype.card V ^ 2) v w).mp hw
    refine ⟨j, ?_⟩
    rw [← coe_compositionPower N j]
    exact hwj
  · rintro ⟨j, hwj⟩
    have hwj' : w ∈ compositionPower N j v := by
      have hPower := congrFun (coe_compositionPower N j) v
      change w ∈ ((compositionPower N j v : Finset V) : Set V)
      rw [hPower]
      exact hwj
    exact compositionPower_included_in_closure N j v hwj'

/-- 具体版の反射性は必要十分版の特殊化である。 -/
theorem reachabilityClosure_self_mem_of_necSuf (N : NeighborhoodAssignment V) (v : V) :
    v ∈ reachabilityClosure N v := by
  have h := setReachabilityClosure_self_mem
    (fun v => ((N v : Finset V) : Set V)) v
  rw [← coe_reachabilityClosure N] at h
  exact h

/-- 具体版の元の割り当ての包含は必要十分版の特殊化である。 -/
theorem reachabilityClosure_contains_original_of_necSuf (N : NeighborhoodAssignment V) :
    PointwiseInclusion N (reachabilityClosure N) := by
  intro v w hw
  have h := setReachabilityClosure_contains_original
    (fun v => ((N v : Finset V) : Set V)) v w hw
  rw [← coe_reachabilityClosure N] at h
  exact h

/-- 具体版の推移性は必要十分版の特殊化である。 -/
theorem reachabilityClosure_isTransitive_of_necSuf (N : NeighborhoodAssignment V) :
    IsTransitive (reachabilityClosure N) := by
  intro v u w hu hw
  have h := setReachabilityClosure_transitive
    (fun v => ((N v : Finset V) : Set V)) v u w
  rw [← coe_reachabilityClosure N] at h
  exact h hu hw

/-- 具体版の合成冪等性は、導出した反射性と推移性の特殊化である。 -/
theorem reachabilityClosure_isCompositionIdempotent_of_necSuf
    (N : NeighborhoodAssignment V) :
    IsCompositionIdempotent (reachabilityClosure N) :=
  (compositionIdempotent_iff_transitive_of_self_mem
      (reachabilityClosure N) (reachabilityClosure_self_mem_of_necSuf N)).mpr
    (reachabilityClosure_isTransitive_of_necSuf N)

/-- 具体版の最小性は必要十分版の特殊化である。 -/
theorem reachabilityClosure_minimal_of_necSuf (N M : NeighborhoodAssignment V)
    (hSelf : ∀ v : V, v ∈ M v) (hTrans : IsTransitive M)
    (hNM : PointwiseInclusion N M) :
    PointwiseInclusion (reachabilityClosure N) M := by
  intro v w hw
  apply setReachabilityClosure_minimal
    (fun v => ((N v : Finset V) : Set V))
    (fun v => ((M v : Finset V) : Set V)) hSelf hTrans hNM v w
  rw [← coe_reachabilityClosure N]
  exact hw

end Derivation

end CellularAutomata.NecSuf.NeighborhoodAssignmentReachabilityClosure
