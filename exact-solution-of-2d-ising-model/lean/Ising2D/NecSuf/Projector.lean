/-
# 必要十分版: 対合から作る射影子と、セクター上での因子の置き換え

対応する人手証明のラベル: **`epsilon_projector_properties`** / **`sector_replacement_of_V1`** / **`sector_replacement_pow`**
（具体版は `Ising2D/Part010/Claim009_EpsilonProjectors.lean` と
`Ising2D/Part010/Claim011_SectorReplacement.lean`）

## この主張に本質的に効いている構造は何か

人手証明は `ε = σ^x_1 ⋯ σ^x_M`（Jordan–Wigner 文字列の積）という具体的な行列について
`P^{(±)} = (I ± ε)/2` の性質と、セクター上での `V_1 → V_1^{(±)}` の置き換えを示している。
Lean で抽象化してみると、効いているのは次だけである。

* **射影子の性質（`epsilon_projector_properties` (1)(2)(3)）**: `ε` が対合であること
  `e * e = 1` と、係数環で `2` が可逆であることだけ。`ε` が Pauli 行列の積であることも、
  行列であることも、複素数であることも、環が可換であることも効いていない
  （**任意の環 + `Invertible 2`**）。
* **セクター上の置き換えの冪（`sector_replacement_pow`）**: 効いているのは
  「`P` が冪等」「`P` が `a, b, a'` と可換」「`a P = a' P`」の 3 点だけで、
  `P` が `(1 ± e)/2` の形であることすら使わない。つまり「偶奇セクター」という言葉が
  持つ情報のうち、この段で実際に使われているのは**冪等元と可換性**だけである。
* **対称形の分解（`partition_function_sector_decomposition` の Step 3）**:
  `B (B V B)^n = (B B V)^n B` は結合法則だけで成り立つ
  （原文が「結合法則で括り直すだけ」と書いているとおり）。
-/
import Mathlib.Algebra.Group.Commute.Defs
import Mathlib.Algebra.Ring.Invertible
import Mathlib.Tactic.NoncommRing

namespace Ising2D.NecSuf

variable {R : Type*} [Ring R]

section Projector

variable [Invertible (2 : R)]

/-- 対合 `e`（`e * e = 1`）から作る射影子 `(1 + e)/2`。
人手証明の `P^{(+)}` は `e = ε`、`P^{(-)}` は `e = -ε` にあたる。 -/
def invProj (e : R) : R := ⅟(2 : R) * (1 + e)

/-- `⅟2` はどの元とも可換（`2 = 1 + 1` が中心にあるから）。 -/
theorem commute_invOf_two (a : R) : Commute (⅟(2 : R)) a := by
  have h2 : Commute (2 : R) a := by
    have h : (2 : R) = 1 + 1 := by norm_num
    rw [h]
    exact (Commute.one_left a).add_left (Commute.one_left a)
  exact h2.invOf_left

/-- **原文 (3) の `P^{(+)} + P^{(-)} = I`。** -/
theorem invProj_add_invProj_neg (e : R) : invProj e + invProj (-e) = 1 := by
  rw [invProj, invProj, ← mul_add]
  have h : (1 + e) + (1 + -e) = 2 := by
    rw [show (2 : R) = 1 + 1 by norm_num]
    abel
  rw [h, invOf_mul_self]

/-- **原文 (2) の前半 `(P^{(±)})^2 = P^{(±)}`。** -/
theorem invProj_sq {e : R} (he : e * e = 1) : invProj e * invProj e = invProj e := by
  have hexp : (1 + e) * (1 + e) = 2 * (1 + e) := by
    have h1 : (1 + e) * (1 + e) = 1 + e + (e + e * e) := by noncomm_ring
    rw [h1, he]
    noncomm_ring
  calc invProj e * invProj e
      = ⅟(2 : R) * (⅟(2 : R) * ((1 + e) * (1 + e))) := by
        rw [invProj, mul_assoc, ← mul_assoc (1 + e) (⅟(2 : R)),
          ← (commute_invOf_two (1 + e)).eq, mul_assoc]
    _ = ⅟(2 : R) * (⅟(2 : R) * (2 * (1 + e))) := by rw [hexp]
    _ = invProj e := by
        rw [← mul_assoc (⅟(2 : R)) 2 (1 + e), invOf_mul_self, one_mul, invProj]

/-- **原文 (2) の後半 `P^{(+)}P^{(-)} = 0`。** -/
theorem invProj_mul_invProj_neg {e : R} (he : e * e = 1) :
    invProj e * invProj (-e) = 0 := by
  have hexp : (1 + e) * (1 + -e) = 0 := by
    have h1 : (1 + e) * (1 + -e) = 1 + -e + (e + -(e * e)) := by noncomm_ring
    rw [h1, he]
    abel
  calc invProj e * invProj (-e)
      = ⅟(2 : R) * (⅟(2 : R) * ((1 + e) * (1 + -e))) := by
        rw [invProj, invProj, mul_assoc, ← mul_assoc (1 + e) (⅟(2 : R)),
          ← (commute_invOf_two (1 + e)).eq, mul_assoc]
    _ = 0 := by rw [hexp, mul_zero, mul_zero]

/-- `a` が `e` と可換なら射影子とも可換（原文 Step 5）。 -/
theorem commute_invProj {a e : R} (h : Commute a e) : Commute a (invProj e) := by
  rw [invProj]
  exact (commute_invOf_two a).symm.mul_right ((Commute.one_right a).add_right h)

end Projector

/-! ## セクター上での因子の置き換え -/

/-- **人手本文 `sector_replacement_pow` の必要十分版。**

冪等元 `P` が `a, b, a'` と可換で `a P = a' P` なら `(a b)^n P = (a' b)^n P`。 -/
theorem pow_mul_proj {P a b a' : R} (hP : P * P = P)
    (haP : Commute a P) (hbP : Commute b P) (ha'P : Commute a' P)
    (h : a * P = a' * P) : ∀ n : ℕ, (a * b) ^ n * P = (a' * b) ^ n * P
  | 0 => by simp
  | n + 1 => by
      have hX : Commute ((a' * b) ^ n) P := (Commute.mul_left ha'P hbP).pow_left n
      have ih : (a * b) ^ n * P = (a' * b) ^ n * P :=
        pow_mul_proj hP haP hbP ha'P h n
      set Y : R := (a' * b) ^ n * P with hYdef
      have hPY : P * Y = Y := by
        rw [hYdef, ← mul_assoc, ← hX.eq, mul_assoc, hP]
      have hstep : a * (b * Y) = a' * (b * Y) := by
        calc a * (b * Y) = a * (b * (P * Y)) := by rw [hPY]
          _ = (a * P) * (b * Y) := by
              rw [← mul_assoc b P Y, hbP.eq, mul_assoc P b Y, ← mul_assoc a P (b * Y)]
          _ = (a' * P) * (b * Y) := by rw [h]
          _ = a' * (b * (P * Y)) := by
              rw [mul_assoc a' P (b * Y), ← mul_assoc P b Y, ← hbP.eq, mul_assoc b P Y]
          _ = a' * (b * Y) := by rw [hPY]
      calc (a * b) ^ (n + 1) * P
          = a * (b * ((a * b) ^ n * P)) := by rw [pow_succ']; simp only [mul_assoc]
        _ = a * (b * Y) := by rw [ih]
        _ = a' * (b * Y) := hstep
        _ = (a' * b) ^ (n + 1) * P := by rw [pow_succ']; simp only [mul_assoc, hYdef]

/-- **`(B V B)^n` の対称形の解消**（原文 `partition_function_sector_decomposition` Step 3）。 -/
theorem mul_pow_conj_left (B V : R) : ∀ n : ℕ, B * (B * V * B) ^ n = (B * B * V) ^ n * B
  | 0 => by simp
  | n + 1 => by
      have ih := mul_pow_conj_left B V n
      calc B * (B * V * B) ^ (n + 1)
          = (B * (B * V * B) ^ n) * (B * V * B) := by rw [pow_succ, ← mul_assoc]
        _ = ((B * B * V) ^ n * B) * (B * V * B) := by rw [ih]
        _ = (B * B * V) ^ n * (B * B * V) * B := by simp only [mul_assoc]
        _ = (B * B * V) ^ (n + 1) * B := by rw [pow_succ]

end Ising2D.NecSuf
