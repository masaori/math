import Mathlib.Data.Finset.Max

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J B V : Type*}

noncomputable def featurePoints (A : Finset J) (f : J → B) (p : B → Prop) : Finset J := by
  classical
  exact A.filter (fun j => p (f j))

variable [LinearOrder J]

noncomputable def leastFeaturePoint (A : Finset J) (f : J → B) (p : B → Prop)
    (h : (featurePoints A f p).Nonempty) : J := (featurePoints A f p).min' h

noncomputable def selectedFeatureValue (A : Finset J) (f : J → B) (p : B → Prop)
    (v : J → V) (h : (featurePoints A f p).Nonempty) : V :=
  v (leastFeaturePoint A f p h)

/- 有限性は候補の最小元の存在、線型順序はその選択と比較に使う。
周囲の型の有限性・置換・軌道・自然数・奇偶は使わない。
特徴と選ぶ値の保存は、候補を取る有限集合上だけで要求する。 -/

omit [LinearOrder J] in
theorem featurePoints_eq_necSuf (A : Finset J) (f g : J → B) (p : B → Prop)
    (hfg : ∀ j ∈ A, f j = g j) : featurePoints A f p = featurePoints A g p := by
  classical
  ext j
  calc
    j ∈ featurePoints A f p ↔ j ∈ A ∧ p (f j) := Finset.mem_filter
    _ ↔ j ∈ A ∧ p (g j) := and_congr_right fun hj => by rw [hfg j hj]
    _ ↔ j ∈ featurePoints A g p := by
      simp only [featurePoints, Finset.mem_filter]

omit [LinearOrder J] in
theorem featurePoints_nonempty_necSuf (A : Finset J) (f g : J → B) (p : B → Prop)
    (hfg : ∀ j ∈ A, f j = g j) (hg : (featurePoints A g p).Nonempty) :
    (featurePoints A f p).Nonempty := by
  rw [featurePoints_eq_necSuf A f g p hfg]
  exact hg

theorem leastFeaturePoint_eq_necSuf (A : Finset J) (f g : J → B) (p : B → Prop)
    (hfg : ∀ j ∈ A, f j = g j)
    (hf : (featurePoints A f p).Nonempty) (hg : (featurePoints A g p).Nonempty) :
    leastFeaturePoint A f p hf = leastFeaturePoint A g p hg := by
  have hsets := featurePoints_eq_necSuf A f g p hfg
  have hr : leastFeaturePoint A f p hf ∈ featurePoints A g p := by
    have hiff : leastFeaturePoint A f p hf ∈ featurePoints A g p ↔
        leastFeaturePoint A f p hf ∈ featurePoints A f p := by rw [hsets]
    exact hiff.mpr (Finset.min'_mem _ _)
  have hs : leastFeaturePoint A g p hg ∈ featurePoints A f p := by
    have hiff : leastFeaturePoint A g p hg ∈ featurePoints A f p ↔
        leastFeaturePoint A g p hg ∈ featurePoints A g p := by rw [hsets]
    exact hiff.mpr (Finset.min'_mem _ _)
  have hle : leastFeaturePoint A g p hg ≤ leastFeaturePoint A f p hf :=
    Finset.min'_le _ _ hr
  have hge : leastFeaturePoint A f p hf ≤ leastFeaturePoint A g p hg :=
    Finset.min'_le _ _ hs
  calc
    leastFeaturePoint A f p hf = leastFeaturePoint A g p hg := le_antisymm hge hle

theorem selectedFeatureValue_eq_necSuf (A : Finset J) (f g : J → B) (p : B → Prop)
    (v w : J → V) (hfg : ∀ j ∈ A, f j = g j) (hvw : ∀ j ∈ A, v j = w j)
    (hf : (featurePoints A f p).Nonempty) (hg : (featurePoints A g p).Nonempty) :
    selectedFeatureValue A f p v hf = selectedFeatureValue A g p w hg := by
  classical
  have hm : leastFeaturePoint A f p hf ∈ A :=
    (Finset.mem_filter.mp (Finset.min'_mem (featurePoints A f p) hf)).1
  calc
    selectedFeatureValue A f p v hf = v (leastFeaturePoint A f p hf) := rfl
    _ = w (leastFeaturePoint A f p hf) := hvw _ hm
    _ = w (leastFeaturePoint A g p hg) :=
      congrArg w (leastFeaturePoint_eq_necSuf A f g p hfg hf hg)
    _ = selectedFeatureValue A g p w hg := rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
