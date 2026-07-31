/-
# 抽象版: 共役写像は環準同型

**このファイルには抽象版だけを置く。抽象版は Lean の中だけの道具であり、
人手証明の本文にも参照用ノートにも持ち込まない**
（`exact-solution-of-2d-ising-model/README.md` 4 節）。

対応する人手証明:
`parts/000_計算公式/045_claim_共役写像は環準同型.typ`
(`<conjugation_is_ring_homomorphism>`)

| 人手証明のラベル | 具体版（複素行列） |
| --- | --- |
| `<conjugation_is_ring_homomorphism>` | `Ising2D/Part000/Claim045_ConjugationIsRingHom.lean`（原文と同じ形の直接証明）と `Ising2D/Part000/Claim045_ConjugationIsRingHomAbstract.lean`（本ファイルからの特殊化） |

## 抽象版が何を明らかにするか

原文の主張は「`B ∈ (Mat(n,ℂ))^×` について `T_B(A) = B A B⁻¹` は
(1) 乗法的 (2) 単位的 (3) 合成則 `T_A ∘ T_B = T_{AB}` を満たす」である。
本ファイルは、この 3 つに**環であることも、そもそも逆元の存在（両側性）も
必要でない**ことを、型クラスの段階で切り分けて示す。

* **積を「両側から挟む」だけの写像** `sandwich b u a = b * a * u` を、
  逆元も単位元も持たない `Mul` の段階で定義する。
  - **(3) 合成則には可逆性が一切効いていない。** `sandwich a v ∘ sandwich b u = sandwich (a b) (u v)`
    は **結合法則だけ**（`Semigroup`）で成り立つ（`sandwich_sandwich`）。
    原文 Step 3 が `(AB)⁻¹ = B⁻¹A⁻¹` を経由しているのは、右因子を `b⁻¹` に固定して
    述べているためであり、逆元は「合成した右因子 `u v` を `(ab)⁻¹` と**呼び直す**」ためにしか
    使われていない。
  - **(1) 乗法性に効くのは右因子が左逆元であること `u * b = 1` だけ**である
    （`sandwich_mul_of_left_inv`）。原文 Step 1 が使っているのも `B⁻¹B = I` の側だけである。
  - **(2) 単位性に効くのは右因子が右逆元であること `b * u = 1` だけ**である
    （`sandwich_one_of_right_inv`）。原文 Step 2 が使っているのも `BB⁻¹ = I` の側だけである。
  - **(1)(2)(3) はどれも加法を使わない。** したがって環である必要はなく、
    **モノイドとその単元群だけで足りる**（`conj_mul` / `conj_one` / `conj_conj`）。
* **加法性（＝「環準同型」であること）にだけ分配法則が要る。**
  しかも加法性には可逆性すら要らない（`sandwich_add`、仮定は
  `NonUnitalNonAssocSemiring`）。原文が「環準同型」と呼ぶための構造のうち、
  環の加法が効いているのはこの 1 点だけである。
* **(3) 合成則の内容は「`b ↦ T_b` が単元群 `Mˣ` からモノイド自己同型群 `MulAut M` への
  群準同型である」ことに集約される**（`conjAut`）。環の場合はその係数として
  `Rˣ →* RingAut R` になる（`conjRingAut`）。
-/
import Mathlib.Algebra.Group.Aut
import Mathlib.Algebra.Ring.Aut
import Mathlib.Algebra.Ring.Hom.Defs
import Mathlib.Algebra.Group.Units.Defs

namespace Ising2D
namespace Abstract

/-! ## 逆元を仮定しない部分: 「両側から挟む」写像 -/

section Mul

variable {M : Type*} [Mul M]

/-- 両側から挟む写像 `a ↦ b * a * u`。
共役写像 `T_B` は `u` を `b` の逆元にとった特別な場合である。
逆元も単位元も要求しない段階で定義しておくことで、
「共役写像のどの性質に可逆性が効いているのか」を切り分けられる。 -/
def sandwich (b u a : M) : M := b * a * u

theorem sandwich_apply (b u a : M) : sandwich b u a = b * a * u := rfl

end Mul

section Semigroup

variable {M : Type*} [Semigroup M]

/-- **原文 (3) 合成則の本体（可逆性は一切不要）**。

`sandwich a v ∘ sandwich b u = sandwich (a b) (u v)`。使うのは**結合法則だけ**である。
原文 Step 3 の `(AB)⁻¹ = B⁻¹A⁻¹` は、右因子 `u v = B⁻¹A⁻¹` を `(AB)⁻¹` と呼び直すために
使われているにすぎない。 -/
theorem sandwich_sandwich (a v b u x : M) :
    sandwich a v (sandwich b u x) = sandwich (a * b) (u * v) x := by
  simp only [sandwich, mul_assoc]

end Semigroup

section Monoid

variable {M : Type*} [Monoid M]

/-- **原文 (1) 乗法性の本体**。効いているのは `u * b = 1`（右因子が `b` の**左**逆元であること）
だけであり、`b * u = 1`（右逆元であること）は使わない。 -/
theorem sandwich_mul_of_left_inv {b u : M} (h : u * b = 1) (a c : M) :
    sandwich b u (a * c) = sandwich b u a * sandwich b u c := by
  simp only [sandwich]
  calc b * (a * c) * u = b * a * (u * b) * c * u := by rw [h]; simp only [mul_one, mul_assoc]
    _ = b * a * u * (b * c * u) := by simp only [mul_assoc]

/-- **原文 (2) 単位性の本体**。効いているのは `b * u = 1`（右因子が `b` の**右**逆元であること）
だけであり、`u * b = 1`（左逆元であること）は使わない。 -/
theorem sandwich_one_of_right_inv {b u : M} (h : b * u = 1) : sandwich b u (1 : M) = 1 := by
  simp only [sandwich, mul_one, h]

/-! ### 単元による共役写像 -/

/-- 共役写像 `T_b(a) = b a b⁻¹`（`b` はモノイド `M` の単元）。
原文の `T_B` はここで `M = Mat(n,ℂ)` としたものである。 -/
def conj (b : Mˣ) (a : M) : M := sandwich (b : M) ((b⁻¹ : Mˣ) : M) a

theorem conj_apply (b : Mˣ) (a : M) : conj b a = (b : M) * a * ((b⁻¹ : Mˣ) : M) := rfl

/-- **(1) 乗法的**: `T_b(a c) = T_b(a) T_b(c)`。単元性のうち左逆元の側しか使わない。 -/
theorem conj_mul (b : Mˣ) (a c : M) : conj b (a * c) = conj b a * conj b c :=
  sandwich_mul_of_left_inv b.inv_mul a c

/-- **(2) 単位的**: `T_b(1) = 1`。単元性のうち右逆元の側しか使わない。 -/
theorem conj_one (b : Mˣ) : conj b (1 : M) = 1 :=
  sandwich_one_of_right_inv b.mul_inv

@[simp]
theorem conj_one_left (a : M) : conj (1 : Mˣ) a = a := by
  simp [conj, sandwich]

/-- **(3) 合成則（各点版）**: `T_a(T_b(x)) = T_{a b}(x)`。
中身は結合法則だけの `sandwich_sandwich` であり、逆元は右因子の呼び直しにしか使わない。 -/
theorem conj_conj (a b : Mˣ) (x : M) : conj a (conj b x) = conj (a * b) x := by
  simp only [conj, sandwich_sandwich, mul_inv_rev, Units.val_mul]

/-- **(3) 合成則（原文と同じ写像の合成の形）**: `T_a ∘ T_b = T_{a b}`。 -/
theorem conj_comp (a b : Mˣ) : conj a ∘ conj b = conj (a * b) :=
  funext fun x => conj_conj a b x

/-- **(3) 合成則の集約形**: `b ↦ T_b` は単元群 `Mˣ` からモノイド自己同型群 `MulAut M` への
**群準同型**である。

原文の (1) 乗法性は「各 `T_b` が乗法を保つこと」、(3) 合成則は「この対応が群準同型であること」に
それぞれ対応する。ここまでに環の加法は一切使っていない。 -/
def conjAut : Mˣ →* MulAut M where
  toFun b :=
    { toFun := conj b
      invFun := conj b⁻¹
      left_inv := fun x => by simp [conj_conj]
      right_inv := fun x => by simp [conj_conj]
      map_mul' := conj_mul b }
  map_one' := by ext x; simp
  map_mul' a b := by ext x; simpa using (conj_conj a b x).symm

@[simp]
theorem conjAut_apply (b : Mˣ) (x : M) : conjAut b x = conj b x := rfl

end Monoid

/-! ## 加法性: ここだけに分配法則が要る -/

section Distrib

variable {R : Type*} [NonUnitalNonAssocSemiring R]

/-- **加法性の本体**。効いているのは**分配法則だけ**で、可逆性も結合法則も単位元も要らない。
原文が「環準同型」と呼ぶために環の加法が必要になるのは、この 1 点だけである。 -/
theorem sandwich_add (b u a c : R) :
    sandwich b u (a + c) = sandwich b u a + sandwich b u c := by
  simp [sandwich, add_mul, mul_add]

theorem sandwich_zero (b u : R) : sandwich b u (0 : R) = 0 := by
  simp [sandwich]

end Distrib

section Semiring

variable {R : Type*} [Semiring R]

theorem conj_add (b : Rˣ) (a c : R) : conj b (a + c) = conj b a + conj b c :=
  sandwich_add _ _ a c

theorem conj_zero (b : Rˣ) : conj b (0 : R) = 0 :=
  sandwich_zero _ _

/-- 共役写像を半環準同型としてまとめたもの
（(1) 乗法性・(2) 単位性 ＋ 分配法則から来る加法性）。 -/
def conjRingHom (b : Rˣ) : R →+* R where
  toFun := conj b
  map_one' := conj_one b
  map_mul' := conj_mul b
  map_zero' := conj_zero b
  map_add' := conj_add b

@[simp]
theorem coe_conjRingHom (b : Rˣ) : ⇑(conjRingHom b) = conj b := rfl

/-- **(3) 合成則の集約形（環版）**: `b ↦ T_b` は `Rˣ` から環自己同型群 `RingAut R` への
群準同型である。`conjAut`（モノイド版）に加法性を足しただけで、
新たに効いている構造は分配法則だけである。 -/
def conjRingAut : Rˣ →* RingAut R where
  toFun b :=
    { toFun := conj b
      invFun := conj b⁻¹
      left_inv := fun x => by simp [conj_conj]
      right_inv := fun x => by simp [conj_conj]
      map_mul' := conj_mul b
      map_add' := conj_add b }
  map_one' := by ext x; simp
  map_mul' a b := by ext x; simpa using (conj_conj a b x).symm

@[simp]
theorem conjRingAut_apply (b : Rˣ) (x : R) : conjRingAut b x = conj b x := rfl

end Semiring

end Abstract
end Ising2D
