import Ising2DLambda.NecSuf.KacWard.PartitionLogOrderBounds
import Ising2DLambda.NecSuf.RealEscape.PeriodicDensityModeMaxLimit
import Ising2DLambda.NecSuf.RealEscape.PeriodicDensityLimitFromLogOrderChain
import Ising2DLambda.NecSuf.RealEscape.OnsagerHyperbolicIntegralRewrite

/-!
「周期境界の自由エネルギー密度は分散因子の積分に等しい」（`theorem_periodic_density_onsager_integral`）と
「分散因子の積分の Onsager 表示への書換え」（`claim_onsager_hyperbolic_integral_form`）の合成の段のうち、
対数の鎖を符号の二場合の評価から与え、成分ごとの極限 `hmode` だけを外から受ける段の必要十分版。

具体版 `Ising2DLambda.RealEscape.periodicFreeEnergyDensity_eq_dispersionIntegral_of_modeLimits`・
`periodicFreeEnergyDensity_onsagerForm_of_modeLimits` と同じ手順で示す:
1. 各 `L ≥ 1` で、符号の二場合の評価から対数の鎖を得る（`partition_log_order_bounds_necSuf`）、
2. 成分の極限から最大値の極限 `e_L · rlog(max_i |f_{L,i}|) → I` を得る（`tendsto_of_componentLimits_necSuf`）、
3. 鎖と最大値の極限から `F x = I` を得る（`sup_eq_of_logOrderChain_necSuf`）、
4. Onsager 表示は、3 の `F x = n·∫ lg B` に書換えの段（`onsager_hyperbolic_integral_rewrite_necSuf`）の
   `n·∫ lg B = lg 2 + lg r + n·∫ lg H` をつなぐ。

使うのは三つの段の仮定の和から、段の間で受け渡すものを除いたものだけである。
* 鎖の段の係数の体は `ℚ`（最後の段の `lg : ℚ → G` に合わせる）。`ℚ` に `2` の平方根が無いこと（`hsq`）は、
  外すと `q² + 2q − 1 = 0` の場合が残るので仮定に置く。
* 各成分 `f_{L,i}` は零でない（`hf`）。最大値の段で `|f_{L,i}| > 0` を、`rlog` を単調に使える集合に入れるのに使う。
  具体版では符号の二場合（`claim_signed_even_subgraph_rational_sign`）がこれを与える。符号の段の仮定
  （`hposLow`・`hHigh`）からは、高温側で各成分が零でないことは出ないので削れない。
* `rlog` は正の元の上で単調（`hrmono`）、係数 `e_L` は `L ≥ 1` で非負（`he0`）。最大値の段の単調性に使う。
* 最大値の段と鎖の段が受け渡す `M_L := max_i |f_{L,i}|`、`M_L > 0`、鎖そのものは仮定に置かない。
* Onsager 表示では、実数の側の対数 `lgR`・指数 `E`・積分 `Iint` の仮定は書換えの段と同じで、
  `rlog` と `lgR` の関係は使わない（極限 `I` を `n·Iint(lgR ∘ B)` と置くだけである）。

住処: 一般の可換加法群と ℚ・ℝ。実数体への脱出: 実数列の極限、上限、積分。
-/

namespace Ising2DLambda.NecSuf.RealEscape

open Filter Topology
open Ising2DLambda.NecSuf.KacWard

/-- 必要十分版: 符号の二場合の評価と成分ごとの極限から `F x = I`。 -/
theorem sup_eq_of_signedBounds_modeLimits_necSuf {G H ι : Type*} [AddCommGroup G] [Fintype ι]
    (hne : (Finset.univ : Finset ι).Nonempty)
    (hsq : ∀ r : ℚ, r * r ≠ 2)
    (leG : G → G → Prop) (leH : H → H → Prop) (lg : ℚ → G) (rat : G → ℚ) (rlog : ℚ → ℝ)
    (emb : ℕ → G → H) (ρ : H → ℝ) (e : ℕ → ℝ) (F : (ℕ → H) → ℝ)
    (hiff : ∀ {a b : ℚ}, 0 < a → 0 < b → a ≤ b → leG (lg a) (lg b))
    (hmul : ∀ {a b : ℚ}, 0 < a → 0 < b → lg (a * b) = lg a + lg b)
    (hadd : ∀ {x y : G}, leG x y → ∀ n : G, leG (x + n) (y + n))
    (hrat : ∀ {a : ℚ}, 0 < a → rat (lg a) = a)
    (hrlog : ∀ {a b : ℚ}, 0 < a → 0 < b → rlog (a * b) = rlog a + rlog b)
    (hrmono : ∀ {a b : ℚ}, 0 < a → a ≤ b → rlog a ≤ rlog b)
    (hemb : ∀ L : ℕ, 1 ≤ L → ∀ {x y : G}, leG x y → leH (emb L x) (emb L y))
    (hρ : ∀ {x y : H}, leH x y → ρ x ≤ ρ y)
    (hρemb : ∀ L : ℕ, 1 ≤ L → ∀ l : G, ρ (emb L l) = e L * rlog (rat l))
    (he : Tendsto e atTop (𝓝 0)) (he0 : ∀ L : ℕ, 1 ≤ L → 0 ≤ e L)
    (hsup : ∀ (l : ℕ → H) (J : ℝ), Tendsto (fun L => ρ (l L)) atTop (𝓝 J) → F l = J)
    (q : ℚ) (Z : ℕ → ℚ) (f : ℕ → ι → ℚ) (Φ : ℕ → G) (x : ℕ → H) (I : ℝ)
    (hZ : ∀ L : ℕ, 1 ≤ L → 0 < Z L)
    (hΦ : ∀ L : ℕ, 1 ≤ L → Φ L = lg (Z L))
    (hf : ∀ L : ℕ, 1 ≤ L → ∀ i, f L i ≠ 0)
    (hposLow : ∀ L : ℕ, 1 ≤ L → q ^ 2 + 2 * q - 1 < 0 → ∀ i, 0 < f L i)
    (hlowLow : ∀ L : ℕ, 1 ≤ L → q ^ 2 + 2 * q - 1 < 0 → Finset.univ.sup' hne (f L) / 2 ≤ Z L)
    (hupLow : ∀ L : ℕ, 1 ≤ L → q ^ 2 + 2 * q - 1 < 0 → Z L ≤ 2 * Finset.univ.sup' hne (f L))
    (hHigh : ∀ L : ℕ, 1 ≤ L → 0 < q ^ 2 + 2 * q - 1 →
      Finset.univ.sup' hne (fun i => |f L i|) / 4 ≤ Z L ∧
        Z L ≤ 2 * Finset.univ.sup' hne (fun i => |f L i|))
    (hx : ∀ L : ℕ, 1 ≤ L → x L = emb L (Φ L))
    (hmode : ∀ i, Tendsto (fun L => e L * rlog |f L i|) atTop (𝓝 I)) :
    F x = I := by
  refine sup_eq_of_logOrderChain_necSuf leG leH lg rat rlog emb ρ e F hmul hrat hrlog hemb hρ hρemb
    he hsup (fun L => Finset.univ.sup' hne (fun i => |f L i|)) Φ x I ?_ ?_ hx ?_
  · -- M_L > 0: 成分 i₀ は零でない
    intro L hL
    exact lt_of_lt_of_le (abs_pos.mpr (hf L hL hne.choose))
      (Finset.le_sup' (fun i => |f L i|) (Finset.mem_univ hne.choose))
  · -- 鎖: 符号の二場合の評価から
    intro L hL
    rw [hΦ L hL]
    exact partition_log_order_bounds_necSuf hne hsq leG lg hiff hmul hadd q (Z L) (f L) (hZ L hL)
      (hposLow L hL) (hlowLow L hL) (hupLow L hL) (hHigh L hL)
  · -- 最大値の極限: 成分の共通極限から
    exact tendsto_of_componentLimits_necSuf (Finset.univ : Finset ι) hne (fun L i => |f L i|)
      (fun _ => {a : ℚ | 0 < a}) (fun L a => e L * rlog a)
      (fun L => e L * rlog (Finset.univ.sup' hne (fun i => |f L i|))) I
      (fun L hL i _ => abs_pos.mpr (hf L hL i))
      (fun L hL a ha b _ hab => mul_le_mul_of_nonneg_left (hrmono ha hab) (he0 L hL))
      (fun _ _ => rfl) (fun i _ => hmode i)

/-- 必要十分版: 上の `F x = n·Iint(lgR ∘ B)` に書換えの段をつないだ Onsager 表示。 -/
theorem onsagerForm_of_signedBounds_modeLimits_necSuf {G H ι X : Type*} [AddCommGroup G] [Fintype ι]
    (hne : (Finset.univ : Finset ι).Nonempty)
    (hsq : ∀ r : ℚ, r * r ≠ 2)
    (leG : G → G → Prop) (leH : H → H → Prop) (lg : ℚ → G) (rat : G → ℚ) (rlog : ℚ → ℝ)
    (emb : ℕ → G → H) (ρ : H → ℝ) (e : ℕ → ℝ) (F : (ℕ → H) → ℝ)
    (hiff : ∀ {a b : ℚ}, 0 < a → 0 < b → a ≤ b → leG (lg a) (lg b))
    (hmul : ∀ {a b : ℚ}, 0 < a → 0 < b → lg (a * b) = lg a + lg b)
    (hadd : ∀ {x y : G}, leG x y → ∀ n : G, leG (x + n) (y + n))
    (hrat : ∀ {a : ℚ}, 0 < a → rat (lg a) = a)
    (hrlog : ∀ {a b : ℚ}, 0 < a → 0 < b → rlog (a * b) = rlog a + rlog b)
    (hrmono : ∀ {a b : ℚ}, 0 < a → a ≤ b → rlog a ≤ rlog b)
    (hemb : ∀ L : ℕ, 1 ≤ L → ∀ {x y : G}, leG x y → leH (emb L x) (emb L y))
    (hρ : ∀ {x y : H}, leH x y → ρ x ≤ ρ y)
    (hρemb : ∀ L : ℕ, 1 ≤ L → ∀ l : G, ρ (emb L l) = e L * rlog (rat l))
    (he : Tendsto e atTop (𝓝 0)) (he0 : ∀ L : ℕ, 1 ≤ L → 0 ≤ e L)
    (hsup : ∀ (l : ℕ → H) (J : ℝ), Tendsto (fun L => ρ (l L)) atTop (𝓝 J) → F l = J)
    (q : ℚ) (Z : ℕ → ℚ) (f : ℕ → ι → ℚ) (Φ : ℕ → G) (x : ℕ → H)
    (hZ : ∀ L : ℕ, 1 ≤ L → 0 < Z L)
    (hΦ : ∀ L : ℕ, 1 ≤ L → Φ L = lg (Z L))
    (hf : ∀ L : ℕ, 1 ≤ L → ∀ i, f L i ≠ 0)
    (hposLow : ∀ L : ℕ, 1 ≤ L → q ^ 2 + 2 * q - 1 < 0 → ∀ i, 0 < f L i)
    (hlowLow : ∀ L : ℕ, 1 ≤ L → q ^ 2 + 2 * q - 1 < 0 → Finset.univ.sup' hne (f L) / 2 ≤ Z L)
    (hupLow : ∀ L : ℕ, 1 ≤ L → q ^ 2 + 2 * q - 1 < 0 → Z L ≤ 2 * Finset.univ.sup' hne (f L))
    (hHigh : ∀ L : ℕ, 1 ≤ L → 0 < q ^ 2 + 2 * q - 1 →
      Finset.univ.sup' hne (fun i => |f L i|) / 4 ≤ Z L ∧
        Z L ≤ 2 * Finset.univ.sup' hne (fun i => |f L i|))
    (hx : ∀ L : ℕ, 1 ≤ L → x L = emb L (Φ L))
    (r : ℝ) (hr0 : 0 < r)
    (lgR : ℝ → ℝ) (hlgR : ∀ u v : ℝ, 0 < u → 0 < v → lgR (u * v) = lgR u + lgR v)
    (E : ℝ → ℝ) (hE : ∀ u : ℝ, 0 < u → E (lgR u) = u) (hEneg : ∀ t : ℝ, E (-t) = (E t)⁻¹)
    (c₁ c₂ : X → ℝ) (hB : ∀ y, 0 < onsagerDispersionArgumentNecSuf r c₁ c₂ y)
    (Iint : (X → ℝ) → ℝ) (Adm : (X → ℝ) → Prop) (area n : ℝ)
    (hI : ∀ (a : ℝ) (g : X → ℝ), Adm g → Iint (fun y => a + g y) = area * a + Iint g)
    (hadm : Adm (fun y => lgR (onsagerHyperbolicArgumentNecSuf r c₁ c₂ y)))
    (hn : n * area = 1 / 2)
    (hmode : ∀ i, Tendsto (fun L => e L * rlog |f L i|) atTop
      (𝓝 (n * Iint (fun y => lgR (onsagerDispersionArgumentNecSuf r c₁ c₂ y))))) :
    (E (2 * (-(1 / 2) * lgR r)) + E (-(2 * (-(1 / 2) * lgR r)))) / 2 = (1 + r ^ 2) / (2 * r) ∧
      (E (2 * (-(1 / 2) * lgR r)) - E (-(2 * (-(1 / 2) * lgR r)))) / 2 = (1 - r ^ 2) / (2 * r) ∧
      (∀ y, 0 < onsagerHyperbolicArgumentNecSuf r c₁ c₂ y) ∧
      F x = lgR 2 + lgR r + n * Iint (fun y => lgR (onsagerHyperbolicArgumentNecSuf r c₁ c₂ y)) := by
  obtain ⟨hc, hs, hH, hint⟩ := onsager_hyperbolic_integral_rewrite_necSuf r hr0 lgR hlgR E hE hEneg
    c₁ c₂ hB Iint Adm area n hI hadm hn
  refine ⟨hc, hs, hH, ?_⟩
  calc F x = n * Iint (fun y => lgR (onsagerDispersionArgumentNecSuf r c₁ c₂ y)) :=
        sup_eq_of_signedBounds_modeLimits_necSuf hne hsq leG leH lg rat rlog emb ρ e F hiff hmul hadd
          hrat hrlog hrmono hemb hρ hρemb he he0 hsup q Z f Φ x _ hZ hΦ hf hposLow hlowLow hupLow
          hHigh hx hmode
    _ = lgR 2 + lgR r + n * Iint (fun y => lgR (onsagerHyperbolicArgumentNecSuf r c₁ c₂ y)) := hint

end Ising2DLambda.NecSuf.RealEscape
