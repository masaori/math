/-
# 定数 `c` の決定（**必要十分版**）

対応する人手証明のラベル: `constant_c_value_even_sector`（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）の
Step 4・Step 5。具体版は `Ising2D/EigenvalueProblem/EigenvaluesOfVPlus/ClaimConstantCEvenSector.lean` の
`constant_c_steps_four_five`、特殊化は同じフォルダの `ClaimConstantCEvenSectorFromNecSuf.lean`。

## 手順（具体版と同じ）

具体版の Step 1〜3 が作る 5 つの等式

  `T = a_K τ`（Step 1 の第一の鎖）, `T' = (a⁻¹)_K τ'`（Step 1 の第二の鎖）, `τ' = τ`（Step 2）,
  `T = c t_K`, `T' = c⁻¹ t_K`（Step 3 の二つのトレースの鎖）

と、準備の `T = r_K` を受け取り、具体版と同じ鎖を踏む。
Step 4: `w := T'` を `(a⁻¹(a⁻¹r))_K` と書き、`q := a⁻¹(a⁻¹r) > 0` から `w ≠ 0`。`c^2w = (a^2)_K w` の鎖、`w⁻¹` を掛ける鎖で `c^2 = (a^2)_K`。
Step 5: `c = (rt⁻¹)_K` の鎖、`(ρρ)_K = ρ_Kρ_K = cc = c^2 = (aa)_K` の鎖（`ρ := rt⁻¹` は名前を付けずに `r * t⁻¹` と書く）、包含の単射性で `ρρ = aa`、正の元の二乗の一意性で `ρ = a`。
具体版の `(ρρ, 0)`・`(aa, 0)` の成分の行は、`K` が一般の群なので包含の単射性の 1 段が受け持つ。

## 効いているもの / 効いていないもの

- `K`（具体版の ℂ）は**零を持つ群**（`GroupWithZero`）だけでよい。使うのは乗法の結合律、`1` が単位元、`0` でない元の逆元
  （`cc⁻¹ = 1`・`ww⁻¹ = 1`）だけで、**積の可換律も加法も効いていない**（鎖はどれも括弧の付け替えだけで進み、因子の順序を入れ替える段が無い）。
- 包含 `(·)_K : k → K`（具体版の `ℝ → ℂ`）は、**積と `0`・`1` を保つ単射**（`k →*₀ K` で単射）だけでよい。
  和を保つことは効いていない。単射性は人手の「`definition_of_cc` の元の等号は成分ごと」の 2 か所（`w ≠ 0` と `ρρ = aa`）に当たる。
- `k`（具体版の ℝ）は**順序体**（`Field`・`LinearOrder`・`IsStrictOrderedRing`）を使う。`a⁻¹`・`t⁻¹` を取るのに体、
  `q > 0`・`ρ > 0` に正の元の積と逆数が正であること（`inv_pos`。半順序では `0 < a ⇒ 0 < a⁻¹` が言えないので全順序は削れない）、`ρ = a` に `NecSuf.positive_square_injective'`（零因子の無い可換環と前順序）が要る。
  完備性・実数であることは効いていない。
- `T, T'` がトレースであること、`τ, τ'` の中身、`a = (2s_2)^{M/2}` と `t` の具体形、`r` が `V^{(+)}` の正定値性から来ることは、
  いずれも効いていない（使うのは上の 6 つの等式と `0 < a`・`0 < r`・`0 < t` だけ）。
- `c ≠ 0` は仮定として受け取る（人手の「`c ∈ ℂ^×` なので `c ≠ 0`」）。
-/
import Ising2D.NecSuf.PositiveSquareInjective
import Mathlib.Algebra.GroupWithZero.Hom
import Mathlib.Algebra.Order.Field.Basic

namespace Ising2D.NecSuf

/-- **人手証明 `constant_c_value_even_sector` Step 4・Step 5 の核**。

`φ : k →*₀ K` が単射、`c ≠ 0`、`T = φ a * τ`, `T' = φ a⁻¹ * τ'`, `τ' = τ`, `T = c * φ t`, `T' = c⁻¹ * φ t`, `T = φ r`,
`0 < a`, `0 < r`, `0 < t` ならば `c = φ a`。 -/
theorem const_eq_of_trace_chains {K k : Type*} [GroupWithZero K] [Field k] [LinearOrder k]
    [IsStrictOrderedRing k] (φ : k →*₀ K) (hφ : Function.Injective φ)
    {c τ τ' T T' : K} {a r t : k} (hcne : c ≠ 0)
    (hT : T = φ a * τ) (hT' : T' = φ a⁻¹ * τ') (hτ : τ' = τ)
    (hTc : T = c * φ t) (hT'c : T' = c⁻¹ * φ t) (hTr : T = φ r)
    (ha : 0 < a) (hr : 0 < r) (ht : 0 < t) : c = φ a := by
  have hane : a ≠ 0 := ne_of_gt ha
  have htne : t ≠ 0 := ne_of_gt ht
  -- Step 4: `w = (a⁻¹(a⁻¹r))_K`
  have hw : T' = φ (a⁻¹ * (a⁻¹ * r)) :=
    calc T' = φ a⁻¹ * τ' := hT'                                         -- Step 1 の第二の鎖
      _ = φ a⁻¹ * τ := by rw [hτ]                                        -- Step 2
      _ = φ a⁻¹ * (1 * τ) := by rw [one_mul]                             -- `1` は乗法の単位元
      _ = φ a⁻¹ * (φ (a⁻¹ * a) * τ) := by rw [inv_mul_cancel₀ hane, map_one]  -- `k` で `a⁻¹a = 1`
      _ = φ a⁻¹ * ((φ a⁻¹ * φ a) * τ) := by rw [map_mul φ a⁻¹ a]         -- 包含は積を保つ（右辺から左辺へ）
      _ = φ a⁻¹ * (φ a⁻¹ * (φ a * τ)) := by rw [mul_assoc (φ a⁻¹)]       -- 乗法の結合律
      _ = φ a⁻¹ * (φ a⁻¹ * T) := by rw [hT]                              -- Step 1 の第一の鎖を右辺から左辺へ
      _ = φ a⁻¹ * (φ a⁻¹ * φ r) := by rw [hTr]                           -- 準備の `T = r_K`
      _ = φ a⁻¹ * φ (a⁻¹ * r) := by rw [map_mul φ a⁻¹ r]                 -- 包含は積を保つ
      _ = φ (a⁻¹ * (a⁻¹ * r)) := (map_mul φ a⁻¹ (a⁻¹ * r)).symm          -- 包含は積を保つ
  -- `q > 0` から `w ≠ 0`
  have hq : 0 < a⁻¹ * (a⁻¹ * r) := mul_pos (inv_pos.2 ha) (mul_pos (inv_pos.2 ha) hr)
  have hwne : T' ≠ 0 := by
    rw [hw]
    intro h0
    exact (ne_of_gt hq) (hφ (h0.trans (map_zero φ).symm))                -- 包含の単射性
  -- Step 4: `c^2 w = (a^2)_K w`
  have hcw : (c * c) * T' = φ (a * a) * T' :=
    calc (c * c) * T' = (c * c) * (c⁻¹ * φ t) := by rw [hT'c]             -- `c^2` の定義と Step 3 の第二の鎖
      _ = c * (c * (c⁻¹ * φ t)) := mul_assoc _ _ _                       -- 乗法の結合律
      _ = c * ((c * c⁻¹) * φ t) := by rw [mul_assoc c c⁻¹]               -- 乗法の結合律
      _ = c * (1 * φ t) := by rw [mul_inv_cancel₀ hcne]                  -- `c⁻¹` は `c` の逆元
      _ = c * φ t := by rw [one_mul]                                     -- `1` は乗法の単位元
      _ = T := hTc.symm                                                  -- Step 3 の第一の鎖を右辺から左辺へ
      _ = φ a * τ := hT                                                  -- Step 1 の第一の鎖
      _ = φ a * (1 * τ) := by rw [one_mul]                               -- `1` は乗法の単位元
      _ = φ a * (φ (a * a⁻¹) * τ) := by rw [mul_inv_cancel₀ hane, map_one]  -- `k` で `aa⁻¹ = 1`
      _ = φ a * ((φ a * φ a⁻¹) * τ) := by rw [map_mul φ a a⁻¹]           -- 包含は積を保つ（右辺から左辺へ）
      _ = φ a * (φ a * (φ a⁻¹ * τ)) := by rw [mul_assoc (φ a)]           -- 乗法の結合律
      _ = φ a * (φ a * (φ a⁻¹ * τ')) := by rw [hτ]                       -- Step 2 を右辺から左辺へ
      _ = φ a * (φ a * T') := by rw [hT']                                -- Step 1 の第二の鎖を右辺から左辺へ
      _ = (φ a * φ a) * T' := (mul_assoc _ _ _).symm                     -- 乗法の結合律
      _ = φ (a * a) * T' := by rw [map_mul φ a a]                        -- 包含は積を保つと `a^2` の定義
  -- Step 4: `c^2 = (a^2)_K`
  have hc2 : c * c = φ (a * a) :=
    calc c * c = (c * c) * 1 := (mul_one _).symm                         -- `1` は乗法の単位元
      _ = (c * c) * (T' * T'⁻¹) := by rw [mul_inv_cancel₀ hwne]          -- `w⁻¹` は `w` の逆元
      _ = ((c * c) * T') * T'⁻¹ := (mul_assoc _ _ _).symm                -- 乗法の結合律
      _ = (φ (a * a) * T') * T'⁻¹ := by rw [hcw]                         -- 上の鎖
      _ = φ (a * a) * (T' * T'⁻¹) := mul_assoc _ _ _                     -- 乗法の結合律
      _ = φ (a * a) * 1 := by rw [mul_inv_cancel₀ hwne]                  -- `w⁻¹` は `w` の逆元
      _ = φ (a * a) := mul_one _                                         -- `1` は乗法の単位元
  -- Step 5: `c = ρ_K`（`ρ := rt⁻¹`）
  have hρpos : 0 < r * t⁻¹ := mul_pos hr (inv_pos.2 ht)
  have hcρ : c = φ (r * t⁻¹) :=
    calc c = c * 1 := (mul_one _).symm                                   -- `1` は乗法の単位元
      _ = c * φ (t * t⁻¹) := by rw [mul_inv_cancel₀ htne, map_one]       -- `k` で `tt⁻¹ = 1`
      _ = c * (φ t * φ t⁻¹) := by rw [map_mul φ t t⁻¹]                   -- 包含は積を保つ（右辺から左辺へ）
      _ = (c * φ t) * φ t⁻¹ := (mul_assoc _ _ _).symm                    -- 乗法の結合律
      _ = T * φ t⁻¹ := by rw [hTc]                                       -- Step 3 の第一の鎖を右辺から左辺へ
      _ = φ r * φ t⁻¹ := by rw [hTr]                                     -- 準備の `T = r_K`
      _ = φ (r * t⁻¹) := (map_mul φ r t⁻¹).symm                          -- 包含は積を保つ
  -- Step 5: `(ρρ)_K = (aa)_K` から `ρρ = aa`
  have hρρ : φ ((r * t⁻¹) * (r * t⁻¹)) = φ (a * a) :=
    calc φ ((r * t⁻¹) * (r * t⁻¹)) = φ (r * t⁻¹) * φ (r * t⁻¹) := map_mul _ _ _  -- 包含は積を保つ（右辺から左辺へ）
      _ = c * c := by rw [← hcρ]                                         -- 上の鎖の `c = ρ_K`
      _ = c ^ 2 := (sq c).symm                                           -- `c^2` の定義
      _ = φ (a * a) := by rw [sq]; exact hc2                             -- Step 4
  have hsq : (r * t⁻¹) ^ 2 = a ^ 2 := by
    rw [sq, sq]
    exact hφ hρρ                                                         -- 包含の単射性
  have hρa : r * t⁻¹ = a := (positive_square_injective' hρpos ha).1 hsq  -- 正の元の二乗の一意性
  calc c = φ (r * t⁻¹) := hcρ                                            -- 上の鎖
    _ = φ a := by rw [hρa]                                               -- `ρ = a`

end Ising2D.NecSuf
