/-
節「二次形式」の具体版。人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                              このファイル
  def_polarization_of_map_to_complex_numbers                polarization（B_q）
  def_quadratic_form                                        IsQuadraticForm
  claim_polarization_identity                               polarization_identity
  claim_polarization_is_symmetric                           polarization_symm
  def_nondegenerate_quadratic_form                          IsNondegenerateQuadraticForm
  def_isometry_of_quadratic_spaces                          IsIsometry
  def_split_quadratic_form                                  splitQuadraticForm（q_W）
  claim_value_of_polarization_of_split_quadratic_form       polarization_splitQuadraticForm
  claim_split_quadratic_form_is_quadratic_form              splitQuadraticForm_isQuadraticForm
  claim_split_quadratic_form_vanishes_on_first_component    splitQuadraticForm_embedFirst
  claim_split_quadratic_form_vanishes_on_second_component   splitQuadraticForm_embedSecond

ℂ の元 a の加法の逆元 -_ℂ a は ℂ の `-a` で、a +_ℂ (-_ℂ a) = 0_ℂ は `add_neg_cancel a` である。
W ⊕ W^* の元は W の元と W^* の元の組 (w, f) で、f の値 f(w) は `f.1 w` と書く。

必要十分版は `NecSuf/MathematicalToolkit/QuadraticForm/QuadraticForm.lean`、導出版は `QuadraticFormFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.DualSpace
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.DirectSum
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.ZeroVector

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v

variable {V : Type u}

/-- 本文 `def_polarization_of_map_to_complex_numbers`：
B_q(x, y) := (q(x +_V y) +_ℂ (-_ℂ q(x))) +_ℂ (-_ℂ q(y))。 -/
def polarization (S : ComplexVectorSpace V) (q : V → ℂ) (x y : V) : ℂ :=
  (q (S.add x y) + -q x) + -q y

/-- 本文 `def_quadratic_form`：q(λ ·_V x) = λ ·_ℂ (λ ·_ℂ q(x)) と、各 y で B_q(•, y) が線型形式であること。 -/
structure IsQuadraticForm (S : ComplexVectorSpace V) (q : V → ℂ) : Prop where
  /-- 一つ目の条件 -/
  map_smul : ∀ (l : ℂ) (x : V), q (S.smul l x) = l * (l * q x)
  /-- 二つ目の条件 -/
  polarization_isLinearForm : ∀ y : V, IsComplexLinearForm S (fun x => polarization S q x y)

/-- 本文 `claim_polarization_identity`：(q(x) +_ℂ q(y)) +_ℂ B_q(x, y) = q(x +_V y)。
本文どおり a := q(x)、b := q(y)、c := q(x +_V y) と置く。q が二次形式であることは使わない。 -/
theorem polarization_identity (S : ComplexVectorSpace V) (q : V → ℂ) (x y : V) :
    (q x + q y) + polarization S q x y = q (S.add x y) := by
  let a : ℂ := q x
  let b : ℂ := q y
  let c : ℂ := q (S.add x y)
  show (a + b) + polarization S q x y = c
  calc (a + b) + polarization S q x y
      = (a + b) + ((c + -a) + -b) := rfl
    _ = (a + b) + (c + (-a + -b)) := by rw [_root_.add_assoc c (-a) (-b)]
    _ = (a + b) + ((-a + -b) + c) := by rw [_root_.add_comm c (-a + -b)]
    _ = ((a + b) + (-a + -b)) + c := by rw [← _root_.add_assoc (a + b) (-a + -b) c]
    _ = (a + (b + (-a + -b))) + c := by rw [_root_.add_assoc a b (-a + -b)]
    _ = (a + (b + (-b + -a))) + c := by rw [_root_.add_comm (-a) (-b)]
    _ = (a + ((b + -b) + -a)) + c := by rw [← _root_.add_assoc b (-b) (-a)]
    _ = (a + (0 + -a)) + c := by rw [add_neg_cancel b]
    _ = (a + -a) + c := by rw [_root_.zero_add (-a)]
    _ = 0 + c := by rw [add_neg_cancel a]
    _ = c := by rw [_root_.zero_add c]

/-- 本文 `claim_polarization_is_symmetric`：B_q(x, y) = B_q(y, x)。 -/
theorem polarization_symm (S : ComplexVectorSpace V) (q : V → ℂ) (x y : V) :
    polarization S q x y = polarization S q y x := calc
  polarization S q x y = (q (S.add x y) + -q x) + -q y := rfl
  _ = (q (S.add y x) + -q x) + -q y := by rw [S.add_comm x y]
  _ = q (S.add y x) + (-q x + -q y) := by rw [_root_.add_assoc (q (S.add y x)) (-q x) (-q y)]
  _ = q (S.add y x) + (-q y + -q x) := by rw [_root_.add_comm (-q x) (-q y)]
  _ = (q (S.add y x) + -q y) + -q x := by rw [← _root_.add_assoc (q (S.add y x)) (-q y) (-q x)]
  _ = polarization S q y x := rfl

/-- 本文 `def_nondegenerate_quadratic_form`：二次形式 q で、すべての y で B_q(x, y) = 0_ℂ となる x は 0_V だけであるもの。 -/
structure IsNondegenerateQuadraticForm (S : ComplexVectorSpace V) (q : V → ℂ) : Prop where
  isQuadraticForm : IsQuadraticForm S q
  nondegenerate : ∀ x : V, (∀ y : V, polarization S q x y = 0) → x = S.zero

/-- 本文 `def_isometry_of_quadratic_spaces`：二次形式 q、q' の間の線型写像 θ で、q'(θ(x)) = q(x) を満たすもの。
全単射は要求しない。 -/
structure IsIsometry {V' : Type v} (S : ComplexVectorSpace V) (S' : ComplexVectorSpace V') (q : V → ℂ)
    (q' : V' → ℂ) (θ : V → V') : Prop where
  isQuadraticForm : IsQuadraticForm S q
  isQuadraticForm' : IsQuadraticForm S' q'
  isLinearMap : IsComplexLinearMap S S' θ
  map_form : ∀ x : V, q' (θ x) = q x

section Split

variable {W : Type u} (SW : ComplexVectorSpace W)

/-- 本文 `def_split_quadratic_form`：W ⊕ W^* 上の q_W((w, f)) := f(w)。 -/
def splitQuadraticForm (p : W × DualSpace SW) : ℂ := p.2.1 p.1

/-- 本文 `def_split_quadratic_form` の W ⊕ W^*：W と双対空間 W^* の直和。 -/
abbrev splitSpace : ComplexVectorSpace (W × DualSpace SW) := directSumVectorSpace SW (dualSpaceVectorSpace SW)

/-- 本文 `claim_value_of_polarization_of_split_quadratic_form`：B_{q_W}((w, f), (w', f')) = f(w') +_ℂ f'(w)。
本文どおり a := f(w)、b := f(w')、c := f'(w)、d := f'(w') と置く。 -/
theorem polarization_splitQuadraticForm (w w' : W) (f f' : DualSpace SW) :
    polarization (splitSpace SW) (splitQuadraticForm SW) (w, f) (w', f') = f.1 w' + f'.1 w := by
  let a : ℂ := f.1 w
  let b : ℂ := f.1 w'
  let c : ℂ := f'.1 w
  let d : ℂ := f'.1 w'
  calc polarization (splitSpace SW) (splitQuadraticForm SW) (w, f) (w', f')
      = (splitQuadraticForm SW ((splitSpace SW).add (w, f) (w', f')) + -splitQuadraticForm SW (w, f))
          + -splitQuadraticForm SW (w', f') := rfl
    _ = (splitQuadraticForm SW (SW.add w w', DualSpace.add SW f f') + -splitQuadraticForm SW (w, f))
          + -splitQuadraticForm SW (w', f') := rfl
    _ = ((DualSpace.add SW f f').1 (SW.add w w') + -a) + -d := rfl
    _ = ((f.1 (SW.add w w') + f'.1 (SW.add w w')) + -a) + -d := rfl
    _ = (((a + b) + (c + d)) + -a) + -d := by rw [f.2.map_add w w', f'.2.map_add w w']
    _ = ((a + b) + (c + d)) + (-a + -d) := by rw [_root_.add_assoc ((a + b) + (c + d)) (-a) (-d)]
    _ = (a + (b + (c + d))) + (-a + -d) := by rw [_root_.add_assoc a b (c + d)]
    _ = (a + ((b + c) + d)) + (-a + -d) := by rw [← _root_.add_assoc b c d]
    _ = (((b + c) + d) + a) + (-a + -d) := by rw [_root_.add_comm a ((b + c) + d)]
    _ = ((b + c) + (d + a)) + (-a + -d) := by rw [_root_.add_assoc (b + c) d a]
    _ = ((b + c) + (a + d)) + (-a + -d) := by rw [_root_.add_comm d a]
    _ = (b + c) + ((a + d) + (-a + -d)) := by rw [_root_.add_assoc (b + c) (a + d) (-a + -d)]
    _ = (b + c) + (a + (d + (-a + -d))) := by rw [_root_.add_assoc a d (-a + -d)]
    _ = (b + c) + (a + ((d + -a) + -d)) := by rw [← _root_.add_assoc d (-a) (-d)]
    _ = (b + c) + (a + ((-a + d) + -d)) := by rw [_root_.add_comm d (-a)]
    _ = (b + c) + (a + (-a + (d + -d))) := by rw [_root_.add_assoc (-a) d (-d)]
    _ = (b + c) + ((a + -a) + (d + -d)) := by rw [← _root_.add_assoc a (-a) (d + -d)]
    _ = (b + c) + (0 + 0) := by rw [add_neg_cancel a, add_neg_cancel d]
    _ = b + c := by rw [_root_.add_zero (0 : ℂ), _root_.add_zero (b + c)]
    _ = f.1 w' + f'.1 w := rfl

/-- 本文 `claim_split_quadratic_form_is_quadratic_form`：q_W は W ⊕ W^* 上の二次形式である。 -/
theorem splitQuadraticForm_isQuadraticForm :
    IsQuadraticForm (splitSpace SW) (splitQuadraticForm SW) where
  map_smul l p := calc
    splitQuadraticForm SW ((splitSpace SW).smul l p)
        = splitQuadraticForm SW (SW.smul l p.1, DualSpace.smul SW l p.2) := rfl
    _ = (DualSpace.smul SW l p.2).1 (SW.smul l p.1) := rfl
    _ = l * p.2.1 (SW.smul l p.1) := rfl
    _ = l * (l * p.2.1 p.1) := by rw [p.2.2.map_smul l p.1]
    _ = l * (l * splitQuadraticForm SW p) := rfl
  polarization_isLinearForm y := {
    map_add := fun p₁ p₂ => calc
      polarization (splitSpace SW) (splitQuadraticForm SW) ((splitSpace SW).add p₁ p₂) y
          = polarization (splitSpace SW) (splitQuadraticForm SW)
              (SW.add p₁.1 p₂.1, DualSpace.add SW p₁.2 p₂.2) (y.1, y.2) := rfl
      _ = (DualSpace.add SW p₁.2 p₂.2).1 y.1 + y.2.1 (SW.add p₁.1 p₂.1) :=
          polarization_splitQuadraticForm SW _ _ _ _
      _ = (p₁.2.1 y.1 + p₂.2.1 y.1) + y.2.1 (SW.add p₁.1 p₂.1) := rfl
      _ = (p₁.2.1 y.1 + p₂.2.1 y.1) + (y.2.1 p₁.1 + y.2.1 p₂.1) := by rw [y.2.2.map_add p₁.1 p₂.1]
      _ = p₁.2.1 y.1 + (p₂.2.1 y.1 + (y.2.1 p₁.1 + y.2.1 p₂.1)) := by
          rw [_root_.add_assoc (p₁.2.1 y.1) (p₂.2.1 y.1) (y.2.1 p₁.1 + y.2.1 p₂.1)]
      _ = p₁.2.1 y.1 + ((p₂.2.1 y.1 + y.2.1 p₁.1) + y.2.1 p₂.1) := by
          rw [← _root_.add_assoc (p₂.2.1 y.1) (y.2.1 p₁.1) (y.2.1 p₂.1)]
      _ = p₁.2.1 y.1 + ((y.2.1 p₁.1 + p₂.2.1 y.1) + y.2.1 p₂.1) := by
          rw [_root_.add_comm (p₂.2.1 y.1) (y.2.1 p₁.1)]
      _ = p₁.2.1 y.1 + (y.2.1 p₁.1 + (p₂.2.1 y.1 + y.2.1 p₂.1)) := by
          rw [_root_.add_assoc (y.2.1 p₁.1) (p₂.2.1 y.1) (y.2.1 p₂.1)]
      _ = (p₁.2.1 y.1 + y.2.1 p₁.1) + (p₂.2.1 y.1 + y.2.1 p₂.1) := by
          rw [← _root_.add_assoc (p₁.2.1 y.1) (y.2.1 p₁.1) (p₂.2.1 y.1 + y.2.1 p₂.1)]
      _ = polarization (splitSpace SW) (splitQuadraticForm SW) (p₁.1, p₁.2) (y.1, y.2)
            + polarization (splitSpace SW) (splitQuadraticForm SW) (p₂.1, p₂.2) (y.1, y.2) := by
          rw [polarization_splitQuadraticForm SW p₁.1 y.1 p₁.2 y.2,
            polarization_splitQuadraticForm SW p₂.1 y.1 p₂.2 y.2]
    map_smul := fun l p => calc
      polarization (splitSpace SW) (splitQuadraticForm SW) ((splitSpace SW).smul l p) y
          = polarization (splitSpace SW) (splitQuadraticForm SW)
              (SW.smul l p.1, DualSpace.smul SW l p.2) (y.1, y.2) := rfl
      _ = (DualSpace.smul SW l p.2).1 y.1 + y.2.1 (SW.smul l p.1) :=
          polarization_splitQuadraticForm SW _ _ _ _
      _ = l * p.2.1 y.1 + y.2.1 (SW.smul l p.1) := rfl
      _ = l * p.2.1 y.1 + l * y.2.1 p.1 := by rw [y.2.2.map_smul l p.1]
      _ = l * (p.2.1 y.1 + y.2.1 p.1) := by rw [mul_add l (p.2.1 y.1) (y.2.1 p.1)]
      _ = l * polarization (splitSpace SW) (splitQuadraticForm SW) (p.1, p.2) (y.1, y.2) := by
          rw [polarization_splitQuadraticForm SW p.1 y.1 p.2 y.2] }

/-- 本文 `claim_split_quadratic_form_vanishes_on_first_component`：q_W(in_1(w)) = 0_ℂ。 -/
theorem splitQuadraticForm_embedFirst (w : W) :
    splitQuadraticForm SW (embedFirst (dualSpaceVectorSpace SW) w) = 0 := calc
  splitQuadraticForm SW (embedFirst (dualSpaceVectorSpace SW) w)
      = splitQuadraticForm SW (w, DualSpace.zero SW) := rfl
  _ = (DualSpace.zero SW).1 w := rfl
  _ = zeroMap w := rfl
  _ = 0 := rfl

/-- 本文 `claim_split_quadratic_form_vanishes_on_second_component`：q_W(in_2(g)) = 0_ℂ。 -/
theorem splitQuadraticForm_embedSecond (g : DualSpace SW) :
    splitQuadraticForm SW (embedSecond SW g) = 0 := calc
  splitQuadraticForm SW (embedSecond SW g) = splitQuadraticForm SW (SW.zero, g) := rfl
  _ = g.1 SW.zero := rfl
  _ = 0 := g.2.map_zero

end Split

end CliffordMatrixIsomorphism.ComplexVectorSpace
