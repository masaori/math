/-
節「二次形式」の必要十分版。具体版 `MathematicalToolkit/QuadraticForm/QuadraticForm.lean` と同じ def・calc の行を、
係数 ℂ を型の変数 K に替えて書く。本文の -_ℂ a は K の `-a`（`Neg K` の記号）で、a + (-a) = 0 は仮定 `hneg` で渡す。

各主張が実際に使う K の性質（削ると通らない）:

  polarization・IsQuadraticForm・IsNondegenerateQuadraticForm・IsIsometry
                                              なし（定義の式に現れる演算の記号だけ）
  polarization_identity                       加法の結合法則・交換法則、a + (-a) = 0、0 + a = a
  polarization_symm                           加法の結合法則・交換法則
  splitQuadraticForm                          なし（W^* の元の値を取るだけ）
  splitSpace                                  双対空間を線型空間にする性質（`DualSpaceVectorSpaceLaws`）
  polarization_splitQuadraticForm             加法の結合法則・交換法則・a + 0 = a（どれも `DualSpaceVectorSpaceLaws` の欄）、a + (-a) = 0
  splitQuadraticForm_isQuadraticForm          上の行と左分配法則（`DualSpaceVectorSpaceLaws` の欄）
  splitQuadraticForm_embedFirst               証明は使わない（0_{W^*}(w) = 0 は零写像の定義）。主張の文の in_1 が W^* の零を使うので、
                                              主張を書くために `DualSpaceVectorSpaceLaws` を持つ
  splitQuadraticForm_embedSecond              0 + 0 = 0、0 · a = 0（線型形式が零を零へ移すこと）

二次形式であることは、偏極の等式・対称性のどちらも使わない（具体版も仮定に置いていない）。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.DualSpace
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.DirectSum
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.ZeroVector

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Neg K] {V : Type u}

/-- 本文 `def_polarization_of_map_to_complex_numbers` の必要十分版。 -/
def polarization (S : VectorSpace K V) (q : V → K) (x y : V) : K :=
  (q (S.add x y) + -q x) + -q y

/-- 本文 `def_quadratic_form` の必要十分版。 -/
structure IsQuadraticForm (S : VectorSpace K V) (q : V → K) : Prop where
  map_smul : ∀ (l : K) (x : V), q (S.smul l x) = l * (l * q x)
  polarization_isLinearForm : ∀ y : V, IsLinearForm S (fun x => polarization S q x y)

/-- 本文 `claim_polarization_identity` の必要十分版。 -/
theorem polarization_identity [Zero K] (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c))
    (hcomm : ∀ a b : K, a + b = b + a) (hneg : ∀ a : K, a + -a = 0) (hzero_add : ∀ a : K, 0 + a = a)
    (S : VectorSpace K V) (q : V → K) (x y : V) :
    (q x + q y) + polarization S q x y = q (S.add x y) := by
  let a : K := q x
  let b : K := q y
  let c : K := q (S.add x y)
  show (a + b) + polarization S q x y = c
  calc (a + b) + polarization S q x y
      = (a + b) + ((c + -a) + -b) := rfl
    _ = (a + b) + (c + (-a + -b)) := by rw [hassoc c (-a) (-b)]
    _ = (a + b) + ((-a + -b) + c) := by rw [hcomm c (-a + -b)]
    _ = ((a + b) + (-a + -b)) + c := by rw [← hassoc (a + b) (-a + -b) c]
    _ = (a + (b + (-a + -b))) + c := by rw [hassoc a b (-a + -b)]
    _ = (a + (b + (-b + -a))) + c := by rw [hcomm (-a) (-b)]
    _ = (a + ((b + -b) + -a)) + c := by rw [← hassoc b (-b) (-a)]
    _ = (a + (0 + -a)) + c := by rw [hneg b]
    _ = (a + -a) + c := by rw [hzero_add (-a)]
    _ = 0 + c := by rw [hneg a]
    _ = c := by rw [hzero_add c]

/-- 本文 `claim_polarization_is_symmetric` の必要十分版。 -/
theorem polarization_symm (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c))
    (hcomm : ∀ a b : K, a + b = b + a) (S : VectorSpace K V) (q : V → K) (x y : V) :
    polarization S q x y = polarization S q y x := calc
  polarization S q x y = (q (S.add x y) + -q x) + -q y := rfl
  _ = (q (S.add y x) + -q x) + -q y := by rw [S.add_comm x y]
  _ = q (S.add y x) + (-q x + -q y) := by rw [hassoc (q (S.add y x)) (-q x) (-q y)]
  _ = q (S.add y x) + (-q y + -q x) := by rw [hcomm (-q x) (-q y)]
  _ = (q (S.add y x) + -q y) + -q x := by rw [← hassoc (q (S.add y x)) (-q y) (-q x)]
  _ = polarization S q y x := rfl

/-- 本文 `def_nondegenerate_quadratic_form` の必要十分版。 -/
structure IsNondegenerateQuadraticForm [Zero K] (S : VectorSpace K V) (q : V → K) : Prop where
  isQuadraticForm : IsQuadraticForm S q
  nondegenerate : ∀ x : V, (∀ y : V, polarization S q x y = 0) → x = S.zero

/-- 本文 `def_isometry_of_quadratic_spaces` の必要十分版。 -/
structure IsIsometry {V' : Type v} (S : VectorSpace K V) (S' : VectorSpace K V') (q : V → K)
    (q' : V' → K) (θ : V → V') : Prop where
  isQuadraticForm : IsQuadraticForm S q
  isQuadraticForm' : IsQuadraticForm S' q'
  isLinearMap : IsLinearMap S S' θ
  map_form : ∀ x : V, q' (θ x) = q x

section Split

variable [Zero K] {W : Type u} (L : DualSpaceVectorSpaceLaws K) (SW : VectorSpace K W)

/-- 本文 `def_split_quadratic_form` の必要十分版。 -/
def splitQuadraticForm (p : W × DualSpace SW) : K := p.2.1 p.1

/-- 本文 `def_split_quadratic_form` の W ⊕ W^* の必要十分版。 -/
abbrev splitSpace : VectorSpace K (W × DualSpace SW) := directSumVectorSpace SW (dualSpaceVectorSpace L SW)

/-- 本文 `claim_value_of_polarization_of_split_quadratic_form` の必要十分版。 -/
theorem polarization_splitQuadraticForm (hneg : ∀ a : K, a + -a = 0) (w w' : W) (f f' : DualSpace SW) :
    polarization (splitSpace L SW) (splitQuadraticForm SW) (w, f) (w', f') = f.1 w' + f'.1 w := by
  let a : K := f.1 w
  let b : K := f.1 w'
  let c : K := f'.1 w
  let d : K := f'.1 w'
  calc polarization (splitSpace L SW) (splitQuadraticForm SW) (w, f) (w', f')
      = (splitQuadraticForm SW ((splitSpace L SW).add (w, f) (w', f')) + -splitQuadraticForm SW (w, f))
          + -splitQuadraticForm SW (w', f') := rfl
    _ = (splitQuadraticForm SW (SW.add w w', DualSpace.add L.toDualSpaceOperationLaws SW f f')
            + -splitQuadraticForm SW (w, f)) + -splitQuadraticForm SW (w', f') := rfl
    _ = ((DualSpace.add L.toDualSpaceOperationLaws SW f f').1 (SW.add w w') + -a) + -d := rfl
    _ = ((f.1 (SW.add w w') + f'.1 (SW.add w w')) + -a) + -d := rfl
    _ = (((a + b) + (c + d)) + -a) + -d := by rw [f.2.map_add w w', f'.2.map_add w w']
    _ = ((a + b) + (c + d)) + (-a + -d) := by rw [L.add_assoc ((a + b) + (c + d)) (-a) (-d)]
    _ = (a + (b + (c + d))) + (-a + -d) := by rw [L.add_assoc a b (c + d)]
    _ = (a + ((b + c) + d)) + (-a + -d) := by rw [← L.add_assoc b c d]
    _ = (((b + c) + d) + a) + (-a + -d) := by rw [L.add_comm a ((b + c) + d)]
    _ = ((b + c) + (d + a)) + (-a + -d) := by rw [L.add_assoc (b + c) d a]
    _ = ((b + c) + (a + d)) + (-a + -d) := by rw [L.add_comm d a]
    _ = (b + c) + ((a + d) + (-a + -d)) := by rw [L.add_assoc (b + c) (a + d) (-a + -d)]
    _ = (b + c) + (a + (d + (-a + -d))) := by rw [L.add_assoc a d (-a + -d)]
    _ = (b + c) + (a + ((d + -a) + -d)) := by rw [← L.add_assoc d (-a) (-d)]
    _ = (b + c) + (a + ((-a + d) + -d)) := by rw [L.add_comm d (-a)]
    _ = (b + c) + (a + (-a + (d + -d))) := by rw [L.add_assoc (-a) d (-d)]
    _ = (b + c) + ((a + -a) + (d + -d)) := by rw [← L.add_assoc a (-a) (d + -d)]
    _ = (b + c) + (0 + 0) := by rw [hneg a, hneg d]
    _ = b + c := by rw [L.add_zero (0 : K), L.add_zero (b + c)]
    _ = f.1 w' + f'.1 w := rfl

/-- 本文 `claim_split_quadratic_form_is_quadratic_form` の必要十分版。 -/
theorem splitQuadraticForm_isQuadraticForm (hneg : ∀ a : K, a + -a = 0) :
    IsQuadraticForm (splitSpace L SW) (splitQuadraticForm SW) where
  map_smul l p := calc
    splitQuadraticForm SW ((splitSpace L SW).smul l p)
        = splitQuadraticForm SW (SW.smul l p.1, DualSpace.smul L.toDualSpaceOperationLaws SW l p.2) := rfl
    _ = (DualSpace.smul L.toDualSpaceOperationLaws SW l p.2).1 (SW.smul l p.1) := rfl
    _ = l * p.2.1 (SW.smul l p.1) := rfl
    _ = l * (l * p.2.1 p.1) := by rw [p.2.2.map_smul l p.1]
    _ = l * (l * splitQuadraticForm SW p) := rfl
  polarization_isLinearForm y := {
    map_add := fun p₁ p₂ => calc
      polarization (splitSpace L SW) (splitQuadraticForm SW) ((splitSpace L SW).add p₁ p₂) y
          = polarization (splitSpace L SW) (splitQuadraticForm SW)
              (SW.add p₁.1 p₂.1, DualSpace.add L.toDualSpaceOperationLaws SW p₁.2 p₂.2) (y.1, y.2) := rfl
      _ = (DualSpace.add L.toDualSpaceOperationLaws SW p₁.2 p₂.2).1 y.1 + y.2.1 (SW.add p₁.1 p₂.1) :=
          polarization_splitQuadraticForm L SW hneg _ _ _ _
      _ = (p₁.2.1 y.1 + p₂.2.1 y.1) + y.2.1 (SW.add p₁.1 p₂.1) := rfl
      _ = (p₁.2.1 y.1 + p₂.2.1 y.1) + (y.2.1 p₁.1 + y.2.1 p₂.1) := by rw [y.2.2.map_add p₁.1 p₂.1]
      _ = p₁.2.1 y.1 + (p₂.2.1 y.1 + (y.2.1 p₁.1 + y.2.1 p₂.1)) := by
          rw [L.add_assoc (p₁.2.1 y.1) (p₂.2.1 y.1) (y.2.1 p₁.1 + y.2.1 p₂.1)]
      _ = p₁.2.1 y.1 + ((p₂.2.1 y.1 + y.2.1 p₁.1) + y.2.1 p₂.1) := by
          rw [← L.add_assoc (p₂.2.1 y.1) (y.2.1 p₁.1) (y.2.1 p₂.1)]
      _ = p₁.2.1 y.1 + ((y.2.1 p₁.1 + p₂.2.1 y.1) + y.2.1 p₂.1) := by
          rw [L.add_comm (p₂.2.1 y.1) (y.2.1 p₁.1)]
      _ = p₁.2.1 y.1 + (y.2.1 p₁.1 + (p₂.2.1 y.1 + y.2.1 p₂.1)) := by
          rw [L.add_assoc (y.2.1 p₁.1) (p₂.2.1 y.1) (y.2.1 p₂.1)]
      _ = (p₁.2.1 y.1 + y.2.1 p₁.1) + (p₂.2.1 y.1 + y.2.1 p₂.1) := by
          rw [← L.add_assoc (p₁.2.1 y.1) (y.2.1 p₁.1) (p₂.2.1 y.1 + y.2.1 p₂.1)]
      _ = polarization (splitSpace L SW) (splitQuadraticForm SW) (p₁.1, p₁.2) (y.1, y.2)
            + polarization (splitSpace L SW) (splitQuadraticForm SW) (p₂.1, p₂.2) (y.1, y.2) := by
          rw [polarization_splitQuadraticForm L SW hneg p₁.1 y.1 p₁.2 y.2,
            polarization_splitQuadraticForm L SW hneg p₂.1 y.1 p₂.2 y.2]
    map_smul := fun l p => calc
      polarization (splitSpace L SW) (splitQuadraticForm SW) ((splitSpace L SW).smul l p) y
          = polarization (splitSpace L SW) (splitQuadraticForm SW)
              (SW.smul l p.1, DualSpace.smul L.toDualSpaceOperationLaws SW l p.2) (y.1, y.2) := rfl
      _ = (DualSpace.smul L.toDualSpaceOperationLaws SW l p.2).1 y.1 + y.2.1 (SW.smul l p.1) :=
          polarization_splitQuadraticForm L SW hneg _ _ _ _
      _ = l * p.2.1 y.1 + y.2.1 (SW.smul l p.1) := rfl
      _ = l * p.2.1 y.1 + l * y.2.1 p.1 := by rw [y.2.2.map_smul l p.1]
      _ = l * (p.2.1 y.1 + y.2.1 p.1) := by rw [L.left_distrib l (p.2.1 y.1) (y.2.1 p.1)]
      _ = l * polarization (splitSpace L SW) (splitQuadraticForm SW) (p.1, p.2) (y.1, y.2) := by
          rw [polarization_splitQuadraticForm L SW hneg p.1 y.1 p.2 y.2] }

omit [Neg K] in
/-- 本文 `claim_split_quadratic_form_vanishes_on_first_component` の必要十分版。 -/
theorem splitQuadraticForm_embedFirst (w : W) :
    splitQuadraticForm SW (embedFirst (dualSpaceVectorSpace L SW) w) = 0 := calc
  splitQuadraticForm SW (embedFirst (dualSpaceVectorSpace L SW) w)
      = splitQuadraticForm SW (w, DualSpace.zero L.toDualSpaceOperationLaws SW) := rfl
  _ = (DualSpace.zero L.toDualSpaceOperationLaws SW).1 w := rfl
  _ = zeroMap w := rfl
  _ = 0 := rfl

omit [Neg K] in
/-- 本文 `claim_split_quadratic_form_vanishes_on_second_component` の必要十分版。 -/
theorem splitQuadraticForm_embedSecond (h00 : (0 : K) + 0 = 0) (h0mul : ∀ a : K, 0 * a = 0)
    (g : DualSpace SW) : splitQuadraticForm SW (embedSecond SW g) = 0 := calc
  splitQuadraticForm SW (embedSecond SW g) = splitQuadraticForm SW (SW.zero, g) := rfl
  _ = g.1 SW.zero := rfl
  _ = 0 := g.2.map_zero h00 h0mul

end Split

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
