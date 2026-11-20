/-
主張「虚数単位を足した体の共役は多項式の値と入れ替わる」
（ラベル `claim_imaginary_unit_extension_conjugate_evaluation`）の具体版。

  人手証明                                                    このファイル
  準備 (一) 一次式の値の全体は 0・1・和・積で閉じる           `quadraticLinearValues_ringClosed`（`a := -1`, `b := ω`）
  準備 (二) 共役は和を保つ（四行の式鎖）                        `imaginaryUnitConj_add`
  準備 (三) 共役は積を保つ（五行の式鎖）                        `imaginaryUnitConj_mul`
  準備 (四) 共役の共役は元に戻る（三行の式鎖）                  `imaginaryUnitConj_mem`・`imaginaryUnitConj_conj`
  準備 (五) 冪の共役は共役の冪（k の帰納法）                    `imaginaryUnitConj_pow`
  準備 (六) 有限和の共役は共役の有限和（項の個数の帰納法）      `imaginaryUnitConj_sum`
  主張: 所属と七行の式鎖                                        `imaginaryUnitExtension_conjugate_evaluation`

本文の `Lin_F(ω)` は `imaginaryUnitLinearValues F ω` で、`claim_quadratic_linear_values_closed` の
`S`（`quadraticLinearValues F ω`）と定義の上で同じ集合である。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionConjugate
import Ising2DLambda.FisherZero.QuadraticLinearValuesClosed
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalCoefficientSum

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 準備 (一): `Lin_F(ω)` は 0・1 を含み、和と積で閉じる（`claim_quadratic_linear_values_closed` を
`a := -1`、`b := ω` へ当てる）。 -/
theorem imaginaryUnitLinearValues_ringClosed
    (F : Subfield Qbar) (omega : Qbar) (homega : omega * omega = -1) :
    (0 : Qbar) ∈ imaginaryUnitLinearValues F omega ∧
    (1 : Qbar) ∈ imaginaryUnitLinearValues F omega ∧
    (∀ y z : Qbar, y ∈ imaginaryUnitLinearValues F omega →
      z ∈ imaginaryUnitLinearValues F omega → y + z ∈ imaginaryUnitLinearValues F omega) ∧
    (∀ y z : Qbar, y ∈ imaginaryUnitLinearValues F omega →
      z ∈ imaginaryUnitLinearValues F omega → y * z ∈ imaginaryUnitLinearValues F omega) := by
  obtain ⟨h0, h1, hadd, _, hmul⟩ :=
    quadraticLinearValues_ringClosed F (-1) omega (F.neg_mem F.one_mem) homega
  exact ⟨h0, h1, hadd, hmul⟩

/-- 準備 (二): `cj_ω(u + v) = cj_ω(u) + cj_ω(v)`。 -/
theorem imaginaryUnitConj_add
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) (u v : Qbar)
    (hu : u ∈ imaginaryUnitLinearValues F omega) (hv : v ∈ imaginaryUnitLinearValues F omega) :
    imaginaryUnitConj F omega (u + v)
      = imaginaryUnitConj F omega u + imaginaryUnitConj F omega v := by
  obtain ⟨a, b, ha, hb, rfl⟩ := hu
  obtain ⟨c, e, hc, he, rfl⟩ := hv
  calc imaginaryUnitConj F omega ((a + b * omega) + (c + e * omega))
      -- 第一の等号（四則）。
      = imaginaryUnitConj F omega ((a + c) + (b + e) * omega) := by
        rw [show (a + b * omega) + (c + e * omega) = (a + c) + (b + e) * omega by ring]
    -- 第二の等号（`a + c, b + e ∈ F` と共役の定義）。
    _ = (a + c) - (b + e) * omega :=
        imaginaryUnitConj_apply F C hC omega homega _ _ (F.add_mem ha hc) (F.add_mem hb he)
    -- 第三の等号（四則）。
    _ = (a - b * omega) + (c - e * omega) := by ring
    -- 第四の等号（共役の定義を二つの元へ当てる）。
    _ = imaginaryUnitConj F omega (a + b * omega) + imaginaryUnitConj F omega (c + e * omega) := by
        rw [imaginaryUnitConj_apply F C hC omega homega a b ha hb,
          imaginaryUnitConj_apply F C hC omega homega c e hc he]

/-- 準備 (三): `cj_ω(u · v) = cj_ω(u) · cj_ω(v)`。 -/
theorem imaginaryUnitConj_mul
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) (u v : Qbar)
    (hu : u ∈ imaginaryUnitLinearValues F omega) (hv : v ∈ imaginaryUnitLinearValues F omega) :
    imaginaryUnitConj F omega (u * v)
      = imaginaryUnitConj F omega u * imaginaryUnitConj F omega v := by
  obtain ⟨a, b, ha, hb, rfl⟩ := hu
  obtain ⟨c, e, hc, he, rfl⟩ := hv
  have hre : a * c - b * e ∈ F := F.sub_mem (F.mul_mem ha hc) (F.mul_mem hb he)
  have him : a * e + b * c ∈ F := F.add_mem (F.mul_mem ha he) (F.mul_mem hb hc)
  calc imaginaryUnitConj F omega ((a + b * omega) * (c + e * omega))
      -- 第一の等号（分配法則と `ω·ω = -1`）。
      = imaginaryUnitConj F omega ((a * c - b * e) + (a * e + b * c) * omega) := by
        rw [show (a + b * omega) * (c + e * omega)
            = (a * c - b * e) + (a * e + b * c) * omega by
          linear_combination (b * e) * homega]
    -- 第二の等号（共役の定義）。
    _ = (a * c - b * e) - (a * e + b * c) * omega :=
        imaginaryUnitConj_apply F C hC omega homega _ _ hre him
    -- 第三・第四の等号（`ω·ω = -1` と分配法則）。
    _ = (a - b * omega) * (c - e * omega) := by
        linear_combination (-(b * e)) * homega
    -- 第五の等号（共役の定義を二つの元へ当てる）。
    _ = imaginaryUnitConj F omega (a + b * omega) * imaginaryUnitConj F omega (c + e * omega) := by
        rw [imaginaryUnitConj_apply F C hC omega homega a b ha hb,
          imaginaryUnitConj_apply F C hC omega homega c e hc he]

/-- 準備 (四) の前半: `cj_ω(u) ∈ Lin_F(ω)`（`cj_ω(a + bω) = a + (-b)ω`、`-b ∈ F`）。 -/
theorem imaginaryUnitConj_mem
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) (u : Qbar)
    (hu : u ∈ imaginaryUnitLinearValues F omega) :
    imaginaryUnitConj F omega u ∈ imaginaryUnitLinearValues F omega := by
  obtain ⟨a, b, ha, hb, rfl⟩ := hu
  refine ⟨a, -b, ha, F.neg_mem hb, ?_⟩
  rw [imaginaryUnitConj_apply F C hC omega homega a b ha hb]
  ring

/-- 準備 (四): `cj_ω(cj_ω(u)) = u`。 -/
theorem imaginaryUnitConj_conj
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) (u : Qbar)
    (hu : u ∈ imaginaryUnitLinearValues F omega) :
    imaginaryUnitConj F omega (imaginaryUnitConj F omega u) = u := by
  obtain ⟨a, b, ha, hb, rfl⟩ := hu
  calc imaginaryUnitConj F omega (imaginaryUnitConj F omega (a + b * omega))
      -- 第一の等号（共役の定義と四則で `a - bω = a + (-b)ω`）。
      = imaginaryUnitConj F omega (a + (-b) * omega) := by
        rw [imaginaryUnitConj_apply F C hC omega homega a b ha hb]
        ring_nf
    -- 第二の等号（`-b ∈ F` と共役の定義）。
    _ = a - (-b) * omega := imaginaryUnitConj_apply F C hC omega homega a (-b) ha (F.neg_mem hb)
    -- 第三の等号（四則）。
    _ = a + b * omega := by ring

/-- 準備 (五): 任意の `k` で `z^k ∈ Lin_F(ω)` かつ `cj_ω(z^k) = cj_ω(z)^k`（`k` についての帰納法）。 -/
theorem imaginaryUnitConj_pow
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) (z : Qbar)
    (hz : z ∈ imaginaryUnitLinearValues F omega) (k : ℕ) :
    z ^ k ∈ imaginaryUnitLinearValues F omega ∧
      imaginaryUnitConj F omega (z ^ k) = imaginaryUnitConj F omega z ^ k := by
  obtain ⟨_, h1, _, hmul⟩ := imaginaryUnitLinearValues_ringClosed F omega homega
  induction k with
  | zero =>
      -- 出発点: `z^0 = 1 = 1 + 0ω` と `cj_ω(1) = 1 - 0ω = 1`。
      refine ⟨by rw [pow_zero]; exact h1, ?_⟩
      calc imaginaryUnitConj F omega (z ^ 0)
          = imaginaryUnitConj F omega (1 + 0 * omega) := by rw [pow_zero]; ring_nf
        _ = 1 - 0 * omega := imaginaryUnitConj_apply F C hC omega homega 1 0 F.one_mem F.zero_mem
        _ = imaginaryUnitConj F omega z ^ 0 := by ring
  | succ k ih =>
      -- 一歩: `z^{k+1} = z^k · z` と準備 (一)・(三) と帰納法の仮定。
      refine ⟨by rw [pow_succ]; exact hmul _ _ ih.1 hz, ?_⟩
      calc imaginaryUnitConj F omega (z ^ (k + 1))
          = imaginaryUnitConj F omega (z ^ k * z) := by rw [pow_succ]
        _ = imaginaryUnitConj F omega (z ^ k) * imaginaryUnitConj F omega z :=
            imaginaryUnitConj_mul F C hC omega homega _ _ ih.1 hz
        _ = imaginaryUnitConj F omega z ^ k * imaginaryUnitConj F omega z := by rw [ih.2]
        _ = imaginaryUnitConj F omega z ^ (k + 1) := by rw [pow_succ]

/-- 準備 (六): 各項が `Lin_F(ω)` に属する有限和は `Lin_F(ω)` に属し、共役は項ごとの共役の和
（項の個数 `m` についての帰納法）。 -/
theorem imaginaryUnitConj_sum
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) (x : ℕ → Qbar)
    (hx : ∀ k, x k ∈ imaginaryUnitLinearValues F omega) (m : ℕ) :
    (∑ k ∈ Finset.range m, x k) ∈ imaginaryUnitLinearValues F omega ∧
      imaginaryUnitConj F omega (∑ k ∈ Finset.range m, x k)
        = ∑ k ∈ Finset.range m, imaginaryUnitConj F omega (x k) := by
  obtain ⟨h0, _, hadd, _⟩ := imaginaryUnitLinearValues_ringClosed F omega homega
  induction m with
  | zero =>
      -- 出発点: 空の和は零元で、`cj_ω(0) = 0`。
      simp only [Finset.sum_range_zero]
      exact ⟨h0, imaginaryUnitConj_zero F C hC omega homega⟩
  | succ m ih =>
      -- 一歩: 最後の項を分け、準備 (一)・(二) と帰納法の仮定。
      rw [Finset.sum_range_succ, Finset.sum_range_succ]
      refine ⟨hadd _ _ ih.1 (hx m), ?_⟩
      rw [imaginaryUnitConj_add F C hC omega homega _ _ ih.1 (hx m), ih.2]

/-- `claim_imaginary_unit_extension_conjugate_evaluation` の具体版。
人手証明の所属の段と七行の式鎖:
`aev_{cj z}(g) = Σ_{k≤n} ac_k(g) cj(z)^k`（`claim_qbar_evaluation_coefficient_sum`）
`= Σ cj(cj(ac_k(g))) cj(z)^k`（準備 (四)）`= Σ cj(cj(ac_k(g))) cj(z^k)`（準備 (五)）
`= Σ cj(cj(ac_k(g)) z^k)`（準備 (三)）`= cj(Σ cj(ac_k(g)) z^k)`（準備 (六)）
`= cj(Σ ac_k(cjp g) z^k)`（係数の共役の定義）`= cj(aev_z(cjp g))`（`claim_qbar_evaluation_coefficient_sum`）。
`n` は `g` の次数に取る。 -/
theorem imaginaryUnitExtension_conjugate_evaluation
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) (g : QbarPoly)
    (hg : ∀ k : ℕ, g.coeff k ∈ imaginaryUnitLinearValues F omega)
    (z : Qbar) (hz : z ∈ imaginaryUnitLinearValues F omega) :
    qbarPolyEval z (imaginaryUnitConjPoly F omega g) ∈ imaginaryUnitLinearValues F omega ∧
      qbarPolyEval (imaginaryUnitConj F omega z) g
        = imaginaryUnitConj F omega (qbarPolyEval z (imaginaryUnitConjPoly F omega g)) := by
  obtain ⟨_, _, _, hmul⟩ := imaginaryUnitLinearValues_ringClosed F omega homega
  set n := g.natDegree
  have hn : ∀ k : ℕ, n < k → g.coeff k = 0 := fun k hk => Polynomial.coeff_eq_zero_of_natDegree_lt hk
  have hn' : ∀ k : ℕ, n < k → (imaginaryUnitConjPoly F omega g).coeff k = 0 := by
    intro k hk
    rw [imaginaryUnitConjPoly_coeff F C hC omega homega, hn k hk,
      imaginaryUnitConj_zero F C hC omega homega]
  -- 各項 `cj(ac_k(g)) · z^k` は `Lin_F(ω)` に属する（準備 (一)・(四)・(五)）。
  have hterm : ∀ k, imaginaryUnitConj F omega (g.coeff k) * z ^ k
      ∈ imaginaryUnitLinearValues F omega := fun k =>
    hmul _ _ (imaginaryUnitConj_mem F C hC omega homega _ (hg k))
      (imaginaryUnitConj_pow F C hC omega homega z hz k).1
  have hsum := imaginaryUnitConj_sum F C hC omega homega
    (fun k => imaginaryUnitConj F omega (g.coeff k) * z ^ k) hterm (n + 1)
  have heval : qbarPolyEval z (imaginaryUnitConjPoly F omega g)
      = ∑ k ∈ Finset.range (n + 1), imaginaryUnitConj F omega (g.coeff k) * z ^ k := by
    rw [qbarPolyEvalCoefficientSum z _ n hn']
    exact Finset.sum_congr rfl (fun k _ => by
      rw [imaginaryUnitConjPoly_coeff F C hC omega homega])
  refine ⟨by rw [heval]; exact hsum.1, ?_⟩
  calc qbarPolyEval (imaginaryUnitConj F omega z) g
      -- 第一の等号（`claim_qbar_evaluation_coefficient_sum`、`w := cj_ω(z)`）。
      = ∑ k ∈ Finset.range (n + 1), g.coeff k * imaginaryUnitConj F omega z ^ k :=
        qbarPolyEvalCoefficientSum _ g n hn
    -- 第二の等号（準備 (四) を各係数へ当てる）。
    _ = ∑ k ∈ Finset.range (n + 1),
          imaginaryUnitConj F omega (imaginaryUnitConj F omega (g.coeff k))
            * imaginaryUnitConj F omega z ^ k := by
        refine Finset.sum_congr rfl (fun k _ => ?_)
        rw [imaginaryUnitConj_conj F C hC omega homega _ (hg k)]
    -- 第三の等号（準備 (五)）。
    _ = ∑ k ∈ Finset.range (n + 1),
          imaginaryUnitConj F omega (imaginaryUnitConj F omega (g.coeff k))
            * imaginaryUnitConj F omega (z ^ k) := by
        refine Finset.sum_congr rfl (fun k _ => ?_)
        rw [(imaginaryUnitConj_pow F C hC omega homega z hz k).2]
    -- 第四の等号（準備 (三)）。
    _ = ∑ k ∈ Finset.range (n + 1),
          imaginaryUnitConj F omega (imaginaryUnitConj F omega (g.coeff k) * z ^ k) := by
        refine Finset.sum_congr rfl (fun k _ => ?_)
        rw [imaginaryUnitConj_mul F C hC omega homega _ _
          (imaginaryUnitConj_mem F C hC omega homega _ (hg k))
          (imaginaryUnitConj_pow F C hC omega homega z hz k).1]
    -- 第五の等号（準備 (六)）。
    _ = imaginaryUnitConj F omega
          (∑ k ∈ Finset.range (n + 1), imaginaryUnitConj F omega (g.coeff k) * z ^ k) :=
        hsum.2.symm
    -- 第六・第七の等号（係数の共役の定義と `claim_qbar_evaluation_coefficient_sum`）。
    _ = imaginaryUnitConj F omega (qbarPolyEval z (imaginaryUnitConjPoly F omega g)) := by
        rw [heval]

end Ising2DLambda.FisherZero
