/-
正本: content/finite-yang-baxter-decision.ts の必要十分版。

有限 braid 条件と非隣接 Yang--Baxter 条件の変換に要るのは、型上の二体写像と
成分交換だけである。有限全走査にだけ有限性と等号判定を要する。線形化の係数回収には
相異なる零と一、定数パラメータ族には任意のパラメータ型、スペクトル依存性の非一意性には
可換な係数積と、二点で値が分かれる一つの係数写像だけを要する。
複素数、連続性、位相、極限、微分、内積、完備性は一般定理には要らない。
-/
import CellularAutomata.FiniteYangBaxterBoundary

namespace CellularAutomata.NecSuf.FiniteYangBaxterBoundary

open CellularAutomata.FiniteYangBaxterBoundary

variable {X P K : Type*}

/-- braid 規約と、成分交換後の非隣接規約の同値は二体写像だけで成り立つ。 -/
theorem braid_iff_swapAfter_yangBaxter
    (U : PairMap X) :
    SatisfiesBraid U ↔ SatisfiesYangBaxter (swapAfter U) := by
  constructor
  · intro h
    funext t
    rcases t with ⟨x, y, z⟩
    have ht := congrFun h (x, y, z)
    simpa [SatisfiesBraid, SatisfiesYangBaxter, adjacent12, adjacent23,
      nonadjacent13, swapAfter, swap, Function.comp_def] using
      congrArg (fun t : X × X × X => (t.2.2, t.2.1, t.1)) ht.symm
  · intro h
    funext t
    rcases t with ⟨x, y, z⟩
    have ht := congrFun h (x, y, z)
    simpa [SatisfiesBraid, SatisfiesYangBaxter, adjacent12, adjacent23,
      nonadjacent13, swapAfter, swap, Function.comp_def] using
      congrArg (fun t : X × X × X => (t.2.2, t.2.1, t.1)) ht.symm

/-- 有限全走査に必要なのは、入力型の有限性と等号判定だけである。 -/
instance satisfiesBraid_decidable [Fintype X] [DecidableEq X]
    (U : PairMap X) : Decidable (SatisfiesBraid U) := by
  letI : Decidable (∀ t : X × X × X,
      (adjacent12 U ∘ adjacent23 U ∘ adjacent12 U) t =
        (adjacent23 U ∘ adjacent12 U ∘ adjacent23 U) t) :=
    Fintype.decidableForallFintype
  exact decidable_of_iff
    (∀ t : X × X × X,
      (adjacent12 U ∘ adjacent23 U ∘ adjacent12 U) t =
        (adjacent23 U ∘ adjacent12 U ∘ adjacent23 U) t)
    ⟨fun h => funext h, fun h t => congrFun h t⟩

/-- 写像表の一成分を、相異なる零と一を持つ任意の係数型へ埋め込む。 -/
def basisCoefficient [DecidableEq X] [Zero K] [One K]
    (U : PairMap X) (target source : X × X) : K :=
  if target = U source then 1 else 0

theorem basisCoefficient_eq_one_iff
    [DecidableEq X] [Zero K] [One K] [Nontrivial K]
    (U : PairMap X) (target source : X × X) :
    basisCoefficient U target source = 1 ↔ target = U source := by
  simp [basisCoefficient]

/-- 係数表を、任意のパラメータ型上の定数族として置く。 -/
def constantCoefficientFamily [DecidableEq X] [Zero K] [One K]
    (U : PairMap X) : P → P → X × X → X × X → K :=
  fun _ _ => basisCoefficient U

theorem constantCoefficientFamily_recovers
    [DecidableEq X] [Zero K] [One K] [Nontrivial K]
    (U : PairMap X) (p q : P) (source : X × X) :
    constantCoefficientFamily U p q (U source) source = 1 := by
  simp [constantCoefficientFamily, basisCoefficient]

/-- 任意のパラメータ型上の二体写像族に対する非隣接 Yang--Baxter 条件。 -/
def SatisfiesParameterizedYangBaxter
    (R : P → P → PairMap X) : Prop :=
  ∀ p₁ p₂ p₃,
    adjacent12 (R p₁ p₂) ∘ nonadjacent13 (R p₁ p₃) ∘
        adjacent23 (R p₂ p₃) =
      adjacent23 (R p₂ p₃) ∘ nonadjacent13 (R p₁ p₃) ∘
        adjacent12 (R p₁ p₂)

def constantConvertedFamily (U : PairMap X) : P → P → PairMap X :=
  fun _ _ => swapAfter U

/-- braid 解は、パラメータ型に構造を仮定せず定数族へ埋め込める。 -/
theorem braid_gives_constant_parameterized_yangBaxter
    (U : PairMap X) (hU : SatisfiesBraid U) :
    SatisfiesParameterizedYangBaxter (constantConvertedFamily (P := P) U) := by
  intro p₁ p₂ p₃
  exact (braid_iff_swapAfter_yangBaxter U).mp hU

abbrev ScalarFamily (P K : Type*) := P → P → K

def SatisfiesScalarYangBaxter [Mul K] (R : ScalarFamily P K) : Prop :=
  ∀ p₁ p₂ p₃,
    R p₁ p₂ * R p₁ p₃ * R p₂ p₃ =
      R p₂ p₃ * R p₁ p₃ * R p₁ p₂

def constantOneFamily [One K] : ScalarFamily P K := fun _ _ => 1

def firstParameterFamily (a : P → K) : ScalarFamily P K := fun p _ => a p

theorem constantOneFamily_satisfies [CommMonoid K] :
    SatisfiesScalarYangBaxter (constantOneFamily : ScalarFamily P K) := by
  intro p₁ p₂ p₃
  simp [constantOneFamily]

theorem firstParameterFamily_satisfies [CommMonoid K] (a : P → K) :
    SatisfiesScalarYangBaxter (firstParameterFamily a) := by
  intro p₁ p₂ p₃
  simp only [firstParameterFamily]
  ac_rfl

/--
同一点で一致して別の点で分かれる係数写像が一つあれば、同じ一点の有限解から
スペクトル依存性は決まらない。係数側には可換モノイド構造だけを使う。
-/
theorem scalar_spectral_dependence_not_determined
    [CommMonoid K] (a : P → K) (p₀ p₁ q : P)
    (ha₀ : a p₀ = 1) (ha₁ : a p₁ ≠ 1) :
    SatisfiesScalarYangBaxter (constantOneFamily : ScalarFamily P K) ∧
      SatisfiesScalarYangBaxter (firstParameterFamily a) ∧
      constantOneFamily p₀ q = firstParameterFamily a p₀ q ∧
      constantOneFamily p₁ q ≠ firstParameterFamily a p₁ q := by
  refine ⟨constantOneFamily_satisfies, firstParameterFamily_satisfies a, ?_, ?_⟩
  · simpa [constantOneFamily, firstParameterFamily] using ha₀.symm
  · simpa [constantOneFamily, firstParameterFamily, eq_comm] using ha₁

/-! ## 具体版の導出 -/

section Derivation

/-- 具体版の複素線形化は一般の零一係数表である。 -/
theorem basisCoefficient_eq_complexLinearization
    [DecidableEq X] (U : PairMap X) :
    basisCoefficient (K := ℂ) U = complexLinearization U := by
  rfl

theorem complexLinearization_eq_one_iff_of_necSuf
    [DecidableEq X] (U : PairMap X) (target source : X × X) :
    complexLinearization U target source = 1 ↔ target = U source := by
  simpa [basisCoefficient, complexLinearization] using
    basisCoefficient_eq_one_iff (K := ℂ) U target source

theorem constantComplexLinearization_recovers_of_necSuf
    [DecidableEq X] (U : PairMap X) (l m : ℂ) (source : X × X) :
    constantComplexLinearization U l m (U source) source = 1 := by
  simpa [constantCoefficientFamily, basisCoefficient,
    constantComplexLinearization, complexLinearization] using
    (constantCoefficientFamily_recovers (P := ℂ) (K := ℂ) U l m source)

theorem braid_iff_swapAfter_yangBaxter_of_necSuf (U : PairMap X) :
    SatisfiesBraid U ↔ SatisfiesYangBaxter (swapAfter U) :=
  braid_iff_swapAfter_yangBaxter U

instance satisfiesBraid_decidable_of_necSuf [Fintype X] [DecidableEq X]
    (U : PairMap X) : Decidable (SatisfiesBraid U) :=
  satisfiesBraid_decidable U

theorem braid_gives_constant_parameterized_yangBaxter_of_necSuf
    (U : PairMap X) (hU : SatisfiesBraid U) :
    CellularAutomata.FiniteYangBaxterBoundary.SatisfiesParameterizedYangBaxter
      (CellularAutomata.FiniteYangBaxterBoundary.constantConvertedFamily U) := by
  simpa [CellularAutomata.FiniteYangBaxterBoundary.SatisfiesParameterizedYangBaxter,
    CellularAutomata.FiniteYangBaxterBoundary.constantConvertedFamily,
    SatisfiesParameterizedYangBaxter, constantConvertedFamily] using
    (braid_gives_constant_parameterized_yangBaxter (P := ℂ) U hU)

theorem constantFamily_satisfies_of_necSuf :
    CellularAutomata.FiniteYangBaxterBoundary.SatisfiesScalarYangBaxter
      CellularAutomata.FiniteYangBaxterBoundary.constantFamily := by
  simpa [CellularAutomata.FiniteYangBaxterBoundary.SatisfiesScalarYangBaxter,
    CellularAutomata.FiniteYangBaxterBoundary.constantFamily] using
    (constantOneFamily_satisfies (P := ℂ) (K := ℂ))

theorem affineFirstFamily_satisfies_of_necSuf :
    CellularAutomata.FiniteYangBaxterBoundary.SatisfiesScalarYangBaxter
      CellularAutomata.FiniteYangBaxterBoundary.affineFirstFamily := by
  simpa [CellularAutomata.FiniteYangBaxterBoundary.SatisfiesScalarYangBaxter,
    CellularAutomata.FiniteYangBaxterBoundary.affineFirstFamily,
    CellularAutomata.NecSuf.FiniteYangBaxterBoundary.SatisfiesScalarYangBaxter,
    firstParameterFamily] using
    (firstParameterFamily_satisfies (P := ℂ) (K := ℂ) (fun p => 1 + p))

theorem scalar_spectral_dependence_not_determined_of_necSuf :
    CellularAutomata.FiniteYangBaxterBoundary.SatisfiesScalarYangBaxter
        CellularAutomata.FiniteYangBaxterBoundary.constantFamily ∧
      CellularAutomata.FiniteYangBaxterBoundary.SatisfiesScalarYangBaxter
        CellularAutomata.FiniteYangBaxterBoundary.affineFirstFamily ∧
      CellularAutomata.FiniteYangBaxterBoundary.constantFamily 0 0 =
        CellularAutomata.FiniteYangBaxterBoundary.affineFirstFamily 0 0 ∧
      CellularAutomata.FiniteYangBaxterBoundary.constantFamily 1 0 ≠
        CellularAutomata.FiniteYangBaxterBoundary.affineFirstFamily 1 0 := by
  have h := scalar_spectral_dependence_not_determined
    (P := ℂ) (K := ℂ) (fun p => 1 + p) 0 1 0 (by norm_num) (by norm_num)
  simpa [CellularAutomata.FiniteYangBaxterBoundary.SatisfiesScalarYangBaxter,
    CellularAutomata.FiniteYangBaxterBoundary.constantFamily,
    CellularAutomata.FiniteYangBaxterBoundary.affineFirstFamily,
    CellularAutomata.NecSuf.FiniteYangBaxterBoundary.SatisfiesScalarYangBaxter,
    constantOneFamily, firstParameterFamily] using h

end Derivation

end CellularAutomata.NecSuf.FiniteYangBaxterBoundary
