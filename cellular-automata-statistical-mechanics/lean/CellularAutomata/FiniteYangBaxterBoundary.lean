/-
正本: content/finite-yang-baxter-decision.ts の Lean 具体版。

有限集合上の二体写像、隣接 braid 規約、成分交換後の非隣接
Yang--Baxter 規約、二元集合上の反例、一元複素作用素族の
スペクトル依存性の非一意性を人手証明と同じ順序で示す。
位相、極限、微分、内積、完備性、近似は使わない。
-/
import Mathlib.Data.Complex.Basic
import Mathlib.Data.Fintype.Prod

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

/-- 二元集合上の有限二体写像の明示的な非解。 -/
def binaryCounterexample : PairMap Bool
  | (true, true) => (false, true)
  | _ => (false, false)

theorem binaryCounterexample_not_braid :
    ¬ SatisfiesBraid binaryCounterexample := by
  intro h
  have ht := congrFun h (true, true, true)
  norm_num [adjacent12, adjacent23, binaryCounterexample, Function.comp_def] at ht

/-- 有限集合では braid 条件を三体入力の全走査で決定できる。 -/
instance satisfiesBraid_decidable [Fintype X] [DecidableEq X]
    (R : PairMap X) : Decidable (SatisfiesBraid R) := by
  letI : Decidable (∀ t : X × X × X,
      (adjacent12 R ∘ adjacent23 R ∘ adjacent12 R) t =
        (adjacent23 R ∘ adjacent12 R ∘ adjacent23 R) t) :=
    Fintype.decidableForallFintype
  exact decidable_of_iff
    (∀ t : X × X × X,
      (adjacent12 R ∘ adjacent23 R ∘ adjacent12 R) t =
        (adjacent23 R ∘ adjacent12 R ∘ adjacent23 R) t)
    ⟨fun h => funext h, fun h t => congrFun h t⟩

/-- 有限二体写像の複素線形化を基底係数で書いたもの。 -/
def complexLinearization [DecidableEq X] (U : PairMap X)
    (target source : X × X) : ℂ :=
  if target = U source then 1 else 0

/-- 各基底列から元の有限二体写像の値を回収できる。 -/
theorem complexLinearization_eq_one_iff [DecidableEq X]
    (U : PairMap X) (target source : X × X) :
    complexLinearization U target source = 1 ↔ target = U source := by
  simp [complexLinearization]

/-- 複素線形化をパラメータに依らない族として置く。 -/
def constantComplexLinearization [DecidableEq X] (U : PairMap X) :
    ℂ → ℂ → X × X → X × X → ℂ :=
  fun _ _ => complexLinearization U

theorem constantComplexLinearization_recovers [DecidableEq X]
    (U : PairMap X) (l m : ℂ) (source : X × X) :
    constantComplexLinearization U l m (U source) source = 1 := by
  simp [constantComplexLinearization, complexLinearization]

/-- 成分交換後の基底作用を、複素パラメータに依らない族として置く。 -/
def constantConvertedFamily (U : PairMap X) : ℂ → ℂ → PairMap X :=
  fun _ _ => swapAfter U

def SatisfiesParameterizedYangBaxter
    (R : ℂ → ℂ → PairMap X) : Prop :=
  ∀ l₁ l₂ l₃,
    adjacent12 (R l₁ l₂) ∘ nonadjacent13 (R l₁ l₃) ∘
        adjacent23 (R l₂ l₃) =
      adjacent23 (R l₂ l₃) ∘ nonadjacent13 (R l₁ l₃) ∘
        adjacent12 (R l₁ l₂)

/-- 有限 braid 解の複素線形化は定数な Yang--Baxter 族を与える。 -/
theorem braid_gives_constant_parameterized_yangBaxter
    (U : PairMap X) (hU : SatisfiesBraid U) :
    SatisfiesParameterizedYangBaxter (constantConvertedFamily U) := by
  intro l₁ l₂ l₃
  exact (braid_iff_swapAfter_yangBaxter U).mp hU

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
