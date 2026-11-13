/-
節「テンソル積」のうち、集合上の ℂ 値写像の集合と各点ごとの演算の必要十分版。具体版
`MathematicalToolkit/TensorProduct/ComplexValuedMaps.lean` と同じ calc の行で、係数 ℂ を型の変数 K に替えて書く。

実際に使う K の性質（`ValuedMapsLaws`）: 加法の結合法則・交換法則、a + 0 = a、加法の逆元の存在、乗法の結合法則、
1 · a = a、左右の分配法則。K を自分自身の上の線型空間にする `coefficientsVectorSpace` と同じ八つで、
乗法の交換法則・a · 1 = a は使わない。加法の逆元は、具体版が ℂ の -A(x) を書くところを、存在から一つ選ぶ。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.Definitions

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u uK

namespace ComplexValuedMaps

variable {K : Type uK} [Add K] [Mul K] {X : Type u}

/-- 本文 `def_complex_valued_maps_on_set`：(A +_{ℂ^X} B)(x) := A(x) +_ℂ B(x)。 -/
def add (A B : X → K) : X → K := fun x => A x + B x

/-- 本文 `def_complex_valued_maps_on_set`：(λ ·_{ℂ^X} A)(x) := λ ·_ℂ A(x)。 -/
def smul (l : K) (A : X → K) : X → K := fun x => l * A x

/-- 本文 `def_complex_valued_maps_on_set`：0_{ℂ^X}(x) := 0_ℂ。 -/
def zero [Zero K] : X → K := fun _ => 0

end ComplexValuedMaps

/-- K^X を線型空間にするのに使う K の性質（`coefficientsVectorSpace` の仮定と同じ八つ）。 -/
structure ValuedMapsLaws (K : Type uK) [Add K] [Mul K] [One K] [Zero K] : Prop where
  add_assoc : ∀ a b c : K, (a + b) + c = a + (b + c)
  add_comm : ∀ a b : K, a + b = b + a
  add_zero : ∀ a : K, a + 0 = a
  exists_neg : ∀ a : K, ∃ a' : K, a + a' = 0
  mul_assoc : ∀ a b c : K, (a * b) * c = a * (b * c)
  one_mul : ∀ a : K, 1 * a = a
  left_distrib : ∀ a b c : K, a * (b + c) = a * b + a * c
  right_distrib : ∀ a b c : K, (a + b) * c = a * c + b * c

/-- 本文 `claim_complex_valued_maps_on_set_form_complex_vector_space`：(ℂ^X, +_{ℂ^X}, ·_{ℂ^X}, 0_{ℂ^X}) は ℂ-線型空間である。 -/
def complexValuedMapsVectorSpace {K : Type uK} [Add K] [Mul K] [One K] [Zero K] (L : ValuedMapsLaws K)
    (X : Type u) : VectorSpace K (X → K) where
  add := ComplexValuedMaps.add
  smul := ComplexValuedMaps.smul
  zero := ComplexValuedMaps.zero
  add_assoc A B C := funext fun x => calc
    ComplexValuedMaps.add (ComplexValuedMaps.add A B) C x
        = ComplexValuedMaps.add A B x + C x := rfl
    _ = (A x + B x) + C x := rfl
    _ = A x + (B x + C x) := by rw [L.add_assoc (A x) (B x) (C x)]
    _ = A x + ComplexValuedMaps.add B C x := rfl
    _ = ComplexValuedMaps.add A (ComplexValuedMaps.add B C) x := rfl
  add_comm A B := funext fun x => calc
    ComplexValuedMaps.add A B x = A x + B x := rfl
    _ = B x + A x := by rw [L.add_comm (A x) (B x)]
    _ = ComplexValuedMaps.add B A x := rfl
  add_zero A := funext fun x => calc
    ComplexValuedMaps.add A ComplexValuedMaps.zero x = A x + ComplexValuedMaps.zero x := rfl
    _ = A x + 0 := rfl
    _ = A x := by rw [L.add_zero (A x)]
  exists_add_inverse A :=
    -- A'(x) := (A(x) の加法の逆元)
    let A' : X → K := fun x => Classical.choose (L.exists_neg (A x))
    ⟨A', funext fun x => calc
      ComplexValuedMaps.add A A' x = A x + A' x := rfl
      _ = 0 := Classical.choose_spec (L.exists_neg (A x))
      _ = ComplexValuedMaps.zero x := rfl⟩
  smul_assoc l μ A := funext fun x => calc
    ComplexValuedMaps.smul (l * μ) A x = (l * μ) * A x := rfl
    _ = l * (μ * A x) := by rw [L.mul_assoc l μ (A x)]
    _ = l * ComplexValuedMaps.smul μ A x := rfl
    _ = ComplexValuedMaps.smul l (ComplexValuedMaps.smul μ A) x := rfl
  one_smul A := funext fun x => calc
    ComplexValuedMaps.smul 1 A x = 1 * A x := rfl
    _ = A x := by rw [L.one_mul (A x)]
  smul_add l A B := funext fun x => calc
    ComplexValuedMaps.smul l (ComplexValuedMaps.add A B) x = l * ComplexValuedMaps.add A B x := rfl
    _ = l * (A x + B x) := rfl
    _ = l * A x + l * B x := by rw [L.left_distrib l (A x) (B x)]
    _ = ComplexValuedMaps.smul l A x + ComplexValuedMaps.smul l B x := rfl
    _ = ComplexValuedMaps.add (ComplexValuedMaps.smul l A) (ComplexValuedMaps.smul l B) x := rfl
  add_smul l μ A := funext fun x => calc
    ComplexValuedMaps.smul (l + μ) A x = (l + μ) * A x := rfl
    _ = l * A x + μ * A x := by rw [L.right_distrib l μ (A x)]
    _ = ComplexValuedMaps.smul l A x + ComplexValuedMaps.smul μ A x := rfl
    _ = ComplexValuedMaps.add (ComplexValuedMaps.smul l A) (ComplexValuedMaps.smul μ A) x := rfl

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
