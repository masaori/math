/-
章「反復モノイドの主イデアル同値と有限鎖」の具体版。
人手証明の正本は structured-latex/content/iterate-monoid-tail-equivalence.ts。

有限舞台上の二値 CA の反復モノイドについて、生成主イデアル、その等号による
同値関係、任意の二つの生成主イデアルの比較可能性、有限代表と合成表による
有限列挙を、人手証明と同じ順序で形式化する。有限集合と自然数だけを使い、
既存半群論の分類定理、無限極限、R / C は使わない。
-/
import CellularAutomata.IterateMonoidPrincipalIdealTail

namespace CellularAutomata.IterateMonoidPrincipalIdealChain

open CellularAutomata.EssentialDependency
open CellularAutomata.TimeExpansionDependency
open CellularAutomata.IterateMonoid
open CellularAutomata.IterateMonoidPrincipalIdealTail

variable {V : Type} [Fintype V] [DecidableEq V]
variable (N : V → Finset V)
variable (f : (v : V) → (↥(N v) → State) → State)

/-- 反復写像 G が生成する主イデアル J_F(G)
    （`def_iterate_monoid_generated_ideal`）。 -/
def generatedIdeal (G : (V → State) → (V → State)) :
    Set ((V → State) → (V → State)) :=
  {K | ∃ H, H ∈ powerSet N f ∧ G ∘ H = K}

omit [Fintype V] [DecidableEq V] in
/-- J_F(F^n)=I_n(F)。 -/
theorem generatedIdeal_iterateMap_eq_tail (n : ℕ) :
    generatedIdeal N f (iterateMap N f n) = tail N f n := by
  rw [tail_eq_principal_ideal]
  rfl

/-- 主イデアル同値（`def_iterate_monoid_principal_ideal_equivalence`）。 -/
def PrincipalIdealEquivalent
    (G H : (V → State) → (V → State)) : Prop :=
  generatedIdeal N f G = generatedIdeal N f H

omit [Fintype V] [DecidableEq V] in
/-- 主イデアル同値は反射的である。 -/
theorem principalIdealEquivalent_refl
    {G : (V → State) → (V → State)} : PrincipalIdealEquivalent N f G G := rfl

omit [Fintype V] [DecidableEq V] in
/-- 主イデアル同値は対称的である。 -/
theorem principalIdealEquivalent_symm
    {G H : (V → State) → (V → State)}
    (h : PrincipalIdealEquivalent N f G H) : PrincipalIdealEquivalent N f H G := h.symm

omit [Fintype V] [DecidableEq V] in
/-- 主イデアル同値は推移的である。 -/
theorem principalIdealEquivalent_trans
    {G H K : (V → State) → (V → State)}
    (hGH : PrincipalIdealEquivalent N f G H)
    (hHK : PrincipalIdealEquivalent N f H K) : PrincipalIdealEquivalent N f G K :=
  hGH.trans hHK

omit [Fintype V] [DecidableEq V] in
/-- 主イデアル同値は P_F 上の同値関係である
    （`claim_iterate_monoid_principal_ideal_equivalence_relation`）。 -/
theorem principalIdealEquivalent_equivalence_relation :
    Equivalence (PrincipalIdealEquivalent N f) := by
  constructor
  · intro G
    rfl
  · intro G H h
    exact h.symm
  · intro G H K hGH hHK
    exact hGH.trans hHK

omit [Fintype V] [DecidableEq V] in
/-- m≤n なら J_F(F^n)⊆J_F(F^m)。人手証明どおり n=m+d と書く。 -/
theorem generatedIdeal_antitone {m n : ℕ} (hmn : m ≤ n) :
    generatedIdeal N f (iterateMap N f n) ⊆ generatedIdeal N f (iterateMap N f m) := by
  obtain ⟨d, rfl⟩ := Nat.exists_eq_add_of_le hmn
  rintro K ⟨H, hH, rfl⟩
  refine ⟨iterateMap N f d ∘ H, comp_mem_powerSet N f ⟨d, rfl⟩ hH, ?_⟩
  rcases hH with ⟨k, rfl⟩
  rw [iterateMap_comp_add, iterateMap_comp_add, iterateMap_comp_add]
  congr 1
  omega

omit [Fintype V] [DecidableEq V] in
/-- P_F の任意の二元が生成する主イデアルは包含で比較できる
    （`claim_iterate_monoid_generated_ideals_comparable`）。 -/
theorem generatedIdeals_comparable
    {G H : (V → State) → (V → State)}
    (hG : G ∈ powerSet N f) (hH : H ∈ powerSet N f) :
    generatedIdeal N f G ⊆ generatedIdeal N f H ∨
      generatedIdeal N f H ⊆ generatedIdeal N f G := by
  rcases hG with ⟨m, rfl⟩
  rcases hH with ⟨n, rfl⟩
  rcases le_total m n with hmn | hnm
  · exact Or.inr (generatedIdeal_antitone N f hmn)
  · exact Or.inl (generatedIdeal_antitone N f hnm)

/-- 有限代表集合の中で G が生成する主イデアル。 -/
def finiteGeneratedIdeal (j : ℕ)
    (G : (V → State) → (V → State)) :
    Finset ((V → State) → (V → State)) :=
  (representatives N f j).image (fun H => G ∘ H)

/-- 有限代表から列挙した生成主イデアル全体。 -/
def finiteGeneratedIdealChain (j : ℕ) :
    Finset (Finset ((V → State) → (V → State))) :=
  (representatives N f j).image (finiteGeneratedIdeal N f j)

/-- 衝突があれば、有限生成主イデアルの所属は J_F(G) の所属と一致する。 -/
theorem mem_finiteGeneratedIdeal_iff {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j)
    (G K : (V → State) → (V → State)) :
    K ∈ finiteGeneratedIdeal N f j G ↔ K ∈ generatedIdeal N f G := by
  constructor
  · intro hK
    rcases Finset.mem_image.mp hK with ⟨H, hH, rfl⟩
    exact ⟨H, (mem_representatives_iff_powerSet N f hij h H).mp hH, rfl⟩
  · rintro ⟨H, hH, rfl⟩
    exact Finset.mem_image.mpr
      ⟨H, (mem_representatives_iff_powerSet N f hij h H).mpr hH, rfl⟩

/-- P_F の各元が生成する主イデアルは、有限列挙に現れる。 -/
theorem finiteGeneratedIdeal_mem_chain {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j)
    {G : (V → State) → (V → State)} (hG : G ∈ powerSet N f) :
    finiteGeneratedIdeal N f j G ∈ finiteGeneratedIdealChain N f j := by
  exact Finset.mem_image.mpr
    ⟨G, (mem_representatives_iff_powerSet N f hij h G).mpr hG, rfl⟩

/-- 有限列挙した主イデアルの等号は、主イデアル同値と同値である。 -/
theorem finiteGeneratedIdeal_eq_iff_equivalent {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j)
    (G H : (V → State) → (V → State)) :
    finiteGeneratedIdeal N f j G = finiteGeneratedIdeal N f j H ↔
      PrincipalIdealEquivalent N f G H := by
  rw [PrincipalIdealEquivalent]
  constructor
  · intro heq
    ext K
    rw [← mem_finiteGeneratedIdeal_iff N f hij h G K,
      ← mem_finiteGeneratedIdeal_iff N f hij h H K, heq]
  · intro heq
    ext K
    rw [mem_finiteGeneratedIdeal_iff N f hij h G K,
      mem_finiteGeneratedIdeal_iff N f hij h H K, heq]

/-- 有限代表から列挙した任意の二つの生成主イデアルは包含で比較できる。 -/
theorem finiteGeneratedIdealChain_comparable {i j : ℕ} (hij : i < j)
    (h : iterateMap N f i = iterateMap N f j)
    {I J : Finset ((V → State) → (V → State))}
    (hI : I ∈ finiteGeneratedIdealChain N f j)
    (hJ : J ∈ finiteGeneratedIdealChain N f j) : I ⊆ J ∨ J ⊆ I := by
  rcases Finset.mem_image.mp hI with ⟨G, hG, rfl⟩
  rcases Finset.mem_image.mp hJ with ⟨H, hH, rfl⟩
  have hGP := (mem_representatives_iff_powerSet N f hij h G).mp hG
  have hHP := (mem_representatives_iff_powerSet N f hij h H).mp hH
  rcases generatedIdeals_comparable N f hGP hHP with hsub | hsub
  · exact Or.inl (fun K hK => (mem_finiteGeneratedIdeal_iff N f hij h H K).mpr
      (hsub ((mem_finiteGeneratedIdeal_iff N f hij h G K).mp hK)))
  · exact Or.inr (fun K hK => (mem_finiteGeneratedIdeal_iff N f hij h G K).mpr
      (hsub ((mem_finiteGeneratedIdeal_iff N f hij h H K).mp hK)))

/-- 反復写像の衝突を一つ選べば、生成主イデアル全体と包含関係を有限集合として列挙でき、
    主イデアル同値は有限主イデアルの等号として決定できる
    （`claim_iterate_monoid_generated_ideal_finite_chain_decidable`）。 -/
theorem generatedIdeal_finite_chain_decidable :
    ∃ i j : ℕ, i < j ∧ iterateMap N f i = iterateMap N f j ∧
      (∀ G ∈ powerSet N f,
        finiteGeneratedIdeal N f j G ∈ finiteGeneratedIdealChain N f j) ∧
      (∀ G H, finiteGeneratedIdeal N f j G = finiteGeneratedIdeal N f j H ↔
        PrincipalIdealEquivalent N f G H) ∧
      (∀ I ∈ finiteGeneratedIdealChain N f j,
        ∀ J ∈ finiteGeneratedIdealChain N f j, I ⊆ J ∨ J ⊆ I) := by
  obtain ⟨i, j, hij, _hj, h⟩ := iterateMap_collision N f
  exact ⟨i, j, hij, h,
    fun _ hG => finiteGeneratedIdeal_mem_chain N f hij h hG,
    fun G H => finiteGeneratedIdeal_eq_iff_equivalent N f hij h G H,
    fun _ hI _ hJ =>
    finiteGeneratedIdealChain_comparable N f hij h hI hJ⟩

end CellularAutomata.IterateMonoidPrincipalIdealChain
