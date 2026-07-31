/-
# 個数演算子の同時固有射影（**必要十分版**）

対応する人手証明のラベル（具体版は `Ising2D/Part009/Claim008_JointEigenspace.lean`）:
`joint_eigenspace_decomposition`、および `trace_of_number_operator_product`。

## この主張に本質的に効いている構造（＝具体版が過剰な構造を要求していないかの検査）

人手証明は `Q_ε := ∏_{μ∈𝓘}(ε_μ n_μ + (1-ε_μ)(I - n_μ)) ∈ Mat(2^M,ℂ)` について
(1)〜(5) を述べているが、(1)(2)(3) に効いているのは

1. **台が環であること**、
2. **`n_i` が互いに可換な冪等元であること**

の 2 つだけである。`n_i` が `ψ^†ψ` の形であることも、CAR も、行列であることも、
複素数であることも、有限次元性も効いていない。

(4) のトレース計算に効いているのは、上に加えて
**「加法的かつ巡回的な汎関数 `τ`」1 つ**と、**`c_i, a_i` が他の `n_j` と可換**なことだけである
（`τ(Q_T) = τ(1)/2^{|s|}` は `2^{|s|} • τ(Q_T) = τ(1)` の形で述べる。
割り算も、値域が ℂ であることも要らない）。

(5)（`ℂ^{2^M}` の直和分解）は台が行列環であることを本質的に使うので、
具体版だけに置く（`Ising2D/Part009/Claim008_JointEigenspace.lean`）。

## 添字づけについて

人手証明の `ε ∈ {0,1}^𝓘` は、`ε_μ = 1` となる添字の集合 `T ⊆ 𝓘` と同じデータである。
必要十分版では `T : Finset ι` で添字づける（具体版で `ε : ι → Bool` の形も与える）。

## 積の順序について

人手証明は「因子は互いに可換なので積の順序は問わない」と述べている。Lean では
非可換環に `Finset.prod` が無いため、可換性の証明を引数に取る
`Finset.noncommProd` を使う。これは人手証明のその一文をそのまま形式化したものである。
-/
import Mathlib.Data.Finset.NoncommProd
import Mathlib.Algebra.BigOperators.Group.Finset.Powerset
import Mathlib.Analysis.Normed.Algebra.Exponential
import Mathlib.Analysis.SpecialFunctions.Exponential
import Ising2D.NecSuf.NumberOperator

namespace Ising2D.NecSuf

open Finset

section Proj

variable {A : Type*} [Ring A] {ι : Type*} [DecidableEq ι]

/-- 人手証明の `R_μ^{(ε_μ)}`: `i ∈ T`（`ε_i = 1`）なら `n_i`、そうでなければ `1 - n_i`。 -/
def projFactor (n : ι → A) (T : Finset ι) (i : ι) : A := if i ∈ T then n i else 1 - n i

theorem projFactor_of_mem {n : ι → A} {T : Finset ι} {i : ι} (h : i ∈ T) :
    projFactor n T i = n i := if_pos h

theorem projFactor_of_notMem {n : ι → A} {T : Finset ι} {i : ι} (h : i ∉ T) :
    projFactor n T i = 1 - n i := if_neg h

/-- 人手証明 Step 0 の「`R_μ^{(e)}` と `R_ν^{(e')}` も可換」。 -/
theorem commute_projFactor {n : ι → A} (hn : ∀ i j, Commute (n i) (n j)) (T T' : Finset ι)
    (i j : ι) : Commute (projFactor n T i) (projFactor n T' j) := by
  have h1 : Commute (n i) (n j) := hn i j
  have h2 : Commute (n i) (1 - n j) := Commute.sub_right (Commute.one_right (n i)) h1
  have h3 : Commute (1 - n i) (n j) := Commute.sub_left (Commute.one_left (n j)) h1
  have h4 : Commute (1 - n i) (1 - n j) :=
    Commute.sub_right (Commute.one_right (1 - n i)) h3
  unfold projFactor
  split <;> split <;> assumption

/-- 人手証明 Step 0 の各因子の冪等性。 -/
theorem projFactor_mul_self {n : ι → A} (hidem : ∀ i, n i * n i = n i) (T : Finset ι) (i : ι) :
    projFactor n T i * projFactor n T i = projFactor n T i := by
  unfold projFactor
  split
  · exact hidem i
  · have h := hidem i
    calc (1 - n i) * (1 - n i) = 1 - n i - n i + n i * n i := by noncomm_ring
      _ = 1 - n i := by rw [h]; abel

/-- 添字集合 `s` にわたる同時固有射影 `Q_T`（人手証明の `Q_ε`）。 -/
def projOn (n : ι → A) (hn : ∀ i j, Commute (n i) (n j)) (s T : Finset ι) : A :=
  s.noncommProd (projFactor n T) fun i _ j _ _ => commute_projFactor hn T T i j

variable {n : ι → A} {hn : ∀ i j, Commute (n i) (n j)}

@[simp]
theorem projOn_empty (T : Finset ι) : projOn n hn ∅ T = 1 :=
  Finset.noncommProd_empty _ _

theorem projOn_insert {j : ι} {s : Finset ι} (hj : j ∉ s) (T : Finset ι) :
    projOn n hn (insert j s) T = projFactor n T j * projOn n hn s T :=
  Finset.noncommProd_insert_of_notMem _ _ _ _ hj

/-- `n_i`（`i ∈ s`）すべてと可換な元は `Q_T` とも可換。 -/
theorem commute_projOn {x : A} {s T : Finset ι} (h : ∀ i ∈ s, Commute x (n i)) :
    Commute x (projOn n hn s T) := by
  refine Finset.noncommProd_commute _ _ _ _ fun i hi => ?_
  have hx := h i hi
  unfold projFactor
  split
  · exact hx
  · exact Commute.sub_right (Commute.one_right x) hx

/-- 添字集合の外では `T` の中身は効かない（人手証明が `Q_ε` を `𝓘` 上の積として
定義していることに対応）。 -/
theorem projOn_congr {s T T' : Finset ι} (h : ∀ i ∈ s, (i ∈ T ↔ i ∈ T')) :
    projOn n hn s T = projOn n hn s T' :=
  Finset.noncommProd_congr rfl (fun i hi => by
    unfold projFactor
    by_cases hT : i ∈ T
    · rw [if_pos hT, if_pos ((h i hi).1 hT)]
    · rw [if_neg hT, if_neg (fun hT' => hT ((h i hi).2 hT'))]) _

/-- 人手証明 `joint_eigenspace_decomposition` (3): `n_ν Q_ε = ε_ν Q_ε`。 -/
theorem num_mul_projOn (hidem : ∀ i, n i * n i = n i) {s T : Finset ι} {ν : ι} (hν : ν ∈ s) :
    n ν * projOn n hn s T = (if ν ∈ T then (1 : A) else 0) * projOn n hn s T := by
  have key : projFactor n T ν * projOn n hn (s.erase ν) T = projOn n hn s T :=
    Finset.mul_noncommProd_erase _ hν _ _
  have hfac : n ν * projFactor n T ν = (if ν ∈ T then (1 : A) else 0) * projFactor n T ν := by
    by_cases hT : ν ∈ T
    · rw [if_pos hT, projFactor_of_mem hT, hidem ν, one_mul]
    · rw [if_neg hT, projFactor_of_notMem hT, zero_mul]
      have := hidem ν
      calc n ν * (1 - n ν) = n ν - n ν * n ν := by noncomm_ring
        _ = 0 := by rw [this, sub_self]
  calc n ν * projOn n hn s T
      = n ν * (projFactor n T ν * projOn n hn (s.erase ν) T) := by rw [key]
    _ = (n ν * projFactor n T ν) * projOn n hn (s.erase ν) T := by rw [mul_assoc]
    _ = ((if ν ∈ T then (1 : A) else 0) * projFactor n T ν) * projOn n hn (s.erase ν) T := by
        rw [hfac]
    _ = (if ν ∈ T then (1 : A) else 0) * (projFactor n T ν * projOn n hn (s.erase ν) T) := by
        rw [mul_assoc]
    _ = (if ν ∈ T then (1 : A) else 0) * projOn n hn s T := by rw [key]

/-- 人手証明 `joint_eigenspace_decomposition` (1) 後半: `Q_ε^2 = Q_ε`。 -/
theorem projOn_mul_self (hidem : ∀ i, n i * n i = n i) (s T : Finset ι) :
    projOn n hn s T * projOn n hn s T = projOn n hn s T := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | insert j s hj ih =>
      have hcomm : Commute (projFactor n T j) (projOn n hn s T) :=
        Finset.noncommProd_commute _ _ _ _ fun i _ => commute_projFactor hn T T j i
      rw [projOn_insert hj]
      calc projFactor n T j * projOn n hn s T * (projFactor n T j * projOn n hn s T)
          = projFactor n T j * (projOn n hn s T * projFactor n T j) * projOn n hn s T := by
            simp only [mul_assoc]
        _ = projFactor n T j * (projFactor n T j * projOn n hn s T) * projOn n hn s T := by
            rw [hcomm.symm.eq]
        _ = (projFactor n T j * projFactor n T j) * (projOn n hn s T * projOn n hn s T) := by
            simp only [mul_assoc]
        _ = projFactor n T j * projOn n hn s T := by
            rw [projFactor_mul_self hidem, ih]

/-- 人手証明 `joint_eigenspace_decomposition` (1) 前半: `ε ≠ ε'` なら `Q_ε Q_{ε'} = 0`。

「ある `ν ∈ s` で `ε_ν ≠ ε'_ν`」を `ν ∈ T` と `ν ∈ T'` の一方だけが成り立つ形で述べる。 -/
theorem projOn_mul_projOn_of_ne (hidem : ∀ i, n i * n i = n i) {s T T' : Finset ι} {ν : ι}
    (hν : ν ∈ s) (hne : ¬(ν ∈ T ↔ ν ∈ T')) :
    projOn n hn s T * projOn n hn s T' = 0 := by
  classical
  have keyT : projFactor n T ν * projOn n hn (s.erase ν) T = projOn n hn s T :=
    Finset.mul_noncommProd_erase _ hν _ _
  have keyT' : projFactor n T' ν * projOn n hn (s.erase ν) T' = projOn n hn s T' :=
    Finset.mul_noncommProd_erase _ hν _ _
  have hcomm : Commute (projOn n hn (s.erase ν) T) (projFactor n T' ν) :=
    (Finset.noncommProd_commute _ _ _ _ fun i _ => commute_projFactor hn T' T ν i).symm
  have hfac : projFactor n T ν * projFactor n T' ν = 0 := by
    have hidn := hidem ν
    by_cases hT : ν ∈ T
    · have hT' : ν ∉ T' := fun h => hne ⟨fun _ => h, fun _ => hT⟩
      rw [projFactor_of_mem hT, projFactor_of_notMem hT']
      calc n ν * (1 - n ν) = n ν - n ν * n ν := by noncomm_ring
        _ = 0 := by rw [hidn, sub_self]
    · have hT' : ν ∈ T' := by
        by_contra h
        exact hne ⟨fun h' => absurd h' hT, fun h' => absurd h' h⟩
      rw [projFactor_of_notMem hT, projFactor_of_mem hT']
      calc (1 - n ν) * n ν = n ν - n ν * n ν := by noncomm_ring
        _ = 0 := by rw [hidn, sub_self]
  calc projOn n hn s T * projOn n hn s T'
      = (projFactor n T ν * projOn n hn (s.erase ν) T)
          * (projFactor n T' ν * projOn n hn (s.erase ν) T') := by rw [keyT, keyT']
    _ = projFactor n T ν * (projOn n hn (s.erase ν) T * projFactor n T' ν)
          * projOn n hn (s.erase ν) T' := by simp only [mul_assoc]
    _ = (projFactor n T ν * projFactor n T' ν)
          * (projOn n hn (s.erase ν) T * projOn n hn (s.erase ν) T') := by
        rw [hcomm.eq]; simp only [mul_assoc]
    _ = 0 := by rw [hfac, zero_mul]

/-- 人手証明 `joint_eigenspace_decomposition` (2): `∑_ε Q_ε = I`。

和は `s` の部分集合（＝人手証明の `{0,1}^𝓘`）にわたる。 -/
theorem sum_projOn (s : Finset ι) : ∑ T ∈ s.powerset, projOn n hn s T = 1 := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | insert j s hj ih =>
      rw [Finset.sum_powerset_insert hj]
      have h1 : ∀ T ∈ s.powerset, projOn n hn (insert j s) T
          = (1 - n j) * projOn n hn s T := by
        intro T hT
        have hjT : j ∉ T := fun h => hj (Finset.mem_powerset.1 hT h)
        rw [projOn_insert hj, projFactor_of_notMem hjT]
      have h2 : ∀ T ∈ s.powerset, projOn n hn (insert j s) (insert j T)
          = n j * projOn n hn s T := by
        intro T hT
        have hjmem : j ∈ insert j T := Finset.mem_insert_self j T
        rw [projOn_insert hj, projFactor_of_mem hjmem]
        congr 1
        refine projOn_congr fun i hi => ?_
        have hij : i ≠ j := fun h => hj (h ▸ hi)
        simp [Finset.mem_insert, hij]
      rw [Finset.sum_congr rfl h1, Finset.sum_congr rfl h2, ← Finset.sum_add_distrib]
      have : ∀ T ∈ s.powerset,
          (1 - n j) * projOn n hn s T + n j * projOn n hn s T = projOn n hn s T := by
        intro T _
        noncomm_ring
      rw [Finset.sum_congr rfl this, ih]

end Proj

/-! ## トレースの値（人手証明 `joint_eigenspace_decomposition` (4)） -/

section ProjTrace

variable {A : Type*} [Ring A] {ι : Type*} [DecidableEq ι]
variable {R : Type*} [AddCommGroup R]

/-- 人手証明 `joint_eigenspace_decomposition` (4) の必要十分版:
`2^{|s|} τ(Q_T) = τ(1)`。人手証明が `tr(Q_ε) = 2^{M-m}` と書いているものにあたる
（`τ(1) = 2^M`, `|s| = m`）。

人手証明は `Q_ε` を二項展開して `trace_of_number_operator_product` と二項定理を使うが、
実際に効いているのは「**どちらの因子でも** `2 τ(R_j X) = τ(X)`」という 1 段だけであり、
二項定理は要らない（`n_j` の場合は `trace_of_number_operator_product` の帰納段階そのもの、
`1 - n_j` の場合はその差として出る）。 -/
theorem two_pow_smul_tau_projOn (c a : ι → A)
    (hn : ∀ i j, Commute (num c a i) (num c a j))
    (τ : A → R) (hadd : ∀ x y : A, τ (x + y) = τ x + τ y)
    (hcyc : ∀ x y : A, τ (x * y) = τ (y * x))
    (hca : ∀ i, c i * a i + a i * c i = 1)
    (hcc : ∀ i j, i ≠ j → Commute (c i) (num c a j))
    (hac : ∀ i j, i ≠ j → Commute (a i) (num c a j))
    (s T : Finset ι) :
    (2 ^ s.card) • τ (projOn (num c a) hn s T) = τ 1 := by
  classical
  have hsub : ∀ x y : A, τ (x - y) = τ x - τ y := by
    intro x y
    have := hadd (x - y) y
    rw [sub_add_cancel] at this
    rw [this]
    abel
  induction s using Finset.induction_on with
  | empty => simp
  | insert j s hj ih =>
      set P : A := projOn (num c a) hn s T with hP
      have hcP : c j * P = P * c j :=
        (commute_projOn (fun i hi => hcc j i (fun h => hj (h ▸ hi)))).eq
      have haP : a j * P = P * a j :=
        (commute_projOn (fun i hi => hac j i (fun h => hj (h ▸ hi)))).eq
      have hnum : τ (num c a j * P) + τ (num c a j * P) = τ P :=
        tau_num_mul_add_self τ hadd hcyc c a j P (hca j) hcP haP
      have hfac : τ (projFactor (num c a) T j * P) + τ (projFactor (num c a) T j * P) = τ P := by
        by_cases hT : j ∈ T
        · rw [projFactor_of_mem hT]; exact hnum
        · rw [projFactor_of_notMem hT]
          have hexp : (1 - num c a j) * P = P - num c a j * P := by noncomm_ring
          rw [hexp, hsub, ← hnum]
          abel
      have hcard : (insert j s).card = s.card + 1 := Finset.card_insert_of_notMem hj
      rw [projOn_insert hj, hcard, pow_succ]
      calc (2 ^ s.card * 2) • τ (projFactor (num c a) T j * P)
          = (2 ^ s.card) • (τ (projFactor (num c a) T j * P)
              + τ (projFactor (num c a) T j * P)) := by
            rw [← two_smul ℕ (τ (projFactor (num c a) T j * P)), smul_smul]
        _ = (2 ^ s.card) • τ P := by rw [hfac]
        _ = τ 1 := ih

end ProjTrace

/-! ## 指数関数の固有値（人手証明 `eigenvalues_of_Vprime` Step 2・Step 3） -/

section Exp

open NormedSpace Nat

variable {A : Type*} [NormedRing A] [NormedAlgebra ℂ A] [CompleteSpace A]

/-- 人手証明 `eigenvalues_of_Vprime` Step 2: `X Q = g Q ⇒ X^k Q = g^k Q`。 -/
theorem pow_mul_eq_of_mul_eq_smul {X Q : A} {g : ℂ} (h : X * Q = g • Q) (k : ℕ) :
    X ^ k * Q = g ^ k • Q := by
  induction k with
  | zero => simp
  | succ k ih =>
      calc X ^ (k + 1) * Q = X ^ k * (X * Q) := by rw [pow_succ, mul_assoc]
        _ = X ^ k * (g • Q) := by rw [h]
        _ = g • (X ^ k * Q) := by rw [mul_smul_comm]
        _ = g • (g ^ k • Q) := by rw [ih]
        _ = g ^ (k + 1) • Q := by rw [smul_smul]; congr 1; ring

/-- 人手証明 `eigenvalues_of_Vprime` Step 3: `X Q = g Q ⇒ exp(X) Q = e^g Q`。

効いているのは **ℂ 上の完備ノルム環であること**だけで、行列であることも
有限次元であることも `Q` が射影であることも効いていない。 -/
theorem exp_mul_eq_of_mul_eq_smul {X Q : A} {g : ℂ} (h : X * Q = g • Q) :
    exp X * Q = Complex.exp g • Q := by
  have hX : HasSum (fun k : ℕ => ((k ! : ℂ))⁻¹ • X ^ k) (exp X) :=
    NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) X
  have h1 : HasSum (fun k : ℕ => (((k ! : ℂ))⁻¹ • X ^ k) * Q) (exp X * Q) :=
    hX.mul_right Q
  have hg : HasSum (fun k : ℕ => ((k ! : ℂ))⁻¹ • g ^ k) (Complex.exp g) := by
    have := NormedSpace.exp_series_hasSum_exp' (𝕂 := ℂ) g
    rwa [← Complex.exp_eq_exp_ℂ] at this
  have h2 : HasSum (fun k : ℕ => (((k ! : ℂ))⁻¹ • g ^ k) • Q) (Complex.exp g • Q) :=
    hg.smul_const Q
  refine h1.unique ?_
  refine h2.congr_fun ?_
  intro k
  rw [smul_mul_assoc, pow_mul_eq_of_mul_eq_smul h k, smul_smul, smul_eq_mul]

end Exp

end Ising2D.NecSuf
