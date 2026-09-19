/-
正本: content/finite-yang-baxter-decision.ts の Lean 具体版。

有限集合上の二体写像、隣接 braid 規約、成分交換後の非隣接
Yang--Baxter 規約、二元集合上の反例、一元複素作用素族の
スペクトル依存性の非一意性を人手証明と同じ順序で示す。
位相、極限、微分、内積、完備性、近似は使わない。
-/
import Mathlib.Data.Complex.Basic

namespace CellularAutomata.FiniteYangBaxterBoundary

variable {X : Type*}

abbrev PairMap (X : Type*) := X × X → X × X

def adjacent12 (R : PairMap X) : X × X × X → X × X × X :=
  fun (x, y, z) => let (a, b) := R (x, y); (a, b, z)

def adjacent23 (R : PairMap X) : X × X × X → X × X × X :=
  fun (x, y, z) => let (a, b) := R (y, z); (x, a, b)

def nonadjacent13 (R : PairMap X) : X × X × X → X × X × X :=
  fun (x, y, z) => let (a, b) := R (x, z); (a, y, b)

def SatisfiesBraid (R : PairMap X) : Prop :=
  adjacent12 R ∘ adjacent23 R ∘ adjacent12 R =
    adjacent23 R ∘ adjacent12 R ∘ adjacent23 R

def SatisfiesYangBaxter (R : PairMap X) : Prop :=
  adjacent12 R ∘ nonadjacent13 R ∘ adjacent23 R =
    adjacent23 R ∘ nonadjacent13 R ∘ adjacent12 R

/-- 成分交換。 -/
def swap : PairMap X := fun (x, y) => (y, x)

/-- 隣接 braid 規約から非隣接 Yang--Baxter 規約への比較写像。 -/
def swapAfter (U : PairMap X) : PairMap X := fun p => swap (U p)

/-- 成分交換は有限 braid 条件を満たす。 -/
theorem swap_satisfiesBraid : SatisfiesBraid (swap : PairMap X) := by
  funext t
  rcases t with ⟨x, y, z⟩
  rfl

/-- 隣接 braid 規約は、成分交換後の非隣接規約と同値である。 -/
theorem braid_iff_swapAfter_yangBaxter (U : PairMap X) :
    SatisfiesBraid U ↔ SatisfiesYangBaxter (swapAfter U) := by
  constructor
  · intro h
    funext t
    rcases t with ⟨x, y, z⟩
    have ht := congrFun h (z, y, x)
    simpa [SatisfiesBraid, SatisfiesYangBaxter, adjacent12, adjacent23,
      nonadjacent13, swapAfter, swap, Function.comp_def] using congrArg swap ht
  · intro h
    funext t
    rcases t with ⟨x, y, z⟩
    have ht := congrFun h (z, y, x)
    simpa [SatisfiesBraid, SatisfiesYangBaxter, adjacent12, adjacent23,
      nonadjacent13, swapAfter, swap, Function.comp_def] using congrArg swap ht

/-- 二元集合上の有限二体写像の明示的な非解。 -/
def binaryCounterexample : PairMap Bool
  | (true, true) => (false, true)
  | _ => (false, false)

theorem binaryCounterexample_not_braid :
    ¬ SatisfiesBraid binaryCounterexample := by
  intro h
  have ht := congrFun h (true, true, true)
  decide at ht

/-- 一元複素作用素を係数で表した二パラメータ族。 -/
abbrev ScalarSpectralFamily := ℂ → ℂ → ℂ

/-- 一元作用素族における Yang--Baxter 等式。 -/
def SatisfiesScalarYangBaxter (R : ScalarSpectralFamily) : Prop :=
  ∀ l₁ l₂ l₃,
    R l₁ l₂ * R l₁ l₃ * R l₂ l₃ =
      R l₂ l₃ * R l₁ l₃ * R l₁ l₂

def constantFamily : ScalarSpectralFamily := fun _ _ => 1

def affineFirstFamily : ScalarSpectralFamily := fun l _ => 1 + l

theorem constantFamily_satisfies :
    SatisfiesScalarYangBaxter constantFamily := by
  intro l₁ l₂ l₃
  ring

theorem affineFirstFamily_satisfies :
    SatisfiesScalarYangBaxter affineFirstFamily := by
  intro l₁ l₂ l₃
  ring

/-- 同一点で同じ有限解を与える相異なる複素作用素族が存在する。 -/
theorem scalar_spectral_dependence_not_determined :
    SatisfiesScalarYangBaxter constantFamily ∧
      SatisfiesScalarYangBaxter affineFirstFamily ∧
      constantFamily 0 0 = affineFirstFamily 0 0 ∧
      constantFamily 1 0 ≠ affineFirstFamily 1 0 := by
  refine ⟨constantFamily_satisfies, affineFirstFamily_satisfies, ?_, ?_⟩
  · norm_num [constantFamily, affineFirstFamily]
  · norm_num [constantFamily, affineFirstFamily]

end CellularAutomata.FiniteYangBaxterBoundary
