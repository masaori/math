/-
# 可換環の上の Euler の双対基底公式 — cycle 35 step 2

対応する人手証明:

* 本文ブロック `paper_046_theorem_wstar_different`（命題 W\*）の双対の段
* 外部定理の台帳「可換環の上の Euler の双対基底公式」

## なぜ自前で書くのか

mathlib の `Module.Basis.traceDual` は宣言が
`[Field K] [Field L] [FiniteDimensional K L] [Algebra.IsSeparable K L]` を要求しており、
**体の上にしかない**（2026-08-04 実測、`lean/logs/mathlib-gap-survey-cycle30-euler.log`）。
本論文が要るのは $\rho$ が可約な場合で、そのとき $A\otimes\mathbb{Q}$ は体ではなく体の積である。
cycle 28–30 が書いた `WStarElementaryDivisors.lean` の双対の段は `PowerBasis K L` を使うので
既約な場合しか覆っていない。**そこが 命題 W\* に残っていた唯一の穴だった。**

## 書いた証明の骨格（$\mathbb{R}$ も体も分離性も使わない）

$\rho$ をモニック・次数 $m+1$、$A$ を $\theta$ の冪 $1,\theta,\dots,\theta^{m}$ を基底とする
$R$ 代数とする。$\psi:A\to R$ を「$\theta^{m}$ の係数を取る」線形写像とし、
$\rho(y)/(y-\theta)=\sum_i c_i y^i$ の係数 $c_i$ を上から降りる漸化式
$c_{m}=1$、$c_{i-1}=a_i+\theta c_i$ で定める（`eulerC`）。

トレースの形（$\mathrm{Tr}(c_i w)=[\theta^i](\rho'(\theta)w)$）までの道筋は次の 5 段である。

| 段 | 主張 | 状態 |
|---|---|---|
| 1 | $\psi(c_i\theta^j)=\delta_{ij}$ | **書いた**（`psi_eulerC_mul_pow`） |
| 2 | $\sum_i c_i\theta^i=\rho'(\theta)$ | 書いていない |
| 3 | $\mathrm{Tr}(z)=\sum_j[\theta^j](z\theta^j)$ | 書いていない |
| 4 | $\mathrm{Tr}(z)=\psi(\rho'(\theta)z)$ | 書いていない |
| 5 | $\mathrm{Tr}(c_i w)=[\theta^i](\rho'(\theta)w)$ | 書いていない |

段 4 は段 1 と段 2 から出る——
$\mathrm{Tr}(z)=\sum_j[\theta^j](z\theta^j)=\sum_j\psi(c_j z\theta^j)
=\psi\bigl(z\sum_j c_j\theta^j\bigr)=\psi(\rho'(\theta)z)$。
Newton の恒等式も冪和も要らない。段 5 は段 4 に段 1 をもう一度当てるだけである。

## 形式化して分かったこと（段 1 について）

**分離性は本当に要らない。** 体の上の mathlib の証明はトレース形式の非退化性
（分離性と同値）を使うが、段 1 はそれを 1 度も使わない——効くのは
「$\psi$ による対の下で $c_i$ が $\theta^j$ の双対基底になっている」ことだけで、
それは $\rho$ がモニックであること（$\theta^{m+1}$ が低次へ落ちること）だけから、
上から降りる帰納法で出る。**$\rho$ が可約でも重根を持っても成り立つ。**
体の上の証明が分離性を要求していたのは、$\rho'(\theta)$ で割ってから双対基底を作っていたからで、
**割らずに $\psi$ の対で書けば仮定が落ちる**。ここが cycle 30 以降「素材が無い」と
書かれ続けていた箇所の中身である。

## 形式化しなかったもの

* **段 2（$\sum_i c_i\theta^i=\rho'(\theta)$）**。$c_i$ の明示形
  $c_i=\sum_t a_{i+1+t}\theta^t$ を経由して二重和を $k=i+1+t$ で入れ替えると
  各 $k$ の重複度がちょうど $k$ になって $\rho'$ が出る、という筋は立っているが、
  二重和の入れ替えを書いていない。
* **段 3・段 4・段 5**。段 3 は `Algebra.trace_eq_matrix_trace` と
  `leftMulMatrix` の成分の定義だけで出る配線、段 4・段 5 は段 1 と段 2 の組み合わせである。
* したがって本文の $C\,G=M_\eta$（`WStarElementaryDivisors.lean` の
  `eulerMatrix_mul_weightedGram` の可換環版）にはまだ届いていない。
  **命題 W\* は依然 部分的である。**
-/
import Mathlib

namespace IntegrableLattice
namespace EulerDualBasis

open Polynomial Finset Module

variable {R A : Type*} [CommRing R] [CommRing A] [Algebra R A]

/-! ## 段 0: 設定

$\rho$ はモニックで次数 $m+1$、$A$ は $1,\theta,\dots,\theta^{m}$ を基底とする $R$ 加群、
$\theta$ は $\rho$ の根である。**体も整域も分離性も仮定しない。** -/

/-- 冪基底の第 $j$ 座標。 -/
noncomputable def coord {m : ℕ} (b : Basis (Fin (m + 1)) R A) (j : Fin (m + 1)) (z : A) : R :=
  b.repr z j

/-- 最高次（第 $m$）の座標。本 file の対を作る線形写像。 -/
noncomputable def psi {m : ℕ} (b : Basis (Fin (m + 1)) R A) (z : A) : R :=
  b.repr z (Fin.last m)

/-- Euler の係数 $c_i$ を、上から降りる漸化式で定める。
`eulerC ρ θ m n` は本文の $c_{m-n}$ にあたる（$c_m=1$、$c_{i-1}=a_i+\theta c_i$）。 -/
noncomputable def eulerC (ρ : R[X]) (θ : A) (m : ℕ) : ℕ → A
  | 0 => 1
  | (n + 1) => algebraMap R A (ρ.coeff (m - n)) + θ * eulerC ρ θ m n

@[simp] theorem eulerC_zero (ρ : R[X]) (θ : A) (m : ℕ) : eulerC ρ θ m 0 = 1 := rfl

theorem eulerC_succ (ρ : R[X]) (θ : A) (m n : ℕ) :
    eulerC ρ θ m (n + 1) = algebraMap R A (ρ.coeff (m - n)) + θ * eulerC ρ θ m n := rfl

/-! ## 段 1: $\psi$ の対の下で $c_i$ は $\theta^j$ の双対基底である

**本 file の心臓部。** 上から降りる帰納法で、$\rho$ がモニックであることだけを使う。 -/

section Dual

variable {m : ℕ} {ρ : R[X]} {θ : A} (b : Basis (Fin (m + 1)) R A)

/-- 基底が $\theta$ の冪であること。 -/
def IsPowerBasisOf (b : Basis (Fin (m + 1)) R A) (θ : A) : Prop :=
  ∀ j : Fin (m + 1), b j = θ ^ (j : ℕ)

/-- $\theta^{m+1}$ を低次へ落とす関係（$\rho$ がモニックで $\theta$ がその根であることの中身）。 -/
def IsReductionOf (ρ : R[X]) (θ : A) (m : ℕ) : Prop :=
  θ ^ (m + 1) = -∑ k ∈ range (m + 1), algebraMap R A (ρ.coeff k) * θ ^ k

/-- $\psi(\theta^j)=\delta_{j,m}$（基底の座標そのもの）。 -/
theorem psi_pow (hb : IsPowerBasisOf b θ) (j : Fin (m + 1)) :
    psi b (θ ^ (j : ℕ)) = if (j : ℕ) = m then 1 else 0 := by
  classical
  rw [psi, ← hb j, b.repr_self]
  by_cases h : (j : ℕ) = m
  · have : j = Fin.last m := Fin.ext (by simp [h])
    simp [this]
  · have : j ≠ Fin.last m := fun hj => h (by simp [hj])
    simp [this, h]

/-- **段 1（Euler の双対基底公式そのもの）**。
$\psi(c_{m-n}\,\theta^{j})=\delta_{j+n,m}$。

体も整域も分離性も使わない。使うのは $\rho$ がモニックであること
（$\theta^{m+1}$ が低次へ落ちること）だけである。 -/
theorem psi_eulerC_mul_pow (hb : IsPowerBasisOf b θ) (hred : IsReductionOf ρ θ m) :
    ∀ n ≤ m, ∀ j ≤ m,
      psi b (eulerC ρ θ m n * θ ^ j) = if j + n = m then 1 else 0 := by
  classical
  intro n
  induction n with
  | zero =>
    intro _ j hj
    have hjf : ((⟨j, Nat.lt_succ_of_le hj⟩ : Fin (m + 1)) : ℕ) = j := rfl
    have hz := psi_pow b hb ⟨j, Nat.lt_succ_of_le hj⟩
    rw [hjf] at hz
    simp [hz]
  | succ n ih =>
    intro hn j hj
    have hnm : n ≤ m := Nat.le_of_succ_le hn
    rw [eulerC_succ, add_mul]
    have hpsi_add : psi b (algebraMap R A (ρ.coeff (m - n)) * θ ^ j + θ * eulerC ρ θ m n * θ ^ j)
        = psi b (algebraMap R A (ρ.coeff (m - n)) * θ ^ j)
          + psi b (θ * eulerC ρ θ m n * θ ^ j) := by
      simp [psi]
    -- 第 1 項は $\psi(\theta^j)$ のスカラー倍、第 2 項は $c$ を 1 つずらした形。
    have hfirst : psi b (algebraMap R A (ρ.coeff (m - n)) * θ ^ j)
        = ρ.coeff (m - n) * (if j = m then 1 else 0) := by
      have hj' := psi_pow b hb ⟨j, Nat.lt_succ_of_le hj⟩
      have hjf : ((⟨j, Nat.lt_succ_of_le hj⟩ : Fin (m + 1)) : ℕ) = j := rfl
      rw [hjf] at hj'
      rw [← Algebra.smul_def, psi, map_smul, Finsupp.smul_apply, smul_eq_mul, ← psi, hj']
    have hsecond : psi b (θ * eulerC ρ θ m n * θ ^ j)
        = psi b (eulerC ρ θ m n * θ ^ (j + 1)) := by
      congr 1; ring
    rw [hpsi_add, hfirst, hsecond]
    by_cases hjm : j = m
    · -- $j=m$: $\theta^{m+1}$ を落として、帰納法の仮定を全次数に当てる。
      rw [hjm]
      have hred' : eulerC ρ θ m n * θ ^ (m + 1)
          = -∑ k ∈ range (m + 1), algebraMap R A (ρ.coeff k) * (eulerC ρ θ m n * θ ^ k) := by
        rw [IsReductionOf] at hred
        rw [hred, mul_neg, Finset.mul_sum]
        congr 1
        exact Finset.sum_congr rfl fun k _ => by ring
      rw [hred']
      have hsum : psi b (-∑ k ∈ range (m + 1),
            algebraMap R A (ρ.coeff k) * (eulerC ρ θ m n * θ ^ k))
          = -∑ k ∈ range (m + 1), ρ.coeff k * (if k + n = m then 1 else 0) := by
        simp only [psi, map_neg, map_sum, Finsupp.neg_apply, Finsupp.finsetSum_apply, neg_inj]
        refine Finset.sum_congr rfl fun k hk => ?_
        have hkm : k ≤ m := Nat.lt_succ_iff.mp (Finset.mem_range.mp hk)
        have hik := ih hnm k hkm
        rw [← Algebra.smul_def, map_smul, Finsupp.smul_apply, smul_eq_mul, ← psi, hik]
      rw [hsum]
      -- 和は $k=m-n$ の 1 項だけが残り、第 1 項とちょうど打ち消し合う。
      have hone : ∑ k ∈ range (m + 1), ρ.coeff k * (if k + n = m then 1 else 0)
          = ρ.coeff (m - n) := by
        rw [Finset.sum_eq_single (m - n)]
        · simp [Nat.sub_add_cancel hnm]
        · intro k _ hk
          have : k + n ≠ m := fun h => hk (by omega)
          simp [this]
        · intro h
          exact absurd (Finset.mem_range.mpr (by omega)) h
      rw [hone]
      simp
    · -- $j<m$: 第 1 項が消え、帰納法の仮定が第 2 項をそのまま与える。
      have hjlt : j < m := lt_of_le_of_ne hj hjm
      have hstep := ih hnm (j + 1) (by omega)
      rw [hstep]
      have h1 : (j + 1) + n = m ↔ j + (n + 1) = m := by omega
      simp [hjm, h1]

end Dual

end EulerDualBasis
end IntegrableLattice
