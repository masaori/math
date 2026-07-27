/-
# 半正定値双線型形式の Cauchy–Schwarz とレイリー商評価（抽象版）

人手証明のラベル:

- `psd_cauchy_schwarz`（`structured-latex/content/011_max_eigenvalue.ts`,
  `maxeig_005_claim_psd_cauchy_schwarz`）
- `rayleigh_bounds_operator_norm`（同 `maxeig_007_claim_operator_bound`）
- `trace_power_sandwich` Step 2（モーメント列の対数凸性、同
  `maxeig_008_claim_trace_power_sandwich`）

対応する具体版は `Ising2D/Part011/Claim005_PsdCauchySchwarz.lean`,
`Ising2D/Part011/Claim007_OperatorBound.lean`,
`Ising2D/Part011/Claim008_TracePowerSandwich.lean`。

## この主張に本質的に効いている構造（＝具体版が過剰な構造を要求していないかの検査）

1. **Cauchy–Schwarz**（`psd_cauchy_schwarz_bilin`）に効いているのは
   **係数が線型順序体であること**と、**形式が双線型・対称・半正定値であること**だけである。
   実数であること・行列であること・有限次元であること・内積であること・完備性は効いていない。
   証明で使うのは `q(t) = a t² + 2 b t + c ≥ 0 (∀t)` から `b² ≤ a c` を出す代入計算だけで、
   これは順序体の四則演算で閉じている。

2. **レイリー商が作用素の「ノルム」を抑えること**（`rayleigh_bounds_form`）に効いているのは、
   **2 つの対称双線型形式 `S`（内積の役）と `B`（`x ↦ xᵀWx` の役）が
   `B u v = S u (W v)` で結ばれていること**、両者が半正定値であること、
   そして `B z z ≤ c · S z z` だけである。
   **`S` の正定値性は要らない**（半正定値で足りる）。
   さらに `W` の具体形も、行列であることも、次元の有限性も、平方根（ノルムそのもの）も
   効いていない。人手証明が `‖Wx‖ ≤ c‖x‖` と平方根で書いているところは、
   抽象版では `S (W x) (W x) ≤ c² · S x x` という**平方根を経由しない不等式**になり、
   実数の完備性（平方根の存在）が不要であることが分かる。

3. **モーメント列の対数凸性 `m_k² ≤ m_{k-1} m_{k+1}`**（`moment_sq_le_mul`）に効いているのは、
   上と同じ構造に加えて **`W` が `S` について自己共役であること**（`S u (W v) = S (W u) v`）だけである。
   `W` の正定値性すら使わない（正定値性は人手証明では `m_k > 0` を言うために別途使われるが、
   対数凸性そのものには不要）。

-/
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.LinearAlgebra.BilinearMap
import Mathlib.Tactic.Ring
import Mathlib.Tactic.Linarith

namespace Ising2D.Abstract

variable {K V : Type*} [Field K] [LinearOrder K] [IsStrictOrderedRing K]
  [AddCommGroup V] [Module K V]

/-- 双線型形式の展開: `B (y + t • x) (y + t • x) = B y y + 2t·B y x + t²·B x x`。
対称性 `B x y = B y x` を使っている。 -/
theorem bilin_add_smul_self (B : V →ₗ[K] V →ₗ[K] K) (hsymm : ∀ u v, B u v = B v u)
    (x y : V) (t : K) :
    B (y + t • x) (y + t • x)
      = (B x x) * t ^ 2 + 2 * (B y x) * t + (B y y) := by
  simp only [map_add, LinearMap.add_apply, map_smul, LinearMap.smul_apply, smul_eq_mul]
  rw [hsymm x y]
  ring

/-- **半正定値双線型形式に対する Cauchy–Schwarz の不等式**（抽象版）。

人手証明のラベル `psd_cauchy_schwarz`。

係数は線型順序体なら何でもよく、`V` は任意の加群でよい。 -/
theorem psd_cauchy_schwarz_bilin (B : V →ₗ[K] V →ₗ[K] K)
    (hsymm : ∀ u v, B u v = B v u) (hpsd : ∀ v, 0 ≤ B v v) (x y : V) :
    (B y x) ^ 2 ≤ (B x x) * (B y y) := by
  set a := B x x with ha
  set b := B y x with hb
  set c := B y y with hc
  -- `q t = a t² + 2 b t + c ≥ 0` が全ての `t` で成り立つ
  have hq : ∀ t : K, 0 ≤ a * t ^ 2 + 2 * b * t + c := by
    intro t
    have := hpsd (y + t • x)
    rwa [bilin_add_smul_self B hsymm x y t] at this
  have ha0 : 0 ≤ a := hpsd x
  rcases eq_or_lt_of_le ha0 with hzero | hpos
  · -- (ii) `a = 0` の場合。1 次の係数は 0 でなければならない。
    have ha' : a = 0 := hzero.symm
    have hb0 : b = 0 := by
      by_contra hne
      -- `t = -(c + 1) / (2 b)` を代入すると `q t = -1 < 0`
      have h2b : (2 : K) * b ≠ 0 := by
        simpa using mul_ne_zero (two_ne_zero) hne
      have := hq (-(c + 1) / (2 * b))
      rw [ha'] at this
      have hcalc : (0 : K) * (-(c + 1) / (2 * b)) ^ 2
          + 2 * b * (-(c + 1) / (2 * b)) + c = -1 := by
        field_simp
      rw [hcalc] at this
      linarith
    rw [hb0, ha']
    simpa using mul_nonneg (le_of_eq ha'.symm) (hpsd y)
  · -- (i) `a > 0` の場合。`t = -b/a` を代入する。
    have := hq (-b / a)
    have hcalc : a * (-b / a) ^ 2 + 2 * b * (-b / a) + c = c - b ^ 2 / a := by
      field_simp
      ring
    rw [hcalc] at this
    have : b ^ 2 / a ≤ c := by linarith
    calc b ^ 2 = (b ^ 2 / a) * a := by field_simp
      _ ≤ c * a := by exact mul_le_mul_of_nonneg_right this (le_of_lt hpos)
      _ = a * c := mul_comm _ _

/-!
## レイリー商が作用素を抑えること（抽象版）

`S` は「内積」の役、`B` は `x ↦ xᵀ W x` の役をする対称半正定値双線型形式で、
`B u v = S u (W v)` で結ばれている。
-/

section Rayleigh

variable (S B : V →ₗ[K] V →ₗ[K] K) (W : V →ₗ[K] V)

/-- **`S (W x) (W x) ≤ c² · S x x`**（人手証明 `rayleigh_bounds_operator_norm` の抽象版）。

人手証明が `‖Wx‖ ≤ c‖x‖` と書いているものの、平方根を経由しない形。
実数の完備性も内積空間の構造も使わない。 -/
theorem rayleigh_bounds_form
    (hSsymm : ∀ u v, S u v = S v u) (hSpsd : ∀ v, 0 ≤ S v v)
    (hBsymm : ∀ u v, B u v = B v u) (hBpsd : ∀ v, 0 ≤ B v v)
    (hBS : ∀ u v, B u v = S u (W v))
    (c : K) (hc : ∀ z, B z z ≤ c * S z z) (x : V) :
    S (W x) (W x) ≤ c ^ 2 * S x x := by
  set y := W x with hy
  -- `S y y = B y x`
  have key : S y y = B y x := by rw [hBS y x]
  -- Cauchy–Schwarz
  have hcs : (B y x) ^ 2 ≤ (B x x) * (B y y) :=
    psd_cauchy_schwarz_bilin B hBsymm hBpsd x y
  have hSyy : 0 ≤ S y y := hSpsd y
  have hSxx : 0 ≤ S x x := hSpsd x
  have hcx : B x x ≤ c * S x x := hc x
  have hcy : B y y ≤ c * S y y := hc y
  have hBxx0 : 0 ≤ B x x := hBpsd x
  have hByy0 : 0 ≤ B y y := hBpsd y
  -- `c ≥ 0`: `0 ≤ B x x ≤ c * S x x` だけからは出ないので、`S y y = 0` の場合分けで処理する
  rcases eq_or_lt_of_le hSyy with h0 | hpos
  · -- `S y y = 0` なら左辺は 0、右辺は `c² S x x ≥ 0`
    rw [← h0]
    exact mul_nonneg (sq_nonneg c) hSxx
  · -- `S y y > 0`
    have h1 : (S y y) ^ 2 ≤ (c * S x x) * (c * S y y) := by
      calc (S y y) ^ 2 = (B y x) ^ 2 := by rw [key]
        _ ≤ (B x x) * (B y y) := hcs
        _ ≤ (c * S x x) * (c * S y y) := by
            exact mul_le_mul hcx hcy hByy0 (le_trans hBxx0 hcx)
    have h2 : (S y y) * (S y y) ≤ (c ^ 2 * S x x) * (S y y) := by
      calc (S y y) * (S y y) = (S y y) ^ 2 := by ring
        _ ≤ (c * S x x) * (c * S y y) := h1
        _ = (c ^ 2 * S x x) * (S y y) := by ring
    exact le_of_mul_le_mul_right h2 hpos

end Rayleigh

/-!
## モーメント列の対数凸性（抽象版）

人手証明 `trace_power_sandwich` の Step 2。
-/

section Moments

variable (S B : V →ₗ[K] V →ₗ[K] K) (W : V →ₗ[K] V)

/-- `m_k := S x (W^k x)` （モーメント列）。 -/
noncomputable def moment (S : V →ₗ[K] V →ₗ[K] K) (W : V →ₗ[K] V) (x : V) (k : ℕ) : K :=
  S x ((W ^ k) x)

/-- `W` が `S` について自己共役なら、`W` の冪を左右へ振り分けられる:
`m_{a+b} = S (W^a x) (W^b x)`。 -/
theorem moment_split (hself : ∀ u v, S u (W v) = S (W u) v) (x : V) :
    ∀ a b : ℕ, moment S W x (a + b) = S ((W ^ a) x) ((W ^ b) x) := by
  intro a
  induction a with
  | zero => intro b; simp [moment]
  | succ a ih =>
      intro b
      have hcomm : (W ^ (a + 1)) x = (W ^ a) (W x) := by
        rw [pow_succ']
        rfl
      have hstep : moment S W x (a + 1 + b) = moment S W (W x) (a + b) := by
        unfold moment
        have : (W ^ (a + 1 + b)) x = (W ^ (a + b)) (W x) := by
          rw [show a + 1 + b = (a + b) + 1 by ring, pow_succ']
          rfl
        rw [this, hself x ((W ^ (a + b)) x)]
        -- `S x (W ((W^{a+b}) x))` を `S (W x) ((W^{a+b}) x)` へ
        rfl
      rw [hstep, ih b, hcomm]
      -- `S ((W^a) (W x)) ((W^b) x)` と `S ((W^{a+1}) x) ((W^b) x)` は同じ
      rfl

/-- `m_{a+b+1} = B (W^a x) (W^b x)`。 -/
theorem moment_split_succ (hself : ∀ u v, S u (W v) = S (W u) v)
    (hBS : ∀ u v, B u v = S u (W v)) (x : V) (a b : ℕ) :
    moment S W x (a + b + 1) = B ((W ^ a) x) ((W ^ b) x) := by
  rw [hBS]
  have h := moment_split S W hself x a (b + 1)
  have heq : a + (b + 1) = a + b + 1 := by ring
  rw [heq] at h
  rw [h]
  congr 1
  rw [pow_succ']
  rfl

/-- 奇数側の対数凸性: `m_{a+b+1}² ≤ m_{2a+1} · m_{2b+1}`。 -/
theorem moment_sq_le_odd (hself : ∀ u v, S u (W v) = S (W u) v)
    (hBsymm : ∀ u v, B u v = B v u) (hBpsd : ∀ v, 0 ≤ B v v)
    (hBS : ∀ u v, B u v = S u (W v)) (x : V) (a b : ℕ) :
    (moment S W x (a + b + 1)) ^ 2
      ≤ moment S W x (a + a + 1) * moment S W x (b + b + 1) := by
  rw [moment_split_succ S B W hself hBS x a b,
    moment_split_succ S B W hself hBS x a a,
    moment_split_succ S B W hself hBS x b b]
  rw [hBsymm ((W ^ a) x) ((W ^ b) x)]
  exact psd_cauchy_schwarz_bilin B hBsymm hBpsd _ _

/-- 偶数側の対数凸性: `m_{a+b}² ≤ m_{2a} · m_{2b}`。 -/
theorem moment_sq_le_even (hself : ∀ u v, S u (W v) = S (W u) v)
    (hSsymm : ∀ u v, S u v = S v u) (hSpsd : ∀ v, 0 ≤ S v v) (x : V) (a b : ℕ) :
    (moment S W x (a + b)) ^ 2 ≤ moment S W x (a + a) * moment S W x (b + b) := by
  rw [moment_split S W hself x a b, moment_split S W hself x a a,
    moment_split S W hself x b b]
  rw [hSsymm ((W ^ a) x) ((W ^ b) x)]
  exact psd_cauchy_schwarz_bilin S hSsymm hSpsd _ _

/-- **モーメント列の対数凸性** `m_k² ≤ m_{k-1} m_{k+1}`（人手証明 `trace_power_sandwich` Step 2）。

`k` の偶奇で、偶数側・奇数側の Cauchy–Schwarz を使い分ける。 -/
theorem moment_sq_le_mul (hself : ∀ u v, S u (W v) = S (W u) v)
    (hSsymm : ∀ u v, S u v = S v u) (hSpsd : ∀ v, 0 ≤ S v v)
    (hBsymm : ∀ u v, B u v = B v u) (hBpsd : ∀ v, 0 ≤ B v v)
    (hBS : ∀ u v, B u v = S u (W v)) (x : V) (k : ℕ) :
    (moment S W x (k + 1)) ^ 2 ≤ moment S W x k * moment S W x (k + 2) := by
  rcases Nat.even_or_odd k with hk | hk
  · -- `k = j + j` が偶数のとき。`k+1 = a+b`, `2a = k`, `2b = k+2` を満たすのは
    -- `a = j`, `b = j+1` なので、偶数側（`P = S` の Cauchy–Schwarz）を使う。
    obtain ⟨j, hj⟩ := hk
    subst hj
    have h := moment_sq_le_even S W hself hSsymm hSpsd x j (j + 1)
    have e1 : j + (j + 1) = j + j + 1 := by omega
    have e2 : (j + 1) + (j + 1) = j + j + 2 := by omega
    rw [e1, e2] at h
    exact h
  · -- `k = 2j+1` が奇数のとき。`k+1 = a+b+1`, `2a+1 = k`, `2b+1 = k+2` を満たすのは
    -- `a = j`, `b = j+1` なので、奇数側（`P = B` の Cauchy–Schwarz）を使う。
    obtain ⟨j, hj⟩ := hk
    subst hj
    have h := moment_sq_le_odd S B W hself hBsymm hBpsd hBS x j (j + 1)
    have e1 : j + (j + 1) + 1 = 2 * j + 1 + 1 := by omega
    have e2 : j + j + 1 = 2 * j + 1 := by omega
    have e3 : (j + 1) + (j + 1) + 1 = 2 * j + 1 + 2 := by omega
    rw [e1, e2, e3] at h
    exact h

end Moments

end Ising2D.Abstract
