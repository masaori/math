/-
章「反復モノイドの主イデアル同値と有限鎖」の必要十分版。

具体版と同じ手順（生成主イデアル、集合の等号による同値律、反復指数の
全順序による包含比較、衝突指数未満の有限代表からの列挙）を保ち、実際に
使う構造だけを残す。

* 生成主イデアル、同値律、包含比較には型 X と自己写像 F : X → X だけを使う。
* 有限列挙には X の有限性と等号判定が要る。有限性は反復の衝突を得るため、
  等号判定は写像の有限代表・像・有限部分集合の等号判定を作るために使う。
* 二値状態、セル、近傍、局所規則は現れない。

R / C は使わない。
-/
import CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail

namespace CellularAutomata.NecSuf.IterateMonoidPrincipalIdealChain

open CellularAutomata.NecSuf.IterateMonoid
open CellularAutomata.NecSuf.IterateMonoidPrincipalIdealTail

variable {X : Type}

/-- 反復写像 G が生成する主イデアル J_F(G)。 -/
def generatedIdeal (F : X → X) (G : X → X) : Set (X → X) :=
  {K | ∃ H, H ∈ powerSet F ∧ G ∘ H = K}

/-- J_F(F^n)=I_n(F)。 -/
theorem generatedIdeal_iterateMap_eq_tail (F : X → X) (n : ℕ) :
    generatedIdeal F (iterateMap F n) = tail F n := by
  rw [tail_eq_principal_ideal]
  rfl

/-- 主イデアル同値。 -/
def PrincipalIdealEquivalent (F : X → X) (G H : X → X) : Prop :=
  generatedIdeal F G = generatedIdeal F H

theorem principalIdealEquivalent_refl (F : X → X) {G : X → X} :
    PrincipalIdealEquivalent F G G := rfl

theorem principalIdealEquivalent_symm (F : X → X) {G H : X → X}
    (h : PrincipalIdealEquivalent F G H) : PrincipalIdealEquivalent F H G := h.symm

theorem principalIdealEquivalent_trans (F : X → X) {G H K : X → X}
    (hGH : PrincipalIdealEquivalent F G H) (hHK : PrincipalIdealEquivalent F H K) :
    PrincipalIdealEquivalent F G K := hGH.trans hHK

/-- 主イデアル同値は同値関係である。集合の等号の三法則だけを使う。 -/
theorem principalIdealEquivalent_equivalence_relation (F : X → X) :
    Equivalence (PrincipalIdealEquivalent F) := by
  constructor
  · intro G
    rfl
  · intro G H h
    exact h.symm
  · intro G H K hGH hHK
    exact hGH.trans hHK

/-- m≤n なら J_F(F^n)⊆J_F(F^m)。具体版と同じく n=m+d と書く。 -/
theorem generatedIdeal_antitone (F : X → X) {m n : ℕ} (hmn : m ≤ n) :
    generatedIdeal F (iterateMap F n) ⊆ generatedIdeal F (iterateMap F m) := by
  obtain ⟨d, rfl⟩ := Nat.exists_eq_add_of_le hmn
  rintro K ⟨H, hH, rfl⟩
  refine ⟨iterateMap F d ∘ H, comp_mem_powerSet F ⟨d, rfl⟩ hH, ?_⟩
  rcases hH with ⟨k, rfl⟩
  rw [iterateMap_comp_add, iterateMap_comp_add, iterateMap_comp_add]
  congr 1
  omega

/-- P_F の任意の二元が生成する主イデアルは包含で比較できる。 -/
theorem generatedIdeals_comparable (F : X → X) {G H : X → X}
    (hG : G ∈ powerSet F) (hH : H ∈ powerSet F) :
    generatedIdeal F G ⊆ generatedIdeal F H ∨ generatedIdeal F H ⊆ generatedIdeal F G := by
  rcases hG with ⟨m, rfl⟩
  rcases hH with ⟨n, rfl⟩
  rcases le_total m n with hmn | hnm
  · exact Or.inr (generatedIdeal_antitone F hmn)
  · exact Or.inl (generatedIdeal_antitone F hnm)

/-! ### 有限列挙。写像および有限部分集合の等号判定が要る -/

def finiteGeneratedIdeal [DecidableEq (X → X)] (F : X → X) (j : ℕ) (G : X → X) :
    Finset (X → X) :=
  (representatives F j).image (fun H ↦ G ∘ H)

def finiteGeneratedIdealChain [DecidableEq (X → X)] (F : X → X) (j : ℕ) :
    Finset (Finset (X → X)) :=
  (representatives F j).image (finiteGeneratedIdeal F j)

theorem mem_finiteGeneratedIdeal_iff [DecidableEq (X → X)] (F : X → X)
    {i j : ℕ} (hij : i < j) (h : iterateMap F i = iterateMap F j) (G K : X → X) :
    K ∈ finiteGeneratedIdeal F j G ↔ K ∈ generatedIdeal F G := by
  constructor
  · intro hK
    rcases Finset.mem_image.mp hK with ⟨H, hH, rfl⟩
    exact ⟨H, (mem_representatives_iff_powerSet F hij h H).mp hH, rfl⟩
  · rintro ⟨H, hH, rfl⟩
    exact Finset.mem_image.mpr ⟨H, (mem_representatives_iff_powerSet F hij h H).mpr hH, rfl⟩

theorem finiteGeneratedIdeal_mem_chain [DecidableEq (X → X)] (F : X → X)
    {i j : ℕ} (hij : i < j) (h : iterateMap F i = iterateMap F j)
    {G : X → X} (hG : G ∈ powerSet F) :
    finiteGeneratedIdeal F j G ∈ finiteGeneratedIdealChain F j := by
  exact Finset.mem_image.mpr
    ⟨G, (mem_representatives_iff_powerSet F hij h G).mpr hG, rfl⟩

theorem finiteGeneratedIdeal_eq_iff_equivalent [DecidableEq (X → X)] (F : X → X)
    {i j : ℕ} (hij : i < j) (h : iterateMap F i = iterateMap F j) (G H : X → X) :
    finiteGeneratedIdeal F j G = finiteGeneratedIdeal F j H ↔ PrincipalIdealEquivalent F G H := by
  rw [PrincipalIdealEquivalent]
  constructor
  · intro heq
    ext K
    rw [← mem_finiteGeneratedIdeal_iff F hij h G K,
      ← mem_finiteGeneratedIdeal_iff F hij h H K, heq]
  · intro heq
    ext K
    rw [mem_finiteGeneratedIdeal_iff F hij h G K,
      mem_finiteGeneratedIdeal_iff F hij h H K, heq]

theorem finiteGeneratedIdealChain_comparable [DecidableEq (X → X)] (F : X → X)
    {i j : ℕ} (hij : i < j) (h : iterateMap F i = iterateMap F j)
    {I J : Finset (X → X)} (hI : I ∈ finiteGeneratedIdealChain F j)
    (hJ : J ∈ finiteGeneratedIdealChain F j) : I ⊆ J ∨ J ⊆ I := by
  rcases Finset.mem_image.mp hI with ⟨G, hG, rfl⟩
  rcases Finset.mem_image.mp hJ with ⟨H, hH, rfl⟩
  have hGP := (mem_representatives_iff_powerSet F hij h G).mp hG
  have hHP := (mem_representatives_iff_powerSet F hij h H).mp hH
  rcases generatedIdeals_comparable F hGP hHP with hsub | hsub
  · exact Or.inl (fun K hK ↦ (mem_finiteGeneratedIdeal_iff F hij h H K).mpr
      (hsub ((mem_finiteGeneratedIdeal_iff F hij h G K).mp hK)))
  · exact Or.inr (fun K hK ↦ (mem_finiteGeneratedIdeal_iff F hij h G K).mpr
      (hsub ((mem_finiteGeneratedIdeal_iff F hij h H K).mp hK)))

/-- 有限型上では衝突を一つ選び、有限代表と合成表から有限鎖を列挙できる。 -/
theorem generatedIdeal_finite_chain_decidable [Fintype X] [DecidableEq X] (F : X → X) :
    ∃ i j : ℕ, i < j ∧ iterateMap F i = iterateMap F j ∧
      (∀ G ∈ powerSet F, finiteGeneratedIdeal F j G ∈ finiteGeneratedIdealChain F j) ∧
      (∀ G H, finiteGeneratedIdeal F j G = finiteGeneratedIdeal F j H ↔
        PrincipalIdealEquivalent F G H) ∧
      (∀ I ∈ finiteGeneratedIdealChain F j,
        ∀ J ∈ finiteGeneratedIdealChain F j, I ⊆ J ∨ J ⊆ I) := by
  obtain ⟨i, j, hij, _hj, h⟩ := iterateMap_collision F
  exact ⟨i, j, hij, h,
    fun _ hG ↦ finiteGeneratedIdeal_mem_chain F hij h hG,
    fun G H ↦ finiteGeneratedIdeal_eq_iff_equivalent F hij h G H,
    fun _ hI _ hJ ↦ finiteGeneratedIdealChain_comparable F hij h hI hJ⟩

end CellularAutomata.NecSuf.IterateMonoidPrincipalIdealChain
