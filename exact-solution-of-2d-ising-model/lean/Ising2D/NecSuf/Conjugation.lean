/-
# 必要十分版: 共役写像（挟み込み写像）の乗法性・単位性・合成則

**このファイルには必要十分版だけを置く。必要十分版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明のラベル:

| 人手証明のラベル | 具体版（複素行列） |
| --- | --- |
| `<conjugation_is_ring_homomorphism>` | `Ising2D/Part000/Claim045_ConjugationIsRingHom.lean` |

本ファイルの必要十分版から具体版（`Mat(n,ℂ)` と `Matrix.inv` による共役）を系として導出したものは
`Ising2D/Part000/Claim045_ConjugationIsRingHomFromNecSuf.lean` にある。

## 必要十分版が何を明らかにするか

原文 `<conjugation_is_ring_homomorphism>` は `B ∈ (Mat(n,ℂ))^×` に対する
`T_B(A) = B A B⁻¹` について (1) 乗法性・(2) 単位性・(3) 合成則を述べている。
このうち **(1)(2)(3) には「環である」ことが要らない。** 必要なのは結合律と単位元、
すなわちモノイドの構造だけである。分配法則が要るのは加法性（環準同型であること）だけであり、
しかも加法性の側は逆に**可逆性を一切使わない**。

そこで本ファイルでは共役写像を、逆元を先に固定しない「挟み込み写像」

  `sandwich b u : a ↦ b * a * u`

として定義し、各性質がどの仮定で成立するかを分離して述べる。

| 性質 | 必要な代数構造 | `b, u` に必要な関係 |
| --- | --- | --- |
| 合成則 `sandwich a a' ∘ sandwich b b' = sandwich (a*b) (b'*a')` | 半群（結合律のみ） | **不要** |
| 乗法性 `T(ac) = T(a)T(c)` | モノイド | `u * b = 1`（左逆元のみ） |
| 単位性 `T(1) = 1` | モノイド | `b * u = 1`（右逆元のみ） |
| 加法性 `T(a+c) = T(a)+T(c)` | 半環（分配法則） | **不要** |
| 全単射（自己同型） | モノイド | 両側（真の可逆性） |

片側逆元では足りないことは推測ではなく、`Function.End ℕ` の中に反例を作って
Lean で証明してある（`sandwich_mul_needs_left_inv` / `sandwich_one_needs_right_inv`）。

そして合成則 (3) は、単独の等式としてではなく
**「`b ↦ T_b` が単元群 `Mˣ` からモノイド自己同型群 `MulAut M` への群準同型である」**
という一つの主張（`conjMulAutHom`）に集約される。原文の Step 3 が確認している
`(AB)⁻¹ = B⁻¹A⁻¹` は、この群準同型性の中に吸収される（`Units` の逆元がすでにその性質を持つ）。
-/
import Mathlib.Algebra.Group.End
import Mathlib.Algebra.Ring.Aut
import Mathlib.Algebra.Group.Units.Defs
import Mathlib.Algebra.Ring.Defs

namespace Ising2D.NecSuf

namespace Conj

/-- **挟み込み写像** `a ↦ b * a * u`。

原文の共役写像 `T_B(A) = B A B⁻¹` は `u = b⁻¹` の場合にあたる。
逆元を先に固定せずに `u` を独立の引数として持つことで、各性質が
`b, u` のどの関係に依存しているかを分離できる。 -/
def sandwich {M : Type*} [Mul M] (b u : M) (a : M) : M := b * a * u

section Semigroup

variable {M : Type*} [Semigroup M]

/-- **(3) 合成則（可逆性は不要）**: 挟み込みの合成はふたたび挟み込みであり、
外側の元は左から、内側の元は右から並ぶ。

`sandwich a a' (sandwich b b' x) = sandwich (a*b) (b'*a') x`。

**結合律しか使っていない。** 単位元も逆元も要らない。
原文 Step 3 が `(AB)⁻¹ = B⁻¹A⁻¹` を確認しているのは、右側に現れる `b'*a'` を
`(ab)` の逆元と読み替えるためであって、合成則そのものには可逆性が効いていない。 -/
theorem sandwich_comp (a a' b b' x : M) :
    sandwich a a' (sandwich b b' x) = sandwich (a * b) (b' * a') x := by
  simp only [sandwich, mul_assoc]

end Semigroup

section Monoid

variable {M : Type*} [Monoid M]

/-- **(1) 乗法性**: 必要なのは `u * b = 1`（`u` が `b` の**左**逆元であること）だけ。

`b * (a*c) * u = (b*a*u) * (b*c*u)`。真ん中で `u * b` が消えることだけが効いている。 -/
theorem sandwich_mul {b u : M} (h : u * b = 1) (a c : M) :
    sandwich b u (a * c) = sandwich b u a * sandwich b u c := by
  calc sandwich b u (a * c)
      = b * a * c * u := by simp only [sandwich, mul_assoc]
    _ = b * a * (u * b) * c * u := by rw [h]; simp only [mul_one]
    _ = sandwich b u a * sandwich b u c := by simp only [sandwich, mul_assoc]

/-- **(2) 単位性**: 必要なのは `b * u = 1`（`u` が `b` の**右**逆元であること）だけ。 -/
theorem sandwich_one {b u : M} (h : b * u = 1) : sandwich b u (1 : M) = 1 := by
  simp only [sandwich, mul_one, h]

/-- 単元 `b : Mˣ` による共役写像を、**モノイド準同型**としてまとめたもの。
これが (1) と (2) を同時に主張している（両側逆元が必要なのはここで初めて）。 -/
def conjMonoidHom (b : Mˣ) : M →* M where
  toFun := sandwich (b : M) ((b⁻¹ : Mˣ) : M)
  map_one' := sandwich_one b.mul_inv
  map_mul' := sandwich_mul b.inv_mul

@[simp]
theorem conjMonoidHom_apply (b : Mˣ) (a : M) :
    conjMonoidHom b a = (b : M) * a * ((b⁻¹ : Mˣ) : M) := rfl

/-- 共役写像はモノイドの**自己同型**である（逆写像は `b⁻¹` による共役）。
ここで初めて可逆性が両側とも本質的に効く。 -/
def conjMulAut (b : Mˣ) : MulAut M where
  toFun := conjMonoidHom b
  invFun := conjMonoidHom b⁻¹
  left_inv a := by
    simp only [conjMonoidHom_apply, inv_inv]
    calc ((b⁻¹ : Mˣ) : M) * ((b : M) * a * ((b⁻¹ : Mˣ) : M)) * (b : M)
        = ((b⁻¹ : Mˣ) : M) * (b : M) * a * (((b⁻¹ : Mˣ) : M) * (b : M)) := by
          simp only [mul_assoc]
      _ = a := by rw [b.inv_mul]; simp
  right_inv a := by
    simp only [conjMonoidHom_apply, inv_inv]
    calc (b : M) * (((b⁻¹ : Mˣ) : M) * a * (b : M)) * ((b⁻¹ : Mˣ) : M)
        = (b : M) * ((b⁻¹ : Mˣ) : M) * a * ((b : M) * ((b⁻¹ : Mˣ) : M)) := by
          simp only [mul_assoc]
      _ = a := by rw [b.mul_inv]; simp
  map_mul' := (conjMonoidHom b).map_mul'

@[simp]
theorem conjMulAut_apply (b : Mˣ) (a : M) :
    conjMulAut b a = (b : M) * a * ((b⁻¹ : Mˣ) : M) := rfl

/-- **合成則 (3) の最終形**: `b ↦ T_b` は単元群からモノイド自己同型群への**群準同型**である。

原文が (3) として述べている `T_A ∘ T_B = T_{AB}` は、この準同型性 `map_mul` そのものである。
環である必要も、係数体も、行列であることも効いていない。 -/
def conjMulAutHom : Mˣ →* MulAut M where
  toFun := conjMulAut
  map_one' := by
    ext a
    simp
  map_mul' a b := by
    ext x
    simp only [conjMulAut_apply, MulAut.mul_apply, Units.val_mul, mul_inv_rev, conjMulAut_apply]
    simp only [mul_assoc]

@[simp]
theorem conjMulAutHom_apply (b : Mˣ) (a : M) :
    conjMulAutHom b a = (b : M) * a * ((b⁻¹ : Mˣ) : M) := rfl

/-- (3) を各点の等式として書き下した版（原文 `T_A ∘ T_B = T_{AB}` に対応）。 -/
theorem conjMonoidHom_comp (a b : Mˣ) :
    (conjMonoidHom (M := M) a).comp (conjMonoidHom b) = conjMonoidHom (a * b) := by
  ext x
  simp only [MonoidHom.coe_comp, Function.comp_apply, conjMonoidHom_apply, Units.val_mul,
    mul_inv_rev]
  simp only [mul_assoc]

end Monoid

section Counterexamples

/-- 乗法性 (1) に `u * b = 1`（左逆元）が**本当に必要**であることの反例。

`b * u = 1`（右逆元）だけを満たす組では乗法性が破れる。台は `Function.End ℕ`
（写像の合成をかけ算とするモノイド）で、`b` は「1 引く」、`u` は「1 足す」である。 -/
theorem sandwich_mul_needs_left_inv :
    ∃ b u a c : Function.End ℕ,
      b * u = 1 ∧ sandwich b u (a * c) ≠ sandwich b u a * sandwich b u c := by
  refine ⟨fun n => n - 1, fun n => n + 1, fun n => 2 * n, fun _ => 0, ?_, ?_⟩
  · funext n
    show n + 1 - 1 = n
    omega
  · intro h
    -- 左辺を `0` に、右辺を `0` に適用すると `0 = 1` になる。
    have h0 : (0 : ℕ) = 1 := congrFun h 0
    exact absurd h0 (by decide)

/-- 単位性 (2) に `b * u = 1`（右逆元）が**本当に必要**であることの反例。

`u * b = 1`（左逆元）だけを満たす組では単位性が破れる。 -/
theorem sandwich_one_needs_right_inv :
    ∃ b u : Function.End ℕ, u * b = 1 ∧ sandwich b u (1 : Function.End ℕ) ≠ 1 := by
  refine ⟨fun n => n + 1, fun n => n - 1, ?_, ?_⟩
  · funext n
    show n + 1 - 1 = n
    omega
  · intro h
    have h0 : (1 : ℕ) = 0 := congrFun h 0
    exact absurd h0 (by decide)

end Counterexamples

section Semiring

variable {R : Type*} [Semiring R]

/-- **加法性**: 分配法則だけで従い、**可逆性を一切使わない**。
原文が「環準同型」と呼ぶために必要なのはこの 1 本であり、
(1)(2)(3) はモノイドの範囲で足りる。 -/
theorem sandwich_add (b u a c : R) :
    sandwich b u (a + c) = sandwich b u a + sandwich b u c := by
  simp only [sandwich, mul_add, add_mul]

end Semiring

section Ring

variable {R : Type*} [Semiring R]

/-- 単元による共役を**半環準同型**としてまとめたもの
（乗法性・単位性はモノイド版から、加法性は分配法則から）。 -/
def conjRingHom (b : Rˣ) : R →+* R where
  toFun := sandwich (b : R) ((b⁻¹ : Rˣ) : R)
  map_one' := sandwich_one b.mul_inv
  map_mul' := sandwich_mul b.inv_mul
  map_zero' := by simp [sandwich]
  map_add' := sandwich_add _ _

@[simp]
theorem conjRingHom_apply (b : Rˣ) (a : R) :
    conjRingHom b a = (b : R) * a * ((b⁻¹ : Rˣ) : R) := rfl

/-- 共役は半環の自己同型であり、`b ↦ T_b` は群準同型 `Rˣ →* RingAut R` である。
モノイド版 `conjMulAutHom` に加法性を足しただけで、合成則の中身は同じである。 -/
def conjRingAut (b : Rˣ) : RingAut R where
  toFun := conjRingHom b
  invFun := conjRingHom b⁻¹
  left_inv := (conjMulAut b).left_inv
  right_inv := (conjMulAut b).right_inv
  map_mul' := (conjRingHom b).map_mul'
  map_add' := (conjRingHom b).map_add'

@[simp]
theorem conjRingAut_apply (b : Rˣ) (a : R) :
    conjRingAut b a = (b : R) * a * ((b⁻¹ : Rˣ) : R) := rfl

/-- 共役は半環の自己同型であり、`b ↦ T_b` は群準同型 `Rˣ →* RingAut R` である。
モノイド版 `conjMulAutHom` に加法性を足しただけで、合成則の中身は同じである。 -/
def conjRingAutHom : Rˣ →* RingAut R where
  toFun := conjRingAut
  map_one' := by ext a; simp
  map_mul' a b := by
    have key : ∀ x : R, conjRingAut (a * b) x = conjRingAut a (conjRingAut b x) := by
      intro x
      simp only [conjRingAut_apply, Units.val_mul, mul_inv_rev]
      simp only [mul_assoc]
    ext x
    exact key x

@[simp]
theorem conjRingAutHom_apply (b : Rˣ) (a : R) :
    conjRingAutHom b a = (b : R) * a * ((b⁻¹ : Rˣ) : R) := rfl

end Ring

end Conj

end Ising2D.NecSuf
