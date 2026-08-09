/-
章「固有値の代数性」の定義「軌道の 2 点を入れ替える写像（互換）」と、主張
「互換は 2 回合成すると恒等写像であり、その軌道への制限は軌道の上の全単射である」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_orbit_transposition`）と主張 1 件（`claim_orbit_transposition_bijective`）に対応する。

  人手証明                                        このファイル
  t_{τa,τb}（3 つの場合による定義）               orbitTransposition
  第一の主張（t(t(τ)) = τ）                       orbitTransposition_involutive
  第二の主張（τ ∈ O ならば t(τ) ∈ O）             orbitTransposition_mem
  第三の主張（制限が 𝔅_O の元）                   orbitTranspositionRestriction

人手証明の 3 つの場合分けは、そのまま `if τ = a then _ else if τ = b then _ else _` の
場合分けとして書いてある（第 2 の場合の条件「τ ≠ τa かつ τ = τb」は、`else` の枝に
入っていることが `τ ≠ τa` を与えることに対応する）。

mathlib の `Equiv.swap` は引いていない（引くと人手証明の 3 つの場合分けと、
2 回合成が恒等写像であることの計算がまるごと消える）。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（現れるのは行配位とその部分集合、その上の写像と相等だけ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitPermutationSignValues

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の定義「軌道の 2 点を入れ替える写像」`t_{τa,τb} : R_L → R_L`。

`τa = τb` である場合を除いていないのも人手証明のとおりである（そのとき恒等写像になる）。 -/
noncomputable def orbitTransposition (L : ℕ) [NeZero L] (a b : RowConfig L) :
    RowConfig L → RowConfig L :=
  fun τ => if τ = a then b else if τ = b then a else τ

/-- 人手証明の第一の主張。任意の `τ ∈ R_L` について `t(t(τ)) = τ` である。

人手証明どおり 3 つの場合に分け、第 1 の場合ではさらに `τb = τa` か否かで分ける。 -/
theorem orbitTransposition_involutive (a b : RowConfig L) (τ : RowConfig L) :
    orbitTransposition L a b (orbitTransposition L a b τ) = τ := by
  simp only [orbitTransposition]
  by_cases hτa : τ = a
  · -- 第 1 の場合: t(τ) = b。ここで b = a か否かでさらに分ける。
    by_cases hba : b = a
    · -- b = a のとき t(b) = t(a) = b = a = τ
      simp [hτa, hba]
    · -- b ≠ a のとき t(b) = a = τ（第 2 の場合）
      simp [hτa, hba]
  · by_cases hτb : τ = b
    · -- 第 2 の場合: t(τ) = a、そして t(a) = b = τ
      have hba : b ≠ a := hτb ▸ hτa
      simp [hτa, hτb, hba]
    · -- 第 3 の場合: t(τ) = τ、もう一度当てても同じ場合に入る
      simp [hτa, hτb]

/-- 人手証明の第二の主張。`τa, τb ∈ O` かつ `τ ∈ O` ならば `t(τ) ∈ O` である。

3 つの場合の値はそれぞれ `b`・`a`・`τ` であり、いずれも仮定より `O` に属する。 -/
theorem orbitTransposition_mem {O : Finset (RowConfig L)} {a b : RowConfig L}
    (ha : a ∈ O) (hb : b ∈ O) {τ : RowConfig L} (hτ : τ ∈ O) :
    orbitTransposition L a b τ ∈ O := by
  simp only [orbitTransposition]
  by_cases hτa : τ = a
  · rw [if_pos hτa]
    exact hb
  · rw [if_neg hτa]
    by_cases hτb : τ = b
    · rw [if_pos hτb]
      exact ha
    · rw [if_neg hτb]
      exact hτ

/-- 人手証明の第三の主張。`t` の `O` への制限は `𝔅_O`（`OrbitBij O`）の元である。

第二の主張で `O` から `O` への写像になり、第一の主張でそれが自分自身を逆写像に持つ。 -/
noncomputable def orbitTranspositionRestriction (O : Finset (RowConfig L))
    {a b : RowConfig L} (ha : a ∈ O) (hb : b ∈ O) : OrbitBij O where
  toFun τ := ⟨orbitTransposition L a b τ.1, orbitTransposition_mem ha hb τ.2⟩
  invFun τ := ⟨orbitTransposition L a b τ.1, orbitTransposition_mem ha hb τ.2⟩
  left_inv τ := Subtype.ext (orbitTransposition_involutive a b τ.1)
  right_inv τ := Subtype.ext (orbitTransposition_involutive a b τ.1)

@[simp]
theorem orbitTranspositionRestriction_val (O : Finset (RowConfig L)) {a b : RowConfig L}
    (ha : a ∈ O) (hb : b ∈ O) (τ : {τ : RowConfig L // τ ∈ O}) :
    (orbitTranspositionRestriction O ha hb τ).1 = orbitTransposition L a b τ.1 := rfl

end Ising2DLambda.AlgebraicEigenvalue
