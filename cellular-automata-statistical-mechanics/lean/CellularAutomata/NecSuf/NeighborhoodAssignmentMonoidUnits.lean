/-
章「有限近傍割り当てモノイドの可逆元」の必要十分版。

具体版（CellularAutomata.NeighborhoodAssignmentMonoidUnits）と同じ順序で、
左右逆元から各近傍が一元集合であること、その唯一元が定める自己写像の単射性、
役割交換で得る右逆写像による全射性、近傍割り当てと置換の対応、逆置換による逆向き、
単位律と結合律による逆元の一意性、置換との一対一対応による個数を示す。

必要な構造の検査結果:
  - **等号判定は落とせる。** 値を `Set` で表せば、一元性・置換との対応・逆向き・
    逆元の一意性はいずれも型に等号判定を要求せずに成り立つ
    （`setIsInvertible_iff_exists_permutation`, `setInverse_unique`）。
    具体版の `DecidableEq V` は、近傍を `Finset` で表して `Finset.biUnion` で合成する
    ための要求であって、主張そのものの要求ではない。
  - **舞台の有限性は落とせる。** 人手証明が全射性を役割交換の右逆写像で出すように
    差し替わったため、可逆元が置換に対応することの特徴づけ
    （`setIsInvertible_iff_exists_permutation`）は舞台の有限性を一切使わない。
    以前の版が置いていた `Finite V`（`Finite.injective_iff_surjective` のための仮定）は
    削除した。有限表現の可逆性との同値（`isInvertible_iff_setIsInvertible`）も
    有限性を使わない。
  - **`Fintype V` が要るのは個数の段だけである。** 可逆元を置換の像として並べる
    有限表 `unitTable` と個数公式 `card_unitTable_of_necSuf` は、元の全列挙を使うため
    `Fintype V` を落とせない。ここが有限性を実際に使う唯一の段である。
  - **具体版の `Fintype V` は主張の要求ではない。** 具体版はファイル全体で
    `Fintype V` を仮定しているが、必要十分版の検査により、それが必要なのは
    可逆元の有限表と個数の段だけだと分かる。
  - **始域と終域が同じ型であることは落とせない。** 可逆性の定義が `N ⋆ M` と `M ⋆ N` を
    同じ自己近傍割り当てと比較するため、型をまたぐ合成では可逆性そのものが書けない。
  - **舞台が空でも成り立つ。** 空舞台では可逆元は一つ（空写像）であり、個数 `0! = 1` と合う。
  - 状態集合、局所規則、時間、順序、演算、ℝ / ℂ はいずれも使わない。
-/
import CellularAutomata.NeighborhoodAssignmentMonoidUnits
import CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid

namespace CellularAutomata.NecSuf.NeighborhoodAssignmentMonoidUnits

open CellularAutomata.NecSuf.FiniteNeighborhoodAssignmentMonoid
  (setComp setIdentity setComp_assoc setComp_setIdentity setIdentity_setComp)

/-! ### 可逆性と置換（インスタンスを一つも要らない段） -/

/-- `def_invertible_neighborhood_assignment` の `Set` 版。等号判定を要求しない。 -/
def SetIsInvertible {V : Type} (N : V → Set V) : Prop :=
  ∃ M : V → Set V, setComp N M = setIdentity V ∧ setComp M N = setIdentity V

/-- `def_permutation_neighborhood_assignment` の `Set` 版。 -/
def setPermutationNeighborhood {V : Type} (σ : Equiv.Perm V) : V → Set V :=
  fun v => {σ v}

/-- 人手証明の前半。左右逆元を持つ N の各値は一元集合である。
    等号判定も有限性も使わない。 -/
theorem set_value_is_singleton_of_inverse {V : Type} {N M : V → Set V}
    (hNM : setComp N M = setIdentity V) (hMN : setComp M N = setIdentity V) (v : V) :
    ∃! u : V, u ∈ N v := by
  have hcompNM : setComp N M v = {v} := congrFun hNM v
  have hvmem : v ∈ setComp N M v := by rw [hcompNM]; rfl
  obtain ⟨u, huN, -⟩ := hvmem
  have hMu_sub : M u ⊆ {v} := by
    intro w hw
    have hwmem : w ∈ setComp N M v := ⟨u, huN, hw⟩
    rw [hcompNM] at hwmem
    exact hwmem
  have hcompMN : setComp M N u = {u} := congrFun hMN u
  have humem : u ∈ setComp M N u := by rw [hcompMN]; rfl
  obtain ⟨x, hxM, -⟩ := humem
  have hxv : x = v := hMu_sub hxM
  have hMu_eq : M u = {v} := by
    apply Set.Subset.antisymm hMu_sub
    intro w hw
    have hwv : w = v := hw
    rw [hwv, ← hxv]
    exact hxM
  have hexpand : setComp M N u = N v := by
    ext w
    constructor
    · rintro ⟨y, hy, hw⟩
      rw [hMu_eq] at hy
      have hyv : y = v := hy
      rwa [hyv] at hw
    · intro hw
      exact ⟨v, by rw [hMu_eq]; rfl, hw⟩
  have hNv_eq : N v = {u} := hexpand.symm.trans hcompMN
  refine ⟨u, by rw [hNv_eq]; rfl, ?_⟩
  intro w hw
  rw [hNv_eq] at hw
  exact hw

/-- 可逆な N の一元値から得る自己写像。 -/
noncomputable def setPermutationFunction {V : Type} {N M : V → Set V}
    (hNM : setComp N M = setIdentity V) (hMN : setComp M N = setIdentity V) : V → V :=
  fun v => (set_value_is_singleton_of_inverse hNM hMN v).choose

theorem set_value_eq_singleton {V : Type} {N M : V → Set V}
    (hNM : setComp N M = setIdentity V) (hMN : setComp M N = setIdentity V) (v : V) :
    N v = {setPermutationFunction hNM hMN v} := by
  have h := (set_value_is_singleton_of_inverse hNM hMN v).choose_spec
  ext u
  constructor
  · intro hu
    exact h.2 u hu
  · intro hu
    have huv : u = setPermutationFunction hNM hMN v := hu
    rw [huv]
    exact h.1

/-- 人手証明の単射性の段。有限性は使わない。 -/
theorem setPermutationFunction_injective {V : Type} {N M : V → Set V}
    (hNM : setComp N M = setIdentity V) (hMN : setComp M N = setIdentity V) :
    Function.Injective (setPermutationFunction hNM hMN) := by
  have key : ∀ v : V, M (setPermutationFunction hNM hMN v) = {v} := by
    intro v
    have hcompNM : setComp N M v = {v} := congrFun hNM v
    have hexpand : setComp N M v = M (setPermutationFunction hNM hMN v) := by
      ext w
      constructor
      · rintro ⟨y, hy, hw⟩
        rw [set_value_eq_singleton hNM hMN] at hy
        have hyv : y = setPermutationFunction hNM hMN v := hy
        rwa [hyv] at hw
      · intro hw
        exact ⟨setPermutationFunction hNM hMN v, by rw [set_value_eq_singleton hNM hMN]; rfl, hw⟩
    exact hexpand.symm.trans hcompNM
  intro v v' hv
  have h1 : M (setPermutationFunction hNM hMN v) = {v} := key v
  have h2 : M (setPermutationFunction hNM hMN v') = {v'} := key v'
  rw [hv, h2] at h1
  exact (Set.singleton_eq_singleton_iff.mp h1.symm)

/-- 人手証明の全射性の段。`N` と `M` の役割を入れ替えて一元性の補題を適用し、
    得られた `τ(u)` を右逆像に取る。舞台の有限性を使わない。 -/
theorem setPermutationFunction_surjective_by_role_swap {V : Type} {N M : V → Set V}
    (hNM : setComp N M = setIdentity V) (hMN : setComp M N = setIdentity V) :
    Function.Surjective (setPermutationFunction hNM hMN) := by
  intro u
  refine ⟨setPermutationFunction hMN hNM u, ?_⟩
  have hcompMN : setComp M N u = {u} := congrFun hMN u
  have hexpand : setComp M N u = N (setPermutationFunction hMN hNM u) := by
    ext w
    constructor
    · rintro ⟨y, hy, hw⟩
      rw [set_value_eq_singleton hMN hNM] at hy
      have hyu : y = setPermutationFunction hMN hNM u := hy
      rwa [hyu] at hw
    · intro hw
      exact ⟨setPermutationFunction hMN hNM u,
        by rw [set_value_eq_singleton hMN hNM]; rfl, hw⟩
  have hNτ : N (setPermutationFunction hMN hNM u) = {u} := hexpand.symm.trans hcompMN
  have hNσ : N (setPermutationFunction hMN hNM u) =
      {setPermutationFunction hNM hMN (setPermutationFunction hMN hNM u)} :=
    set_value_eq_singleton hNM hMN _
  exact Set.singleton_eq_singleton_iff.mp (hNσ.symm.trans hNτ)

/-- 人手証明で構成した置換。単射性も全射性も舞台の有限性を使わない。 -/
noncomputable def setPermutationOfInverse {V : Type} {N M : V → Set V}
    (hNM : setComp N M = setIdentity V) (hMN : setComp M N = setIdentity V) : Equiv.Perm V :=
  Equiv.ofBijective (setPermutationFunction hNM hMN)
    ⟨setPermutationFunction_injective hNM hMN,
      setPermutationFunction_surjective_by_role_swap hNM hMN⟩

theorem set_eq_setPermutationNeighborhood {V : Type} {N M : V → Set V}
    (hNM : setComp N M = setIdentity V) (hMN : setComp M N = setIdentity V) :
    N = setPermutationNeighborhood (setPermutationOfInverse hNM hMN) := by
  funext v
  rw [set_value_eq_singleton hNM hMN]
  rfl

/-- 人手証明の逆向き。逆置換が左右の逆元を与える。有限性も等号判定も使わない。 -/
theorem setPermutationNeighborhood_inverse_laws {V : Type} (σ : Equiv.Perm V) :
    setComp (setPermutationNeighborhood σ) (setPermutationNeighborhood σ⁻¹) = setIdentity V ∧
      setComp (setPermutationNeighborhood σ⁻¹) (setPermutationNeighborhood σ) =
        setIdentity V := by
  constructor <;> funext v <;> ext w <;> constructor
  · rintro ⟨u, hu, hw⟩
    have hu' : u = σ v := hu
    have hw' : w = σ⁻¹ u := hw
    rw [hw', hu']
    show σ⁻¹ (σ v) = v
    simp
  · intro hw
    have hw' : w = v := hw
    refine ⟨σ v, rfl, ?_⟩
    show w = σ⁻¹ (σ v)
    rw [hw']
    simp
  · rintro ⟨u, hu, hw⟩
    have hu' : u = σ⁻¹ v := hu
    have hw' : w = σ u := hw
    rw [hw', hu']
    show σ (σ⁻¹ v) = v
    simp
  · intro hw
    have hw' : w = v := hw
    refine ⟨σ⁻¹ v, rfl, ?_⟩
    show w = σ (σ⁻¹ v)
    rw [hw']
    simp

/-- `claim_invertible_neighborhood_assignments_are_permutations` の必要十分版。
    等号判定も舞台の有限性も使わない。 -/
theorem setIsInvertible_iff_exists_permutation {V : Type} (N : V → Set V) :
    SetIsInvertible N ↔ ∃! σ : Equiv.Perm V, N = setPermutationNeighborhood σ := by
  constructor
  · rintro ⟨M, hNM, hMN⟩
    refine ⟨setPermutationOfInverse hNM hMN, set_eq_setPermutationNeighborhood hNM hMN, ?_⟩
    intro τ hNτ
    apply Equiv.ext
    intro v
    have hσ := congrFun (set_eq_setPermutationNeighborhood hNM hMN) v
    have hτ := congrFun hNτ v
    have h : ({τ v} : Set V) = {setPermutationOfInverse hNM hMN v} := hτ.symm.trans hσ
    exact Set.singleton_eq_singleton_iff.mp h
  · rintro ⟨σ, hN, -⟩
    subst hN
    exact ⟨setPermutationNeighborhood σ⁻¹, setPermutationNeighborhood_inverse_laws σ⟩

/-- `claim_invertible_neighborhood_assignment_inverse_unique` の必要十分版。
    単位律と結合律だけを使い、有限性も等号判定も使わない。 -/
theorem setInverse_unique {V : Type} {N M M' : V → Set V}
    (hM : setComp N M = setIdentity V ∧ setComp M N = setIdentity V)
    (hM' : setComp N M' = setIdentity V ∧ setComp M' N = setIdentity V) : M = M' := by
  calc
    M = setComp M (setIdentity V) := (setComp_setIdentity M).symm
    _ = setComp M (setComp N M') := by rw [hM'.1]
    _ = setComp (setComp M N) M' := (setComp_assoc M N M').symm
    _ = setComp (setIdentity V) M' := by rw [hM.2]
    _ = M' := setIdentity_setComp M'

/-- 置換から `Set` 版の一元近傍割り当てを作る対応は単射である。有限性を使わない。 -/
theorem setPermutationNeighborhood_injective {V : Type} :
    Function.Injective (setPermutationNeighborhood : Equiv.Perm V → V → Set V) := by
  intro σ τ h
  apply Equiv.ext
  intro v
  have hv : ({σ v} : Set V) = {τ v} := congrFun h v
  exact Set.singleton_eq_singleton_iff.mp hv

/-! ### 有限表現との橋渡し（等号判定が要る段）

近傍を `Finset` で表すと、合成 `composedNeighborhood` を `Finset.biUnion` で書くために
終域の等号判定が要る。可逆性の主張そのものではなく表現の要求であることを示す。 -/

section FinsetStage

open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.NeighborhoodAssignmentMonoidUnits

variable {V : Type} [DecidableEq V]

/-- 有限表現の割り当てを集合として読む写像。 -/
def coeAssign (N : NeighborhoodAssignment V) : V → Set V :=
  fun v => ((N v : Finset V) : Set V)

theorem coeAssign_injective : Function.Injective (coeAssign (V := V)) := by
  intro N M h
  funext v
  exact Finset.coe_injective (congrFun h v)

theorem coeAssign_composed (N M : NeighborhoodAssignment V) :
    coeAssign (composedNeighborhood N M) = setComp (coeAssign N) (coeAssign M) := by
  funext v
  ext w
  simp [coeAssign, composedNeighborhood, setComp]

theorem coeAssign_identity : coeAssign (identityNeighborhood V) = setIdentity V := by
  funext v
  ext w
  simp [coeAssign, identityNeighborhood, setIdentity]

theorem coeAssign_permutationNeighborhood (σ : Equiv.Perm V) :
    coeAssign (permutationNeighborhood σ) = setPermutationNeighborhood σ := by
  funext v
  ext w
  simp [coeAssign, permutationNeighborhood, setPermutationNeighborhood]

/-- 有限表現の可逆性は、集合として読んだ割り当ての可逆性と同値である。 -/
theorem isInvertible_iff_setIsInvertible (N : NeighborhoodAssignment V) :
    IsInvertible N ↔ SetIsInvertible (coeAssign N) := by
  constructor
  · rintro ⟨M, hNM, hMN⟩
    refine ⟨coeAssign M, ?_, ?_⟩
    · rw [← coeAssign_composed, hNM, coeAssign_identity (V := V)]
    · rw [← coeAssign_composed, hMN, coeAssign_identity (V := V)]
  · intro h
    obtain ⟨σ, hσ, -⟩ := (setIsInvertible_iff_exists_permutation _).mp h
    have hN : N = permutationNeighborhood σ := by
      apply coeAssign_injective
      rw [hσ, coeAssign_permutationNeighborhood]
    subst hN
    refine ⟨permutationNeighborhood σ⁻¹, ?_, ?_⟩
    · apply coeAssign_injective
      rw [coeAssign_composed, coeAssign_permutationNeighborhood,
        coeAssign_permutationNeighborhood, coeAssign_identity (V := V),
        (setPermutationNeighborhood_inverse_laws σ).1]
    · apply coeAssign_injective
      rw [coeAssign_composed, coeAssign_permutationNeighborhood,
        coeAssign_permutationNeighborhood, coeAssign_identity (V := V),
        (setPermutationNeighborhood_inverse_laws σ).2]

end FinsetStage

/-! ### 具体版の導出

具体版の各主張は、必要十分版の対応する主張から有限表現への翻訳として得られる。 -/

section Derivation

open CellularAutomata.FiniteNeighborhoodAssignmentMonoid
open CellularAutomata.ComposedNeighborhoodClosure
open CellularAutomata.NeighborhoodAssignmentMonoidUnits

variable {V : Type} [Fintype V] [DecidableEq V]

/-- 有限表現の左逆元等式を、集合として読んだ割り当ての左逆元等式へ翻訳する。 -/
theorem coeAssign_inverse_law {N M : NeighborhoodAssignment V}
    (hNM : composedNeighborhood N M =
      CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V) :
    setComp (coeAssign N) (coeAssign M) = setIdentity V := by
  rw [← coeAssign_composed, hNM, coeAssign_identity (V := V)]

/-- 具体版が選んだ一元値の写像は、必要十分版が選んだものと一致する。
    どちらも同じ一元集合の唯一の元だからである。 -/
theorem permutationFunctionOfInverse_eq_setPermutationFunction
    {N M : NeighborhoodAssignment V}
    (hNM : composedNeighborhood N M =
      CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V)
    (hMN : composedNeighborhood M N =
      CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V) :
    permutationFunctionOfInverse hNM hMN =
      setPermutationFunction (coeAssign_inverse_law hNM) (coeAssign_inverse_law hMN) := by
  funext v
  have h1 : coeAssign N v = {permutationFunctionOfInverse hNM hMN v} := by
    show ((N v : Finset V) : Set V) = _
    rw [value_eq_permutationFunction_singleton hNM hMN]
    simp
  have h2 : coeAssign N v =
      {setPermutationFunction (coeAssign_inverse_law hNM) (coeAssign_inverse_law hMN) v} :=
    set_value_eq_singleton _ _ v
  exact Set.singleton_eq_singleton_iff.mp (h1.symm.trans h2)

/-- 具体版 `permutationFunction_surjective_by_role_swap` は、必要十分版の全射性の特殊化である。 -/
theorem permutationFunction_surjective_by_role_swap_of_necSuf
    {N M : NeighborhoodAssignment V}
    (hNM : composedNeighborhood N M =
      CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V)
    (hMN : composedNeighborhood M N =
      CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V) :
    Function.Surjective (permutationFunctionOfInverse hNM hMN) := by
  rw [permutationFunctionOfInverse_eq_setPermutationFunction hNM hMN]
  exact setPermutationFunction_surjective_by_role_swap _ _

/-- 具体版 `isInvertible_iff_exists_permutation` は、必要十分版の特徴づけの特殊化である。 -/
theorem isInvertible_iff_exists_permutation_of_necSuf (N : NeighborhoodAssignment V) :
    IsInvertible N ↔ ∃! σ : Equiv.Perm V, N = permutationNeighborhood σ := by
  rw [isInvertible_iff_setIsInvertible, setIsInvertible_iff_exists_permutation]
  constructor
  · rintro ⟨σ, hσ, huniq⟩
    refine ⟨σ, ?_, ?_⟩
    · apply coeAssign_injective
      rw [hσ, coeAssign_permutationNeighborhood]
    · intro τ hτ
      apply huniq
      rw [hτ, coeAssign_permutationNeighborhood]
  · rintro ⟨σ, hσ, huniq⟩
    refine ⟨σ, ?_, ?_⟩
    · rw [hσ, coeAssign_permutationNeighborhood]
    · intro τ hτ
      apply huniq
      apply coeAssign_injective
      rw [hτ, coeAssign_permutationNeighborhood]

/-- 具体版 `inverse_unique` は、必要十分版の逆元の一意性の特殊化である。 -/
theorem inverse_unique_of_necSuf {N M M' : NeighborhoodAssignment V}
    (hM : composedNeighborhood N M =
        CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V ∧
      composedNeighborhood M N =
        CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V)
    (hM' : composedNeighborhood N M' =
        CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V ∧
      composedNeighborhood M' N =
        CellularAutomata.FiniteNeighborhoodAssignmentMonoid.identityNeighborhood V) : M = M' := by
  apply coeAssign_injective
  refine setInverse_unique (N := coeAssign N) ⟨?_, ?_⟩ ⟨?_, ?_⟩
  · rw [← coeAssign_composed, hM.1, coeAssign_identity (V := V)]
  · rw [← coeAssign_composed, hM.2, coeAssign_identity (V := V)]
  · rw [← coeAssign_composed, hM'.1, coeAssign_identity (V := V)]
  · rw [← coeAssign_composed, hM'.2, coeAssign_identity (V := V)]

omit [Fintype V] in
/-- 具体版 `permutationNeighborhood_injective` は、必要十分版の単射性の特殊化である。 -/
theorem permutationNeighborhood_injective_of_necSuf :
    Function.Injective (permutationNeighborhood : Equiv.Perm V → NeighborhoodAssignment V) := by
  intro σ τ h
  apply setPermutationNeighborhood_injective (V := V)
  rw [← coeAssign_permutationNeighborhood, ← coeAssign_permutationNeighborhood, h]

/-- 具体版 `card_unitTable` の個数公式を、必要十分版の単射性から導く。 -/
theorem card_unitTable_of_necSuf :
    (unitTable (V := V)).card = (Fintype.card V).factorial := by
  classical
  rw [unitTable,
    Finset.card_image_of_injective _ (permutationNeighborhood_injective_of_necSuf (V := V)),
    Finset.card_univ, Fintype.card_perm]

end Derivation

end CellularAutomata.NecSuf.NeighborhoodAssignmentMonoidUnits
