/-
「整数冪の実対数は整数倍である」の必要十分版。

具体版が使うのは、(1) 正の実数の乗法が群をなすこと（単位元 `1`、逆元 `v⁻¹`、`v·v⁻¹ = 1`、
整数冪 `u^k` の定義 `u^0 = 1`、`u^{n+1} = u^n·u`、`u^{-(n+1)} = (u^{n+1})⁻¹`）、
(2) 値の側 `ℝ` が加法群をなすこと（`f 1 = f 1 + f 1` から `f 1 = 0` を出す移項、`-` の存在）、
(3) 写像 `f`（具体版では `log_ℝ`）が乗法を加法へ移すこと、だけである。
`G` は `Group`（可換性は使わない）、`A` は `AddGroup`（可換性・順序・実数の完備性は使わない）で足りる。
実対数の狭義単調性は使わない。証明手順は具体版と同じ（`f 1 = 0`・自然数冪の帰納法・逆数・整数冪の場合分け）。
mathlib の `MonoidHom.map_zpow` 等の既製定理は使わない（手順を自前で書く）。
-/
import Mathlib.Algebra.Group.Basic
import Mathlib.Algebra.Group.Int.Defs

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

variable {G A : Type*} [Group G] [AddGroup A]

/-- 準備: `f 1 = 0`。 -/
theorem map_one_necSuf (f : G → A) (hf : ∀ u v : G, f (u * v) = f u + f v) : f 1 = 0 := by
  have h : f 1 = f 1 + f 1 := by
    have := hf 1 1                                                    -- 乗法を加法へ
    rwa [one_mul] at this                                             -- 1·1 = 1
  -- 加法群で移項: f 1 = f 1 + f 1 ⇒ 0 = f 1
  have h2 : f 1 + f 1 - f 1 = f 1 - f 1 := by rw [← h]
  rw [add_sub_cancel_right, sub_self] at h2
  exact h2

/-- 自然数冪: `f (u^n) = n • f u`（`n` の帰納法）。 -/
theorem map_pow_necSuf (f : G → A) (hf : ∀ u v : G, f (u * v) = f u + f v) (u : G) (n : ℕ) :
    f (u ^ n) = n • f u := by
  induction n with
  | zero =>
      rw [pow_zero, zero_nsmul]                                        -- u^0 = 1
      exact map_one_necSuf f hf                                        -- 準備
  | succ n ih =>
      rw [pow_succ]                                                    -- u^{n+1} = u^n · u
      rw [hf]                                                          -- 乗法を加法へ
      rw [ih]                                                          -- 帰納法の仮定
      rw [succ_nsmul]                                                  -- (n+1) • x = n • x + x

/-- 逆数: `f v⁻¹ = -f v`。 -/
theorem map_inv_necSuf (f : G → A) (hf : ∀ u v : G, f (u * v) = f u + f v) (v : G) :
    f v⁻¹ = -f v := by
  have h1 : f 1 = 0 := map_one_necSuf f hf
  have h : f (v * v⁻¹) = f v + f v⁻¹ := hf v v⁻¹                      -- 乗法を加法へ
  rw [mul_inv_cancel, h1] at h                                        -- v·v⁻¹ = 1、f 1 = 0
  -- 加法群で移項: 0 = f v + f v⁻¹ ⇒ f v⁻¹ = -f v
  exact (neg_eq_of_add_eq_zero_right h.symm).symm

/-- 整数冪: `f (u^k) = k • f u`（`k ∈ ℤ`）。 -/
theorem map_zpow_necSuf (f : G → A) (hf : ∀ u v : G, f (u * v) = f u + f v) (u : G) (k : ℤ) :
    f (u ^ k) = k • f u := by
  cases k with
  | ofNat n =>
      rw [Int.ofNat_eq_natCast, zpow_natCast, natCast_zsmul]              -- k = n ≥ 0 は自然数冪
      exact map_pow_necSuf f hf u n
  | negSucc n =>
      rw [zpow_negSucc]                                               -- u^{-(n+1)} = (u^{n+1})⁻¹
      rw [map_inv_necSuf f hf]                                        -- 逆数
      rw [map_pow_necSuf f hf]                                        -- 自然数冪
      rw [negSucc_zsmul]                                              -- -(n+1) • x = -((n+1) • x)

end Ising2DLambda.NecSuf.ThermodynamicLimit
