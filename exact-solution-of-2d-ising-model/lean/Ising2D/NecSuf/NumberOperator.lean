/-
# 個数演算子（**必要十分版**）

対応する人手証明のラベル（具体版は `Ising2D/Part009/` 以下）:

- `def_number_operator`（`Ising2D.NecSuf.num`）
- `number_operator_idempotent`（`Ising2D.NecSuf.num_mul_num`）
- `number_operators_commute`（`Ising2D.NecSuf.commute_num_num`）
- `trace_of_number_operator_product`（`Ising2D.NecSuf.two_mul_tau_num_mul`）

## この主張に本質的に効いている構造（＝具体版が過剰な構造を要求していないかの検査）

人手証明は `ψ_μ^†, ψ_{-μ} ∈ Mat(2^M, ℂ)` という具体的な行列について述べているが、
証明に効いているのは次の 3 つだけである。

1. **台が環であること**（結合法則・分配法則）。
2. **正準反交換関係 (CAR)**
   `c_i c_j + c_j c_i = 0`, `a_i a_j + a_j a_i = 0`, `c_i a_j + a_j c_i = δ_{ij} 1`。
3. **加法群に 2-捩れが無いこと**（`x + x = 0 → x = 0`）。
   これは `(ψ^†)^2 = 0` を CAR から出すところ**だけ**で使う。標数 2 では実際に破れる。

行列であること・複素数であること・テンソル冪であること・有限次元性・`M`・`γ_2`・
`ψ` の具体形（`hat(Z)^{(-)}, hat(Y)` の線型結合）はいずれも効いていない。
添字型 `ι` も任意の型でよい（等号の決定可能性すら要らない。`δ_{ij}` は
各定理へ「反交換子の値」として渡すだけだからである）。

トレースについても同様で、`trace_of_number_operator_product` の帰納段階に効いているのは
**「加法的かつ巡回的な汎関数 `τ`」が 1 つあること**だけである。`τ(1) = 2^M` という具体値も、
`τ` が行列のトレースであることも効いていない。
-/
import Mathlib.Algebra.Ring.Defs
import Mathlib.Algebra.Group.Basic
import Mathlib.Tactic.NoncommRing

namespace Ising2D.NecSuf

/-! ## CAR から出る個数演算子の性質 -/

section CAR

variable {A : Type*} [Ring A] {ι : Type*}

/-- 個数演算子 `n_i := c_i a_i`（人手証明の `n_μ = ψ_μ^† ψ_{-μ}`）。 -/
def num (c a : ι → A) (i : ι) : A := c i * a i

theorem num_def (c a : ι → A) (i : ι) : num c a i = c i * a i := rfl

/-- 2-捩れが無ければ、自分自身と反可換な元の平方は `0`。
（人手証明 `number_operator_idempotent` (1) の
「`0 = [ψ^†,ψ^†]₊ = 2(ψ^†)^2` と `2 ≠ 0`」にあたる。） -/
theorem sq_eq_zero_of_acomm_self (htf : ∀ x : A, x + x = 0 → x = 0) {x : A}
    (h : x * x + x * x = 0) : x * x = 0 :=
  htf _ h

/-- 人手証明 `number_operator_idempotent` (2): `a_i c_i = 1 - n_i`。 -/
theorem ann_mul_cre (c a : ι → A) (i : ι) (h : c i * a i + a i * c i = 1) :
    a i * c i = 1 - num c a i :=
  eq_sub_of_add_eq' h

/-- 人手証明 `number_operator_idempotent` (3): `n_i^2 = n_i`。 -/
theorem num_mul_num (c a : ι → A) (i : ι) (htf : ∀ x : A, x + x = 0 → x = 0)
    (hcc : c i * c i + c i * c i = 0) (haa : a i * a i + a i * a i = 0)
    (hca : c i * a i + a i * c i = 1) :
    num c a i * num c a i = num c a i := by
  have hc2 : c i * c i = 0 := sq_eq_zero_of_acomm_self htf hcc
  have ha2 : a i * a i = 0 := sq_eq_zero_of_acomm_self htf haa
  have hac : a i * c i = 1 - c i * a i := ann_mul_cre c a i hca
  show c i * a i * (c i * a i) = c i * a i
  calc c i * a i * (c i * a i) = c i * (a i * c i) * a i := by noncomm_ring
    _ = c i * (1 - c i * a i) * a i := by rw [hac]
    _ = c i * a i - (c i * c i) * (a i * a i) := by noncomm_ring
    _ = c i * a i := by rw [hc2, ha2]; noncomm_ring

/-- 反可換な 2 元の積との可換性。人手証明 `number_operators_commute` Step 2 の
「符号は `(-1)^2 = 1` となって消える」。 -/
theorem commute_mul_of_anticommute {x y z : A}
    (hxy : x * y + y * x = 0) (hxz : x * z + z * x = 0) :
    x * (y * z) = (y * z) * x := by
  have h1 : x * y = -(y * x) := eq_neg_of_add_eq_zero_left hxy
  have h2 : x * z = -(z * x) := eq_neg_of_add_eq_zero_left hxz
  calc x * (y * z) = (x * y) * z := by noncomm_ring
    _ = (-(y * x)) * z := by rw [h1]
    _ = -(y * (x * z)) := by noncomm_ring
    _ = -(y * (-(z * x))) := by rw [h2]
    _ = (y * z) * x := by noncomm_ring

/-- 人手証明 `number_operators_commute` (1): `i ≠ j` のとき `c_i` は `n_j` と可換。 -/
theorem commute_cre_num (c a : ι → A) {i j : ι}
    (hcc : c i * c j + c j * c i = 0) (hca : c i * a j + a j * c i = 0) :
    c i * num c a j = num c a j * c i :=
  commute_mul_of_anticommute hcc hca

/-- 人手証明 `number_operators_commute` (1): `i ≠ j` のとき `a_i` は `n_j` と可換。 -/
theorem commute_ann_num (c a : ι → A) {i j : ι}
    (hac : a i * c j + c j * a i = 0) (haa : a i * a j + a j * a i = 0) :
    a i * num c a j = num c a j * a i :=
  commute_mul_of_anticommute hac haa

/-- 人手証明 `number_operators_commute` (2): `i ≠ j` のとき `n_i n_j = n_j n_i`。 -/
theorem commute_num_num (c a : ι → A) {i j : ι}
    (hcc : c i * c j + c j * c i = 0) (hca : c i * a j + a j * c i = 0)
    (hac : a i * c j + c j * a i = 0) (haa : a i * a j + a j * a i = 0) :
    num c a i * num c a j = num c a j * num c a i := by
  have h1 : c i * num c a j = num c a j * c i := commute_cre_num c a hcc hca
  have h2 : a i * num c a j = num c a j * a i := commute_ann_num c a hac haa
  show c i * a i * num c a j = num c a j * (c i * a i)
  calc c i * a i * num c a j = c i * (a i * num c a j) := by noncomm_ring
    _ = c i * (num c a j * a i) := by rw [h2]
    _ = (c i * num c a j) * a i := by noncomm_ring
    _ = (num c a j * c i) * a i := by rw [h1]
    _ = num c a j * (c i * a i) := by noncomm_ring

/-- `c_i`, `a_i` が `P` と可換なら `n_i` も `P` と可換。 -/
theorem commute_num_of_commute (c a : ι → A) (i : ι) {P : A}
    (hcP : c i * P = P * c i) (haP : a i * P = P * a i) :
    num c a i * P = P * num c a i := by
  show c i * a i * P = P * (c i * a i)
  calc c i * a i * P = c i * (a i * P) := by noncomm_ring
    _ = c i * (P * a i) := by rw [haP]
    _ = (c i * P) * a i := by noncomm_ring
    _ = (P * c i) * a i := by rw [hcP]
    _ = P * (c i * a i) := by noncomm_ring

end CAR

/-! ## 巡回的な加法的汎関数によるトレースの計算 -/

section Trace

variable {A : Type*} [Ring A] {ι : Type*} {R : Type*} [AddCommMonoid R]

/-- 人手証明 `trace_of_number_operator_product` の帰納段階:
`n_i` と可換な `P` について `τ(n_i P) + τ(n_i P) = τ(P)`。

効いているのは `τ` の**加法性と巡回性**、`a_i c_i = 1 - n_i`、および
「`c_i`, `a_i` が `P` と可換」だけである。`τ` の値域は任意の可換モノイドでよく、
行列のトレースであることも複素数であることも効いていない。 -/
theorem tau_num_mul_add_self (τ : A → R) (hadd : ∀ x y : A, τ (x + y) = τ x + τ y)
    (hcyc : ∀ x y : A, τ (x * y) = τ (y * x))
    (c a : ι → A) (i : ι) (P : A)
    (hca : c i * a i + a i * c i = 1)
    (hcP : c i * P = P * c i) (haP : a i * P = P * a i) :
    τ (num c a i * P) + τ (num c a i * P) = τ P := by
  have hac : a i * c i = 1 - num c a i := ann_mul_cre c a i hca
  have hnP : num c a i * P = P * num c a i := commute_num_of_commute c a i hcP haP
  have hsplit : P = P * num c a i + P * (1 - num c a i) := by noncomm_ring
  have key : τ (num c a i * P) = τ (P * (1 - num c a i)) := by
    calc τ (num c a i * P) = τ (c i * (a i * P)) := by rw [num_def, mul_assoc]
      _ = τ ((a i * P) * c i) := hcyc _ _
      _ = τ (P * (a i * c i)) := by rw [haP, mul_assoc]
      _ = τ (P * (1 - num c a i)) := by rw [hac]
  calc τ (num c a i * P) + τ (num c a i * P)
      = τ (P * num c a i) + τ (P * (1 - num c a i)) := by rw [← hnP, key]
    _ = τ (P * num c a i + P * (1 - num c a i)) := (hadd _ _).symm
    _ = τ P := by rw [← hsplit]

end Trace

end Ising2D.NecSuf
