/-
節「ℂ-線型空間」のうち双対空間の必要十分版。具体版
`MathematicalToolkit/ComplexVectorSpace/DualSpace.lean` と同じ calc の行を、K の性質の仮定で書く。

各主張が実際に使う K の性質（削ると通らない）:

  pointwiseSum_isLinearForm             加法の結合法則・交換法則、左分配法則 a(b+c) = ab+ac
  pointwiseScalarMultiple_isLinearForm  左分配法則、乗法の結合法則、乗法の交換法則
                                        （交換法則は (μλ)f(x) = (λμ)f(x) の行で要る。乗法が可換でない K では
                                        m_{μ,f} は線型形式にならず、V^* の上にスカラー倍が定まらない）
  zeroMap_isLinearForm                  0 + 0 = 0、a · 0 = 0
  dualSpaceVectorSpace                  上の三つに加えて、a + 0 = a、1 + n = 0 となる n の存在、
                                        1 · a = a、右分配法則、0 · a = 0、乗法の結合法則

双対空間の演算は三つの主張の結論を使って定まるので、三つの主張の仮定を一つの組
`DualSpaceOperationLaws` にまとめて渡す。八つの公理を示すのに要る残りを足した組が
`DualSpaceVectorSpaceLaws` である。どちらの組も、各欄が上の表のどの行で使われるかを欄の注に書く。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.Definitions

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u v

variable {K : Type u} [Add K] [Mul K] [One K] {V : Type v}

/-- s_{f,g} の必要十分版。 -/
def pointwiseSum (f g : V → K) : V → K := fun x => f x + g x

/-- 本文 `claim_pointwise_sum_of_linear_forms_is_linear_form` の必要十分版。 -/
theorem pointwiseSum_isLinearForm (S : VectorSpace K V)
    (hassoc : ∀ a b c : K, (a + b) + c = a + (b + c))
    (hcomm : ∀ a b : K, a + b = b + a)
    (hldistrib : ∀ a b c : K, a * (b + c) = a * b + a * c)
    {f g : V → K} (hf : IsLinearForm S f) (hg : IsLinearForm S g) :
    IsLinearForm S (pointwiseSum f g) where
  map_add x y := calc
    pointwiseSum f g (S.add x y) = f (S.add x y) + g (S.add x y) := rfl
    _ = (f x + f y) + g (S.add x y) := by rw [hf.map_add x y]
    _ = (f x + f y) + (g x + g y) := by rw [hg.map_add x y]
    _ = f x + (f y + (g x + g y)) := by rw [hassoc (f x) (f y) (g x + g y)]
    _ = f x + ((f y + g x) + g y) := by rw [hassoc (f y) (g x) (g y)]
    _ = f x + ((g x + f y) + g y) := by rw [hcomm (f y) (g x)]
    _ = f x + (g x + (f y + g y)) := by rw [hassoc (g x) (f y) (g y)]
    _ = (f x + g x) + (f y + g y) := by rw [hassoc (f x) (g x) (f y + g y)]
    _ = pointwiseSum f g x + pointwiseSum f g y := rfl
  map_smul l x := calc
    pointwiseSum f g (S.smul l x) = f (S.smul l x) + g (S.smul l x) := rfl
    _ = l * f x + g (S.smul l x) := by rw [hf.map_smul l x]
    _ = l * f x + l * g x := by rw [hg.map_smul l x]
    _ = l * (f x + g x) := by rw [hldistrib l (f x) (g x)]
    _ = l * pointwiseSum f g x := rfl

/-- m_{μ,f} の必要十分版。 -/
def pointwiseScalarMultiple (μ : K) (f : V → K) : V → K := fun x => μ * f x

/-- 本文 `claim_pointwise_scalar_multiple_of_linear_form_is_linear_form` の必要十分版。 -/
theorem pointwiseScalarMultiple_isLinearForm (S : VectorSpace K V)
    (hldistrib : ∀ a b c : K, a * (b + c) = a * b + a * c)
    (hmassoc : ∀ a b c : K, (a * b) * c = a * (b * c))
    (hmcomm : ∀ a b : K, a * b = b * a)
    (μ : K) {f : V → K} (hf : IsLinearForm S f) :
    IsLinearForm S (pointwiseScalarMultiple μ f) where
  map_add x y := calc
    pointwiseScalarMultiple μ f (S.add x y) = μ * f (S.add x y) := rfl
    _ = μ * (f x + f y) := by rw [hf.map_add x y]
    _ = μ * f x + μ * f y := by rw [hldistrib μ (f x) (f y)]
    _ = pointwiseScalarMultiple μ f x + pointwiseScalarMultiple μ f y := rfl
  map_smul l x := calc
    pointwiseScalarMultiple μ f (S.smul l x) = μ * f (S.smul l x) := rfl
    _ = μ * (l * f x) := by rw [hf.map_smul l x]
    _ = (μ * l) * f x := by rw [hmassoc μ l (f x)]
    _ = (l * μ) * f x := by rw [hmcomm μ l]
    _ = l * (μ * f x) := by rw [hmassoc l μ (f x)]
    _ = l * pointwiseScalarMultiple μ f x := rfl

/-- z_V の必要十分版。 -/
def zeroMap [Zero K] : V → K := fun _ => 0

/-- 本文 `claim_zero_map_is_linear_form` の必要十分版。 -/
theorem zeroMap_isLinearForm [Zero K] (S : VectorSpace K V)
    (h00 : (0 : K) + 0 = 0) (hmul0 : ∀ a : K, a * 0 = 0) :
    IsLinearForm S (zeroMap (K := K) (V := V)) where
  map_add x y := calc
    zeroMap (K := K) (S.add x y) = (0 : K) := rfl
    _ = 0 + 0 := by rw [h00]
    _ = zeroMap x + zeroMap y := rfl
  map_smul l x := calc
    zeroMap (K := K) (S.smul l x) = (0 : K) := rfl
    _ = l * 0 := by rw [hmul0 l]
    _ = l * zeroMap x := rfl

/-- 双対空間の演算を定めるのに要る K の性質（三つの主張の仮定を合わせたもの）。 -/
structure DualSpaceOperationLaws (K : Type u) [Add K] [Mul K] [Zero K] : Prop where
  /-- 各点ごとの和（`pointwiseSum_isLinearForm`） -/
  add_assoc : ∀ a b c : K, (a + b) + c = a + (b + c)
  /-- 各点ごとの和 -/
  add_comm : ∀ a b : K, a + b = b + a
  /-- 各点ごとの和とスカラー倍 -/
  left_distrib : ∀ a b c : K, a * (b + c) = a * b + a * c
  /-- 各点ごとのスカラー倍（`pointwiseScalarMultiple_isLinearForm`） -/
  mul_assoc : ∀ a b c : K, (a * b) * c = a * (b * c)
  /-- 各点ごとのスカラー倍 -/
  mul_comm : ∀ a b : K, a * b = b * a
  /-- 零写像（`zeroMap_isLinearForm`） -/
  zero_add_zero : (0 : K) + 0 = 0
  /-- 零写像 -/
  mul_zero : ∀ a : K, a * 0 = 0

/-- 本文 `def_dual_space` の V^* の必要十分版。 -/
abbrev DualSpace (S : VectorSpace K V) : Type (max u v) := {f : V → K // IsLinearForm S f}

namespace DualSpace

variable [Zero K] (L : DualSpaceOperationLaws K) (S : VectorSpace K V)

/-- +_{V^*} の必要十分版。 -/
def add (f g : DualSpace S) : DualSpace S :=
  ⟨pointwiseSum f.1 g.1, pointwiseSum_isLinearForm S L.add_assoc L.add_comm L.left_distrib f.2 g.2⟩

/-- ·_{V^*} の必要十分版。 -/
def smul (μ : K) (f : DualSpace S) : DualSpace S :=
  ⟨pointwiseScalarMultiple μ f.1,
    pointwiseScalarMultiple_isLinearForm S L.left_distrib L.mul_assoc L.mul_comm μ f.2⟩

/-- 0_{V^*} の必要十分版。 -/
def zero : DualSpace S := ⟨zeroMap, zeroMap_isLinearForm S L.zero_add_zero L.mul_zero⟩

variable {S}

omit [Zero K] in
theorem ext {f g : DualSpace S} (h : ∀ x : V, f.1 x = g.1 x) : f = g :=
  Subtype.ext (funext h)

end DualSpace

/-- 双対空間が線型空間であることを示すのに要る K の性質。 -/
structure DualSpaceVectorSpaceLaws (K : Type u) [Add K] [Mul K] [Zero K] [One K] : Prop
    extends DualSpaceOperationLaws K where
  /-- 加法の単位元（継いだ欄 `zero_add_zero` はこの欄の a := 0 だが、演算を定めるだけの主張は
  `DualSpaceOperationLaws` だけを仮定するので、二つを別の欄に置く） -/
  add_zero : ∀ a : K, a + 0 = a
  /-- 加法の逆元：1 + (-1) = 0 となる -1 の存在 -/
  exists_neg_one : ∃ n : K, 1 + n = 0
  /-- 加法の逆元・スカラー倍の単位元 -/
  one_mul : ∀ a : K, 1 * a = a
  /-- 加法の逆元・スカラーの加法についての分配法則 -/
  right_distrib : ∀ a b c : K, (a + b) * c = a * c + b * c
  /-- 加法の逆元 -/
  zero_mul : ∀ a : K, 0 * a = 0

/-- 本文 `claim_dual_space_is_complex_vector_space` の必要十分版。具体版と同じ行で、K の性質は `L` の欄で当てる。 -/
def dualSpaceVectorSpace [Zero K] (L : DualSpaceVectorSpaceLaws K) (S : VectorSpace K V) :
    VectorSpace K (DualSpace S) where
  add := DualSpace.add L.toDualSpaceOperationLaws S
  smul := DualSpace.smul L.toDualSpaceOperationLaws S
  zero := DualSpace.zero L.toDualSpaceOperationLaws S
  add_assoc f g h := DualSpace.ext fun x => calc
    (DualSpace.add L.toDualSpaceOperationLaws S (DualSpace.add L.toDualSpaceOperationLaws S f g) h).1 x
        = pointwiseSum (DualSpace.add L.toDualSpaceOperationLaws S f g).1 h.1 x := rfl
    _ = (DualSpace.add L.toDualSpaceOperationLaws S f g).1 x + h.1 x := rfl
    _ = pointwiseSum f.1 g.1 x + h.1 x := rfl
    _ = (f.1 x + g.1 x) + h.1 x := rfl
    _ = f.1 x + (g.1 x + h.1 x) := by rw [L.add_assoc (f.1 x) (g.1 x) (h.1 x)]
    _ = f.1 x + pointwiseSum g.1 h.1 x := rfl
    _ = f.1 x + (DualSpace.add L.toDualSpaceOperationLaws S g h).1 x := rfl
    _ = pointwiseSum f.1 (DualSpace.add L.toDualSpaceOperationLaws S g h).1 x := rfl
    _ = (DualSpace.add L.toDualSpaceOperationLaws S f (DualSpace.add L.toDualSpaceOperationLaws S g h)).1 x := rfl
  add_comm f g := DualSpace.ext fun x => calc
    (DualSpace.add L.toDualSpaceOperationLaws S f g).1 x = pointwiseSum f.1 g.1 x := rfl
    _ = f.1 x + g.1 x := rfl
    _ = g.1 x + f.1 x := by rw [L.add_comm (f.1 x) (g.1 x)]
    _ = pointwiseSum g.1 f.1 x := rfl
    _ = (DualSpace.add L.toDualSpaceOperationLaws S g f).1 x := rfl
  add_zero f := DualSpace.ext fun x => calc
    (DualSpace.add L.toDualSpaceOperationLaws S f (DualSpace.zero L.toDualSpaceOperationLaws S)).1 x = pointwiseSum f.1 (DualSpace.zero L.toDualSpaceOperationLaws S).1 x := rfl
    _ = f.1 x + (DualSpace.zero L.toDualSpaceOperationLaws S).1 x := rfl
    _ = f.1 x + zeroMap x := rfl
    _ = f.1 x + 0 := rfl
    _ = f.1 x := by rw [L.add_zero (f.1 x)]
  exists_add_inverse f := by
    obtain ⟨n, hn⟩ := L.exists_neg_one
    exact ⟨DualSpace.smul L.toDualSpaceOperationLaws S n f, DualSpace.ext fun x => calc
      (DualSpace.add L.toDualSpaceOperationLaws S f (DualSpace.smul L.toDualSpaceOperationLaws S n f)).1 x
          = pointwiseSum f.1 (DualSpace.smul L.toDualSpaceOperationLaws S n f).1 x := rfl
      _ = f.1 x + (DualSpace.smul L.toDualSpaceOperationLaws S n f).1 x := rfl
      _ = f.1 x + pointwiseScalarMultiple n f.1 x := rfl
      _ = f.1 x + n * f.1 x := rfl
      _ = 1 * f.1 x + n * f.1 x := by rw [L.one_mul (f.1 x)]
      _ = (1 + n) * f.1 x := by rw [L.right_distrib 1 n (f.1 x)]
      _ = 0 * f.1 x := by rw [hn]
      _ = 0 := by rw [L.zero_mul (f.1 x)]
      _ = zeroMap x := rfl
      _ = (DualSpace.zero L.toDualSpaceOperationLaws S).1 x := rfl⟩
  smul_assoc l μ f := DualSpace.ext fun x => calc
    (DualSpace.smul L.toDualSpaceOperationLaws S (l * μ) f).1 x = pointwiseScalarMultiple (l * μ) f.1 x := rfl
    _ = (l * μ) * f.1 x := rfl
    _ = l * (μ * f.1 x) := by rw [L.mul_assoc l μ (f.1 x)]
    _ = l * pointwiseScalarMultiple μ f.1 x := rfl
    _ = l * (DualSpace.smul L.toDualSpaceOperationLaws S μ f).1 x := rfl
    _ = pointwiseScalarMultiple l (DualSpace.smul L.toDualSpaceOperationLaws S μ f).1 x := rfl
    _ = (DualSpace.smul L.toDualSpaceOperationLaws S l (DualSpace.smul L.toDualSpaceOperationLaws S μ f)).1 x := rfl
  one_smul f := DualSpace.ext fun x => calc
    (DualSpace.smul L.toDualSpaceOperationLaws S 1 f).1 x = pointwiseScalarMultiple 1 f.1 x := rfl
    _ = 1 * f.1 x := rfl
    _ = f.1 x := by rw [L.one_mul (f.1 x)]
  smul_add l f g := DualSpace.ext fun x => calc
    (DualSpace.smul L.toDualSpaceOperationLaws S l (DualSpace.add L.toDualSpaceOperationLaws S f g)).1 x
        = pointwiseScalarMultiple l (DualSpace.add L.toDualSpaceOperationLaws S f g).1 x := rfl
    _ = l * (DualSpace.add L.toDualSpaceOperationLaws S f g).1 x := rfl
    _ = l * pointwiseSum f.1 g.1 x := rfl
    _ = l * (f.1 x + g.1 x) := rfl
    _ = l * f.1 x + l * g.1 x := by rw [L.left_distrib l (f.1 x) (g.1 x)]
    _ = pointwiseScalarMultiple l f.1 x + pointwiseScalarMultiple l g.1 x := rfl
    _ = (DualSpace.smul L.toDualSpaceOperationLaws S l f).1 x + (DualSpace.smul L.toDualSpaceOperationLaws S l g).1 x := rfl
    _ = pointwiseSum (DualSpace.smul L.toDualSpaceOperationLaws S l f).1 (DualSpace.smul L.toDualSpaceOperationLaws S l g).1 x := rfl
    _ = (DualSpace.add L.toDualSpaceOperationLaws S (DualSpace.smul L.toDualSpaceOperationLaws S l f) (DualSpace.smul L.toDualSpaceOperationLaws S l g)).1 x := rfl
  add_smul l μ f := DualSpace.ext fun x => calc
    (DualSpace.smul L.toDualSpaceOperationLaws S (l + μ) f).1 x = pointwiseScalarMultiple (l + μ) f.1 x := rfl
    _ = (l + μ) * f.1 x := rfl
    _ = l * f.1 x + μ * f.1 x := by rw [L.right_distrib l μ (f.1 x)]
    _ = pointwiseScalarMultiple l f.1 x + pointwiseScalarMultiple μ f.1 x := rfl
    _ = (DualSpace.smul L.toDualSpaceOperationLaws S l f).1 x + (DualSpace.smul L.toDualSpaceOperationLaws S μ f).1 x := rfl
    _ = pointwiseSum (DualSpace.smul L.toDualSpaceOperationLaws S l f).1 (DualSpace.smul L.toDualSpaceOperationLaws S μ f).1 x := rfl
    _ = (DualSpace.add L.toDualSpaceOperationLaws S (DualSpace.smul L.toDualSpaceOperationLaws S l f) (DualSpace.smul L.toDualSpaceOperationLaws S μ f)).1 x := rfl

end CliffordMatrixIsomorphism.NecSuf.VectorSpace
