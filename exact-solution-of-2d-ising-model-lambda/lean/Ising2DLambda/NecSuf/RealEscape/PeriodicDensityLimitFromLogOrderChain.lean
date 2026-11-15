import Mathlib

/-!
「周期境界の自由エネルギー密度は分散因子の積分に等しい」（`theorem_periodic_density_onsager_integral`）のうち、
対数の鎖と実数列 `e_L · rlog(M_L)` の極限 `I` から、下組の上限が `I` であることを得る段の必要十分版。

具体版 `Ising2DLambda.RealEscape.periodicFreeEnergyDensity_eq_of_logOrderChain` と同じ手順で示す:
鎖 `lg M − 2·lg 2 ≤ Φ ≤ lg M + lg 2` を `emb_L` で移す。`ρ(emb_L(λ)) = e_L · rlog(rat λ)`、
`rat(lg M − 2·lg 2) = M/4`、`rat(lg M + lg 2) = 2M`、`rlog(M/4) = rlog M − 2·rlog 2`、`rlog(2M) = rlog 2 + rlog M`
で両側の実数評価を得る。`e_L → 0` との挟み込みで `ρ(x_L) → I`、最後に上限の性質 `hsup` を当てる。

使うのは次だけである。
* 対数の行き先 `G` は可換加法群（`lg M − 2·lg 2` を書くのに逆元が要る）。`G` の関係 `leG` の性質は使わない。
* `lg : ℚ → G` は正の元の積を和へ送る（`hmul`）。冪の法則 `lg 4 = 2·lg 2` は指数 `2` では積の法則を一度当てることなので
  仮定に置かない。`rat : G → ℚ` は正の元の上で `lg` の左逆（`hrat`）。
* 埋め込みと有理数倍をまとめた `emb : ℕ → G → H` は `L ≥ 1` で関係を保つ（`hemb`。同値の逆向きは使わない）。
  `H` の関係 `leH` の性質も使わない。
* `ρ : H → ℝ` は関係を保つ（`hρ`）。`ρ(emb_L(λ)) = e_L · rlog(rat λ)`（`hρemb`）。
* `rlog : ℚ → ℝ` は正の元の積を和へ送る（`hrlog`）。単調性・`rlog 2 > 0` は使わない。
* 係数列 `e` は `0` に収束する（`he`）。具体版では `e_L = L^{-2}`。
* 上限の汎関数 `F` は「`ρ(l_L) → I` なら `F l = I`」（`hsup`）。具体版では
  `claim_sequence_lower_set_sup_eq_real_limit` がこれを与える。
* 実数の側で使うのは四則と、極限の和・定数倍・挟み込みだけである。

住処: 一般の可換加法群と ℚ・ℝ。実数体への脱出: 実数列の極限。
-/

namespace Ising2DLambda.NecSuf.RealEscape

open Filter Topology

/-- 必要十分版: 鎖と `e_L · rlog(M_L) → I`、`e_L → 0` から `F x = I`。 -/
theorem sup_eq_of_logOrderChain_necSuf {G H : Type*} [AddCommGroup G]
    (leG : G → G → Prop) (leH : H → H → Prop) (lg : ℚ → G) (rat : G → ℚ) (rlog : ℚ → ℝ)
    (emb : ℕ → G → H) (ρ : H → ℝ) (e : ℕ → ℝ) (F : (ℕ → H) → ℝ)
    (hmul : ∀ {a b : ℚ}, 0 < a → 0 < b → lg (a * b) = lg a + lg b)
    (hrat : ∀ {a : ℚ}, 0 < a → rat (lg a) = a)
    (hrlog : ∀ {a b : ℚ}, 0 < a → 0 < b → rlog (a * b) = rlog a + rlog b)
    (hemb : ∀ L : ℕ, 1 ≤ L → ∀ {x y : G}, leG x y → leH (emb L x) (emb L y))
    (hρ : ∀ {x y : H}, leH x y → ρ x ≤ ρ y)
    (hρemb : ∀ L : ℕ, 1 ≤ L → ∀ l : G, ρ (emb L l) = e L * rlog (rat l))
    (he : Tendsto e atTop (𝓝 0))
    (hsup : ∀ (l : ℕ → H) (J : ℝ), Tendsto (fun L => ρ (l L)) atTop (𝓝 J) → F l = J)
    (M : ℕ → ℚ) (Φ : ℕ → G) (x : ℕ → H) (I : ℝ)
    (hM : ∀ L : ℕ, 1 ≤ L → 0 < M L)
    (hchain : ∀ L : ℕ, 1 ≤ L → leG (lg (M L) - 2 • lg 2) (Φ L) ∧ leG (Φ L) (lg (M L) + lg 2))
    (hx : ∀ L : ℕ, 1 ≤ L → x L = emb L (Φ L))
    (hlim : Tendsto (fun L => e L * rlog (M L)) atTop (𝓝 I)) :
    F x = I := by
  have h2 : (0 : ℚ) < 2 := by norm_num
  -- rlog 4 = 2·rlog 2（積の法則を 2·2 に一度）
  have hr4 : rlog 4 = 2 * rlog 2 := by
    have h4 : (4 : ℚ) = 2 * 2 := by norm_num
    rw [h4, hrlog h2 h2]; ring
  have hb : ∀ L : ℕ, 1 ≤ L →
      e L * rlog (M L) - 2 * (e L * rlog 2) ≤ ρ (x L) ∧
        ρ (x L) ≤ e L * rlog (M L) + e L * rlog 2 := by
    intro L hL
    have hML := hM L hL
    have hM4 : 0 < M L / 4 := by positivity
    -- rat(lg M − 2·lg 2) = M/4
    have hlow_rat : rat (lg (M L) - 2 • lg 2) = M L / 4 := by
      have h : lg (M L) - 2 • lg 2 = lg (M L / 4) := by
        have h4 : lg 4 = 2 • lg 2 := by
          have h4' : (4 : ℚ) = 2 * 2 := by norm_num
          rw [h4', hmul h2 h2, two_nsmul]
        calc
          lg (M L) - 2 • lg 2 = lg (M L / 4 * 4) - 2 • lg 2 := by
                rw [div_mul_cancel₀ (M L) (by norm_num : (4 : ℚ) ≠ 0)]
          _ = lg (M L / 4) + lg 4 - 2 • lg 2 := by rw [hmul hM4 (by norm_num)]
          _ = lg (M L / 4) := by rw [h4, add_sub_cancel_right]
      rw [h, hrat hM4]
    -- rat(lg M + lg 2) = 2M
    have hup_rat : rat (lg (M L) + lg 2) = 2 * M L := by
      rw [add_comm, ← hmul h2 hML, hrat (by positivity)]
    -- rlog(M/4) = rlog M − 2·rlog 2
    have hlow_log : rlog (M L / 4) = rlog (M L) - 2 * rlog 2 := by
      have h := hrlog hM4 (by norm_num : (0 : ℚ) < 4)
      rw [div_mul_cancel₀ (M L) (by norm_num : (4 : ℚ) ≠ 0), hr4] at h
      linarith
    constructor
    · calc
        e L * rlog (M L) - 2 * (e L * rlog 2) = e L * rlog (M L / 4) := by rw [hlow_log]; ring
        _ = e L * rlog (rat (lg (M L) - 2 • lg 2)) := by rw [hlow_rat]
        _ = ρ (emb L (lg (M L) - 2 • lg 2)) := (hρemb L hL _).symm
        _ ≤ ρ (emb L (Φ L)) := hρ (hemb L hL (hchain L hL).1)
        _ = ρ (x L) := by rw [hx L hL]
    · calc
        ρ (x L) = ρ (emb L (Φ L)) := by rw [hx L hL]
        _ ≤ ρ (emb L (lg (M L) + lg 2)) := hρ (hemb L hL (hchain L hL).2)
        _ = e L * rlog (rat (lg (M L) + lg 2)) := hρemb L hL _
        _ = e L * rlog (2 * M L) := by rw [hup_rat]
        _ = e L * rlog (M L) + e L * rlog 2 := by rw [hrlog h2 hML]; ring
  have he2 : Tendsto (fun L => e L * rlog 2) atTop (𝓝 0) := by
    simpa using he.mul_const (rlog 2)
  have hlower : Tendsto (fun L => e L * rlog (M L) - 2 * (e L * rlog 2)) atTop (𝓝 I) := by
    simpa using hlim.sub (he2.const_mul 2)
  have hupper : Tendsto (fun L => e L * rlog (M L) + e L * rlog 2) atTop (𝓝 I) := by
    simpa using hlim.add he2
  have hev := eventually_atTop.2 ⟨1, hb⟩
  exact hsup x I (tendsto_of_tendsto_of_tendsto_of_le_of_le' hlower hupper
    (hev.mono fun _ h => h.1) (hev.mono fun _ h => h.2))

end Ising2DLambda.NecSuf.RealEscape
