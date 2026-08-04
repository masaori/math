/-
# 可換環の上の Euler の双対基底公式 — cycle 35 step 2（段 1）・cycle 36 step 1（段 2–6）

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
| 1 | $\psi(c_i\theta^j)=\delta_{ij}$ | 書いた（`psi_eulerC_mul_pow`。cycle 35） |
| 2 | $\sum_i c_i\theta^i=\rho'(\theta)$ | 書いた（`sum_eulerC_mul_pow`。cycle 36） |
| 3 | $\mathrm{Tr}(z)=\sum_j[\theta^j](z\theta^j)$ | 書いた（`trace_eq_sum_coord`。cycle 36） |
| 4 | $\mathrm{Tr}(z)=\psi(\rho'(\theta)z)$ | 書いた（`trace_eq_psi_derivative_mul`。cycle 36） |
| 5 | $\mathrm{Tr}(c_i w)=[\theta^i](\rho'(\theta)w)$ | 書いた（`trace_eulerC_mul`。cycle 36） |
| 6 | $C\,G=M_\eta$ | 書いた（`eulerMatrix_mul_weightedGram`。cycle 36） |

段 4 は段 1 と段 2 から出る——
$\mathrm{Tr}(z)=\sum_j[\theta^j](z\theta^j)=\sum_j\psi(c_j z\theta^j)
=\psi\bigl(z\sum_j c_j\theta^j\bigr)=\psi(\rho'(\theta)z)$。
Newton の恒等式も冪和も要らない。段 5 は段 4 に段 1 をもう一度当てるだけである。

段 6 が本文の $C\,G=M_\eta$ そのもので、`WStarIntegralDescent.lean` の
`isLeast_isPLevel_range_of_euler` が仮定として受け取っていた等式である。
併せて $C$ が $\rho$ の係数の Hankel 行列であること（`eulerMatrix_apply`。$C_{ij}=\rho_{i+j+1}$）も
可換環の上で書いたので、`WStarIntegralDescent.isUnit_det_eulerHankel` と繋いで
$\det C=\pm1$ が出る。**$\rho$ が可約な場合に残っていた穴はこれで埋まった。**

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

* **段 2 から段 6 までは cycle 36 step 1 で書いた。**
  二重和の入れ替えは $c_i$ の明示形（`eulerC_eq_sum`）を経由し、$k=i+t$ で入れ替えると
  各 $k$ の重複度がちょうど $k+1$ になる。
  **この外部定理（可換環の上の Euler の双対基底公式）に残りは無い。**
* **$A=\mathbb{Z}[x]/(\rho)$ が `IsPowerBasisOf` と `IsReductionOf` を満たすことの当てはめ**は
  書いていない。本 file はどちらも仮定として受け取る。これは外部定理の側ではなく
  命題 W\* の側の残りである（検査 F の 命題 W\* の欄を見よ）。
* **命題 W\* は依然 部分的である。** 段 6 を書いても完了しない——
  cycle 36 step 1 の実測で、降下の側が整域を要求していたこと（`WStarReducibleDescent.lean` で埋めた）と、
  $\det G=\pm N_{A/\mathbb{Q}}(\eta)$ が可約な場合に無いこと（未形式化）が分かった。
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

/-! ## 段 2: $\sum_i c_i\theta^i=\rho'(\theta)$

$c_i$ の明示形 $c_i=\sum_t a_{i+1+t}\theta^t$ を経由し、二重和を $k=i+t$ で入れ替える。
各 $k$ の重複度がちょうど $k+1$ になって $\rho'$ の係数が出る。 -/

section Derivative

variable {m : ℕ} {ρ : R[X]} {θ : A}

/-- Euler の係数の明示形。`eulerC ρ θ m n`（本文の $c_{m-n}$）は
$\sum_{t\le n} a_{m-n+1+t}\,\theta^t$ に等しい。$\rho$ がモニックで次数 $m+1$ であることを使う。 -/
theorem eulerC_eq_sum (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) :
    ∀ n ≤ m, eulerC ρ θ m n
      = ∑ t ∈ range (n + 1), algebraMap R A (ρ.coeff (m - n + 1 + t)) * θ ^ t := by
  intro n
  induction n with
  | zero =>
    intro _
    have h1 : ρ.coeff (m + 1) = 1 := by
      have := hmonic.coeff_natDegree
      rwa [hdeg] at this
    simp [eulerC, h1]
  | succ n ih =>
    intro hn
    have hnm : n ≤ m := Nat.le_of_succ_le hn
    have hidx : m - (n + 1) + 1 = m - n := by omega
    rw [eulerC_succ, ih hnm, hidx, Finset.mul_sum]
    conv_rhs => rw [Finset.sum_range_succ']
    have hterms : ∀ t ∈ range (n + 1),
        θ * (algebraMap R A (ρ.coeff (m - n + 1 + t)) * θ ^ t)
          = algebraMap R A (ρ.coeff (m - n + (t + 1))) * θ ^ (t + 1) := by
      intro t _
      have hshift : m - n + 1 + t = m - n + (t + 1) := by omega
      rw [hshift]; ring
    rw [Finset.sum_congr rfl hterms, add_comm]
    simp

/-- **段 2**。$\sum_{i=0}^{m} c_i\,\theta^i=\rho'(\theta)$。

明示形を入れると二重和になり、$k=i+t$ で入れ替えると各 $k$ の重複度がちょうど $k+1$ になる。
それが $\rho'$ の係数 $(k+1)a_{k+1}$ である。 -/
theorem sum_eulerC_mul_pow (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) :
    ∑ i ∈ range (m + 1), eulerC ρ θ m (m - i) * θ ^ i = aeval θ (derivative ρ) := by
  classical
  -- 左辺の各項を、指数 $k=i+t$ で書いた和へ直す。
  have hleft : ∀ i ∈ range (m + 1),
      eulerC ρ θ m (m - i) * θ ^ i
        = ∑ k ∈ Finset.Ico i (m + 1), algebraMap R A (ρ.coeff (k + 1)) * θ ^ k := by
    intro i hi
    have him : i ≤ m := Nat.lt_succ_iff.mp (Finset.mem_range.mp hi)
    have hmi : m - (m - i) = i := by omega
    rw [eulerC_eq_sum hmonic hdeg (m - i) (Nat.sub_le _ _), hmi, Finset.sum_mul,
      Finset.sum_Ico_eq_sum_range]
    have hcard : m + 1 - i = m - i + 1 := by omega
    rw [hcard]
    refine Finset.sum_congr rfl fun t _ => ?_
    have hidx : i + 1 + t = i + t + 1 := by omega
    rw [hidx, pow_add]
    ring
  rw [Finset.sum_congr rfl hleft]
  -- 二重和の入れ替え（$i\le k\le m$ の三角形）。
  rw [Finset.sum_comm' (s' := fun k => range (k + 1)) (t' := range (m + 1))
      (by intro i k; simp only [Finset.mem_range, Finset.mem_Ico]; omega)]
  -- 各 $k$ の重複度は $k+1$。
  have hcount : ∀ k ∈ range (m + 1),
      ∑ _i ∈ range (k + 1), algebraMap R A (ρ.coeff (k + 1)) * θ ^ k
        = (derivative ρ).coeff k • θ ^ k := by
    intro k _
    rw [Finset.sum_const, Finset.card_range, nsmul_eq_mul, coeff_derivative, Algebra.smul_def,
      map_mul, map_add, map_natCast, map_one]
    push_cast
    ring
  rw [Finset.sum_congr rfl hcount]
  have hdlt : (derivative ρ).natDegree < m + 1 := by
    have hne : ρ.natDegree ≠ 0 := by rw [hdeg]; omega
    have := natDegree_derivative_lt hne
    omega
  rw [aeval_eq_sum_range' hdlt]

end Derivative

/-! ## 段 3–5: トレースの形へ

段 3 は `Algebra.trace_eq_matrix_trace` と `leftMulMatrix` の成分の定義だけで出る配線、
段 4 は段 1・段 2・段 3 の組み合わせ、段 5 は段 4 に段 1 をもう一度当てるだけである。
**Newton の恒等式も冪和も使わない。** -/

section Trace

variable {m : ℕ} {ρ : R[X]} {θ : A} (b : Basis (Fin (m + 1)) R A)

theorem psi_sum {ι : Type*} (s : Finset ι) (f : ι → A) :
    psi b (∑ i ∈ s, f i) = ∑ i ∈ s, psi b (f i) := by
  simp only [psi, map_sum, Finsupp.finsetSum_apply]

theorem coord_sum {ι : Type*} (j : Fin (m + 1)) (s : Finset ι) (f : ι → A) :
    coord b j (∑ i ∈ s, f i) = ∑ i ∈ s, coord b j (f i) := by
  simp only [coord, map_sum, Finsupp.finsetSum_apply]

theorem psi_smul (r : R) (z : A) : psi b (r • z) = r * psi b z := by
  simp only [psi, map_smul, Finsupp.smul_apply, smul_eq_mul]

theorem coord_smul (j : Fin (m + 1)) (r : R) (z : A) :
    coord b j (r • z) = r * coord b j z := by
  simp only [coord, map_smul, Finsupp.smul_apply, smul_eq_mul]

/-- $[\theta^j]\theta^t=\delta_{tj}$（基底の座標そのもの）。 -/
theorem coord_pow (hb : IsPowerBasisOf b θ) (j t : Fin (m + 1)) :
    coord b j (θ ^ (t : ℕ)) = if t = j then 1 else 0 := by
  classical
  rw [coord, ← hb t, b.repr_self]
  simp [Finsupp.single_apply]

/-- **段 3**。$\mathrm{Tr}(z)=\sum_j[\theta^j](z\,\theta^j)$。 -/
theorem trace_eq_sum_coord (z : A) :
    Algebra.trace R A z = ∑ j, coord b j (z * b j) := by
  classical
  rw [Algebra.trace_eq_matrix_trace b, Matrix.trace]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Matrix.diag_apply, Algebra.leftMulMatrix_eq_repr_mul]
  rfl

/-- 座標は $\psi$ の対で書ける（$[\theta^j]w=\psi(c_j\,w)$）。段 1 から線形性で出る。 -/
theorem coord_eq_psi_eulerC (hb : IsPowerBasisOf b θ) (hred : IsReductionOf ρ θ m)
    (j : Fin (m + 1)) (w : A) :
    coord b j w = psi b (eulerC ρ θ m (m - (j : ℕ)) * w) := by
  classical
  have hjm : (j : ℕ) ≤ m := Nat.lt_succ_iff.mp j.isLt
  -- 基底の上で一致することを段 1 から出す。
  have key : ∀ i : Fin (m + 1),
      psi b (eulerC ρ θ m (m - (j : ℕ)) * b i) = if i = j then 1 else 0 := by
    intro i
    have him : (i : ℕ) ≤ m := Nat.lt_succ_iff.mp i.isLt
    rw [hb i, psi_eulerC_mul_pow b hb hred (m - (j : ℕ)) (Nat.sub_le _ _) (i : ℕ) him]
    by_cases h : i = j
    · subst h
      simp [Nat.add_sub_cancel' him]
    · have hne : (i : ℕ) + (m - (j : ℕ)) ≠ m := fun hc => h (Fin.ext (by omega))
      simp [hne, h]
  conv_rhs => rw [← b.sum_repr w]
  rw [Finset.mul_sum, psi_sum]
  have hterm : ∀ i : Fin (m + 1),
      psi b (eulerC ρ θ m (m - (j : ℕ)) * b.repr w i • b i)
        = b.repr w i * (if i = j then 1 else 0) := by
    intro i
    rw [mul_smul_comm, psi_smul, key i]
  rw [Finset.sum_congr rfl fun i _ => hterm i]
  simp [coord]

/-- **段 4**。$\mathrm{Tr}(z)=\psi(\rho'(\theta)\,z)$。 -/
theorem trace_eq_psi_derivative_mul (hb : IsPowerBasisOf b θ) (hred : IsReductionOf ρ θ m)
    (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) (z : A) :
    Algebra.trace R A z = psi b (aeval θ (derivative ρ) * z) := by
  classical
  rw [trace_eq_sum_coord b z]
  have hterm : ∀ j : Fin (m + 1),
      coord b j (z * b j) = psi b (eulerC ρ θ m (m - (j : ℕ)) * θ ^ (j : ℕ) * z) := by
    intro j
    rw [coord_eq_psi_eulerC b hb hred j, hb j]
    congr 1
    ring
  rw [Finset.sum_congr rfl fun j _ => hterm j, ← psi_sum]
  congr 1
  rw [← Finset.sum_mul, ← sum_eulerC_mul_pow (θ := θ) hmonic hdeg,
    Fin.sum_univ_eq_sum_range (fun i => eulerC ρ θ m (m - i) * θ ^ i) (m + 1)]

/-- **段 5**。$\mathrm{Tr}(c_i\,w)=[\theta^i](\rho'(\theta)\,w)$。

体の上の `WStarElementaryDivisors.trace_coeff_minpolyDiv_mul` に対応する主張で、
そちらは分離性（トレース形式の非退化性）を使うが、こちらは使わない。 -/
theorem trace_eulerC_mul (hb : IsPowerBasisOf b θ) (hred : IsReductionOf ρ θ m)
    (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) (i : Fin (m + 1)) (w : A) :
    Algebra.trace R A (eulerC ρ θ m (m - (i : ℕ)) * w)
      = coord b i (aeval θ (derivative ρ) * w) := by
  rw [trace_eq_psi_derivative_mul b hb hred hmonic hdeg,
    coord_eq_psi_eulerC b hb hred i]
  congr 1
  ring

end Trace

/-! ## 段 6: 本文の $C\,G=M_\eta$ の可換環版

体の上の `WStarElementaryDivisors.eulerMatrix_mul_weightedGram` と同じ主張を、
体も分離性も既約性も仮定せずに述べる。**命題 W\* に残っていた穴はここである。** -/

section Matrices

variable {m : ℕ} {ρ : R[X]} {θ : A} (b : Basis (Fin (m + 1)) R A)

/-- Euler の係数行列（可換環版）。第 $i$ 行は $c_i$ を冪基底で表したもの。 -/
noncomputable def eulerMatrix (ρ : R[X]) (θ : A) :
    Matrix (Fin (m + 1)) (Fin (m + 1)) R :=
  Matrix.of fun i j => coord b j (eulerC ρ θ m (m - (i : ℕ)))

/-- 重み付き Gram 行列（可換環版）。 -/
noncomputable def weightedGram (θ : A) (μ : A) :
    Matrix (Fin (m + 1)) (Fin (m + 1)) R :=
  Matrix.of fun j k => Algebra.trace R A (μ * θ ^ ((j : ℕ) + (k : ℕ)))

/-- **$C$ は $\rho$ の係数の Hankel 行列である**（可換環版）。$C_{ij}=\rho_{i+j+1}$。

`WStarIntegralDescent.lean` が体の上で `eulerMatrix_eq_eulerHankel` として書いていたものに対応する。
反対角線が $\rho_{m+1}=1$、その下が $0$ なので、
`WStarIntegralDescent.isUnit_det_eulerHankel` と繋いで $\det C=\pm1$ が可換環の上で出る。 -/
theorem eulerMatrix_apply (hb : IsPowerBasisOf b θ) (hmonic : ρ.Monic)
    (hdeg : ρ.natDegree = m + 1) (i j : Fin (m + 1)) :
    eulerMatrix b ρ θ i j = ρ.coeff ((i : ℕ) + (j : ℕ) + 1) := by
  classical
  have him : (i : ℕ) ≤ m := Nat.lt_succ_iff.mp i.isLt
  have hjm : (j : ℕ) ≤ m := Nat.lt_succ_iff.mp j.isLt
  have hmi : m - (m - (i : ℕ)) = (i : ℕ) := by omega
  rw [eulerMatrix, Matrix.of_apply,
    eulerC_eq_sum hmonic hdeg (m - (i : ℕ)) (Nat.sub_le _ _), hmi, coord_sum]
  have hterm : ∀ t ∈ range (m - (i : ℕ) + 1),
      coord b j (algebraMap R A (ρ.coeff ((i : ℕ) + 1 + t)) * θ ^ t)
        = ρ.coeff ((i : ℕ) + 1 + t) * (if t = (j : ℕ) then 1 else 0) := by
    intro t ht
    have htm : t ≤ m := by have := Finset.mem_range.mp ht; omega
    rw [← Algebra.smul_def, coord_smul]
    congr 1
    have hc := coord_pow b hb j ⟨t, Nat.lt_succ_of_le htm⟩
    have hcast : ((⟨t, Nat.lt_succ_of_le htm⟩ : Fin (m + 1)) : ℕ) = t := rfl
    rw [hcast] at hc
    rw [hc]
    congr 1
    exact propext ⟨fun h => congrArg Fin.val h, fun h => Fin.ext h⟩
  rw [Finset.sum_congr rfl hterm]
  by_cases hle : (j : ℕ) ≤ m - (i : ℕ)
  · rw [Finset.sum_eq_single (j : ℕ)]
    · have hidx : (i : ℕ) + 1 + (j : ℕ) = (i : ℕ) + (j : ℕ) + 1 := by omega
      simp [hidx]
    · intro t _ ht; simp [ht]
    · intro h; exact absurd (Finset.mem_range.mpr (by omega)) h
  · have hzero : ∀ t ∈ range (m - (i : ℕ) + 1),
        ρ.coeff ((i : ℕ) + 1 + t) * (if t = (j : ℕ) then 1 else 0) = 0 := by
      intro t ht
      have hne : t ≠ (j : ℕ) := by have := Finset.mem_range.mp ht; omega
      simp [hne]
    rw [Finset.sum_congr rfl hzero, Finset.sum_const_zero]
    symm
    apply Polynomial.coeff_eq_zero_of_natDegree_lt
    omega

/-- **段 6（本文の $C\,G=M_\eta$、可換環版）**。$\eta=\rho'(\theta)\mu$。

$\rho$ が可約でも重根を持ってもよい。体でも整域でも分離的でもない $A$ で成り立つ。 -/
theorem eulerMatrix_mul_weightedGram (hb : IsPowerBasisOf b θ) (hred : IsReductionOf ρ θ m)
    (hmonic : ρ.Monic) (hdeg : ρ.natDegree = m + 1) (μ : A) :
    eulerMatrix b ρ θ * weightedGram (R := R) θ μ
      = Algebra.leftMulMatrix b (aeval θ (derivative ρ) * μ) := by
  classical
  ext i k
  simp only [eulerMatrix, weightedGram, Matrix.of_apply, Matrix.mul_apply,
    Algebra.leftMulMatrix_eq_repr_mul]
  have hexp : eulerC ρ θ m (m - (i : ℕ))
      = ∑ j, b.repr (eulerC ρ θ m (m - (i : ℕ))) j • b j :=
    (b.sum_repr _).symm
  calc ∑ j, coord b j (eulerC ρ θ m (m - (i : ℕ)))
        * Algebra.trace R A (μ * θ ^ ((j : ℕ) + (k : ℕ)))
      = Algebra.trace R A (eulerC ρ θ m (m - (i : ℕ)) * (μ * b k)) := by
        conv_rhs => rw [hexp]
        rw [Finset.sum_mul, map_sum]
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [smul_mul_assoc, map_smul, smul_eq_mul, hb j, hb k]
        congr 2
        rw [pow_add]
        ring
    _ = coord b i (aeval θ (derivative ρ) * (μ * b k)) :=
        trace_eulerC_mul b hb hred hmonic hdeg i _
    _ = b.repr (aeval θ (derivative ρ) * μ * b k) i := by
        rw [coord, mul_assoc]

end Matrices

end EulerDualBasis
end IntegrableLattice
