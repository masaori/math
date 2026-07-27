/-
# `T_{(V^{(+)})} = T_{(V̌')}`

対応する人手証明のラベル: `T_V_plus_eq_T_check_Vprime`
（`structured-latex/content/016_even_sector_fermions.ts` の
`evenfermi_008_claim_T_eq`）

## 形式化の方針

原文 Step 1〜4（両者が単位的環準同型かつ線型 → `Z_m, Y_m` 上で一致 →
一致する元の集合 `ℰ` が部分代数 → `Z_Y_generate_algebra` で `ℰ = Mat(2^M,ℂ)`）は、
mathlib の `AlgHom.equalizer`（2 つの代数準同型が一致する部分代数）と
013 章の `Ising2D.checkZ_checkY_generate_algebra`（`Ǎdjoin{Ž,Y̌} = ⊤`）で尽きる。

原文が `Z_m, Y_m` を経由している（Step 2 で `recover_Z_Y_from_check_Z_Y` を使う）のに対し、
本ファイルは `Ž_μ, Y̌_μ` の生成性を直接使う。013 章の
`checkZ_checkY_generate_algebra` が原文 Step 2 と Step 4 を合わせたものになっている
（その証明の中で復元公式を使っている）ので、内容は同じである。

**本ファイルは `V^{(+)}` の定義（014 章）に依存しない。**
「可逆元による共役どうしが `Ž, Y̌` 上で一致すれば全体で一致する」という形で述べており、
`V^{(+)}` はその特殊化にすぎない。
-/
import Ising2D.Part016.Claim007_TEqOnCheckZY
import Ising2D.Part013.Claim006_RecoverZY

namespace Ising2D

variable {M : ℕ}

/-- **原文 `T_V_plus_eq_T_check_Vprime`**（`V^{(+)}` に依存しない一般形）。

`Ž_μ, Y̌_μ`（`μ ∈ 𝓜̌`）の上で一致する 2 つの共役は、`Mat(2^M,ℂ)` の全体で一致する。 -/
theorem TConj_eq_of_eq_on_checkZY (hM : M ≠ 0) (u v : (TensorPow M)ˣ)
    (hZ : ∀ j : Fin M,
      TConj u (checkZ M (checkIdx M j)) = TConj v (checkZ M (checkIdx M j)))
    (hY : ∀ j : Fin M,
      TConj u (checkY M (checkIdx M j)) = TConj v (checkY M (checkIdx M j))) :
    ∀ x : TensorPow M, TConj u x = TConj v x := by
  have hle : Algebra.adjoin ℂ (checkZYSet M)
      ≤ AlgHom.equalizer (TConj u).toAlgHom (TConj v).toAlgHom := by
    apply Algebra.adjoin_le
    rintro w (⟨j, rfl⟩ | ⟨j, rfl⟩)
    · exact hZ j
    · exact hY j
  rw [checkZ_checkY_generate_algebra hM] at hle
  intro x
  exact hle (Algebra.mem_top (R := ℂ) (x := x))

/-- 上を「線型写像としての一致」の形で述べた版（原文の statement に近い形）。 -/
theorem TConj_toLinearMap_eq_of_eq_on_checkZY (hM : M ≠ 0) (u v : (TensorPow M)ˣ)
    (hZ : ∀ j : Fin M,
      TConj u (checkZ M (checkIdx M j)) = TConj v (checkZ M (checkIdx M j)))
    (hY : ∀ j : Fin M,
      TConj u (checkY M (checkIdx M j)) = TConj v (checkY M (checkIdx M j))) :
    (TConj u).toLinearMap = (TConj v).toLinearMap :=
  LinearMap.ext (TConj_eq_of_eq_on_checkZY hM u v hZ hY)

/-- **原文 `T_V_plus_eq_T_check_Vprime` そのもの**。

`T_{(V^{(+)})}` を可逆元 `uPlus` による共役として与え、014 章・015 章の内容を
`hT` / `hlamPlus` / `hlamMinus` として受け取る。 -/
theorem TVPlus_eq_TCheckVprime (K : IsingConst) (g : ℤ → ℂ) (hM : M ≠ 0)
    (hga : ∀ μ : ℤ, CheckIndex M μ → gamma2 K (thetaTilde M μ) ≠ 0)
    (hgconj : ∀ μ : ℤ, CheckIndex M μ → g ((M : ℤ) + 1 - μ) = g μ)
    (uPlus : (TensorPow M)ˣ)
    (hT : ∀ j : Fin M, ActsBy (TConj uPlus).toLinearMap
      (checkZ M (checkIdx M j)) (checkY M (checkIdx M j))
      (AMat K (thetaTilde M (checkIdx M j))))
    (hlamPlus : ∀ j : Fin M, gamma1 K (thetaTilde M (checkIdx M j))
      + ((checkR K M (checkIdx M j) : ℝ) : ℂ) = Complex.exp (g (checkIdx M j)))
    (hlamMinus : ∀ j : Fin M, gamma1 K (thetaTilde M (checkIdx M j))
      - ((checkR K M (checkIdx M j) : ℝ) : ℂ) = Complex.exp (-g (checkIdx M j))) :
    ∀ x : TensorPow M, TConj uPlus x = TConj (checkVprimeUnits K M g) x :=
  TConj_eq_of_eq_on_checkZY hM uPlus (checkVprimeUnits K M g)
    (fun j => (TVPlus_eq_TCheckVprime_on_checkZY K g hM hga hgconj hT hlamPlus hlamMinus j).1)
    (fun j => (TVPlus_eq_TCheckVprime_on_checkZY K g hM hga hgconj hT hlamPlus hlamMinus j).2)

end Ising2D
