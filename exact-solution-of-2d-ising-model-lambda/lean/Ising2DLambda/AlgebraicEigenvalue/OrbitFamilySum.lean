/-
章「固有値の代数性」の「和の添字を軌道ごとの置換の組へ取り替えること」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_orbit_restriction_family`）と主張 3 件（`claim_gluing_restriction_family` /
`claim_restriction_family_gluing` / `claim_shift_char_sum_family`）に対応する。

  人手証明                                          このファイル
  𝔄_L（和の添字にするため型として持つ）              OrbitPermFamily
  res(φ)                                             restrictionFamily
  gl(α)                                              gluePermOf
  gl(res(φ)) = φ                                     glue_restrictionFamily
  res(gl(α)) = α                                     restrictionFamily_glue
  χ_U = Σ_{α∈𝔄_L} Π_O W_O(ch(U), α(O))              charPoly_shiftMatrix_eq_sum_family

組の型の持ち方について。前のセクションの `OrbitFamily` は「どの Finset に対しても写像を
1 つ与える対応」で、全単射性を軌道についてだけ別に要求する形だった（`OrbitFamilyBijective`）。
これは和の添字にできない——軌道でない Finset における値が自由なので、同じ組に見えるものが
無数にあるからである。そこで人手証明の 𝔄_L（軌道の各元へ、その軌道の上の全単射を 1 つずつ）を
そのまま型として書き、全単射性は `Equiv` に持たせた。前 tick に 𝔖^𝒪_L を述語から Finset へ
持ち直したのと同じ持ち直しである。`OrbitFamily` との橋渡しは `extendFamily`
（軌道の外では恒等写像とする。貼り合わせが触るのは軌道の成分だけなので値に効かない）。

`W_O` の第 2 引数は ambient の写像として受けるので、`α O`（部分型の上の全単射）を
`ambientOf` で ambient の写像へ移す。軌道の外の値が効かないことは前のセクションの
`orbitFactor_congr` で示してある。

mathlib の `Equiv.Perm` の一般論・群作用の軌道・`Matrix.charpoly` は引いていない。
使ったのは `Finset.sum_bij'`（人手証明の「互いに逆な 2 つの写像で和の添字を取り替える」）と
`Finset.sum_congr`（同「各項を書き換える」）だけである。

住処: 人手証明のこれらのブロックは ℕ（定義と 2 主張）と ℤ（和の主張）を宣言している。
ここに ℝ / ℂ は現れない（係数は ℤ[x][t]、添字は行配位とその部分集合）。
-/
import Ising2DLambda.AlgebraicEigenvalue.ShiftCharSum
import Ising2DLambda.AlgebraicEigenvalue.OrbitGluing

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 軌道の全体 `𝒪_L` を添字として使うための型（`rowShiftOrbitSet L` の元）。 -/
abbrev OrbitIndex (L : ℕ) [NeZero L] := {O : Finset (RowConfig L) // O ∈ rowShiftOrbitSet L}

/-- 人手証明の定義「軌道ごとの置換の組」`𝔄_L` を、和の添字にできる形で持ったもの。

各軌道 `O` へ `O` の上の全単射を 1 つずつ対応させる組そのものである
（前のセクションの `OrbitFamily` と違い、軌道でない Finset における値を持たない）。 -/
def OrbitPermFamily (L : ℕ) [NeZero L] : Type :=
  ∀ O : OrbitIndex L, {τ : RowConfig L // τ ∈ O.1} ≃ {τ : RowConfig L // τ ∈ O.1}

noncomputable instance : Fintype (OrbitPermFamily L) := by
  classical
  unfold OrbitPermFamily
  infer_instance

/-- 軌道の上の全単射を、軌道の外では恒等な ambient の写像として読むもの。

`W_O` の第 2 引数が ambient の写像なので要る。軌道の外の値が `W_O` に効かないことは
`orbitFactor_congr`。 -/
noncomputable def ambientOf (O : Finset (RowConfig L))
    (ψ : {τ : RowConfig L // τ ∈ O} ≃ {τ : RowConfig L // τ ∈ O}) : RowConfig L → RowConfig L :=
  fun τ => if h : τ ∈ O then (ψ ⟨τ, h⟩).1 else τ

theorem ambientOf_apply (O : Finset (RowConfig L))
    (ψ : {τ : RowConfig L // τ ∈ O} ≃ {τ : RowConfig L // τ ∈ O})
    {τ : RowConfig L} (hτ : τ ∈ O) : ambientOf O ψ τ = (ψ ⟨τ, hτ⟩).1 := by
  simp [ambientOf, hτ]

/-- 人手証明の定義「軌道を保つ置換が定める、軌道ごとの置換の組」`res(φ)(O) = φ↾_O`。

`res(φ) ∈ 𝔄_L` であること（各成分が全単射であること）は
`claim_orbit_restriction_bijective`（`orbitRestriction_bijective`）による。 -/
noncomputable def restrictionFamily {φ : Equiv.Perm (RowConfig L)} (hφ : OrbitPreserving L φ) :
    OrbitPermFamily L :=
  fun O => Equiv.ofBijective (orbitRestriction hφ O.2) (orbitRestriction_bijective hφ O.2)

@[simp]
theorem restrictionFamily_apply {φ : Equiv.Perm (RowConfig L)} (hφ : OrbitPreserving L φ)
    (O : OrbitIndex L) (τ : {τ : RowConfig L // τ ∈ O.1}) :
    (restrictionFamily hφ O τ).1 = φ τ.1 := rfl

/-- 組を、前のセクションの `OrbitFamily`（Finset 全体で定めた対応）へ広げたもの。
軌道でない Finset では恒等写像とする（貼り合わせが触らないので値に効かない）。 -/
noncomputable def extendFamily (α : OrbitPermFamily L) : OrbitFamily L :=
  fun O => if h : O ∈ rowShiftOrbitSet L then ⇑(α ⟨O, h⟩) else id

theorem extendFamily_apply (α : OrbitPermFamily L) {O : Finset (RowConfig L)}
    (hO : O ∈ rowShiftOrbitSet L) : extendFamily α O = ⇑(α ⟨O, hO⟩) := by
  simp [extendFamily, hO]

theorem extendFamily_bijective (α : OrbitPermFamily L) :
    OrbitFamilyBijective (extendFamily α) := by
  intro O hO
  rw [extendFamily_apply α hO]
  exact (α ⟨O, hO⟩).bijective

/-- 人手証明の `gl(α)`（組の貼り合わせ）を、この型の組について書いたもの。 -/
noncomputable def gluePermOf (α : OrbitPermFamily L) : Equiv.Perm (RowConfig L) :=
  gluePerm (extendFamily_bijective α)

theorem gluePermOf_orbitPreserving (α : OrbitPermFamily L) :
    OrbitPreserving L (gluePermOf α) :=
  gluePerm_orbitPreserving (extendFamily_bijective α)

/-- 人手証明の主張「貼り合わせの制限の組はもとの組に戻る」`res(gl(α)) = α`。

証明は人手証明どおり、各軌道 `O` について
`(res(gl(α)))(O) = gl(α)↾_O = α(O)` の 2 段でつなぎ、`O` が任意であることから組の一致を出す。 -/
theorem restrictionFamily_glue (α : OrbitPermFamily L) :
    restrictionFamily (gluePermOf α) = α := by
  funext O
  have h : orbitRestriction (gluePermOf_orbitPreserving α) O.2 = extendFamily α O.1 :=
    orbitRestriction_gluePerm (extendFamily_bijective α) O.2
  apply Equiv.ext
  intro τ
  calc (restrictionFamily (gluePermOf_orbitPreserving α) O τ)
      = orbitRestriction (gluePermOf_orbitPreserving α) O.2 τ := rfl
    _ = extendFamily α O.1 τ := by rw [h]
    _ = α O τ := by rw [extendFamily_apply α O.2]

/-- 人手証明の主張「制限の組を貼り合わせるともとの置換に戻る」`gl(res(φ)) = φ`。

証明は人手証明どおり、各軌道 `O` で `gl(res(φ))↾_O = (res(φ))(O) = φ↾_O` を示し、
`claim_orbit_restriction_determines`（制限の全体が置換を決めること）を当てる。 -/
theorem glue_restrictionFamily {φ : Equiv.Perm (RowConfig L)} (hφ : OrbitPreserving L φ) :
    gluePermOf (restrictionFamily hφ) = φ := by
  refine eq_of_orbitRestriction_eq (gluePermOf_orbitPreserving _) hφ ?_
  intro O hO
  calc orbitRestriction (gluePermOf_orbitPreserving (restrictionFamily hφ)) hO
      = extendFamily (restrictionFamily hφ) O :=
        orbitRestriction_gluePerm (extendFamily_bijective (restrictionFamily hφ)) hO
    _ = ⇑(restrictionFamily hφ ⟨O, hO⟩) := extendFamily_apply _ hO
    _ = orbitRestriction hφ hO := rfl

/-- 人手証明の主張「χ_U は軌道ごとの置換の組にわたる和である」。

人手証明の式変形の 3 段をそのまま辿る（前セクションの主張 → 添字を 𝔄_L へ取り替える →
`gl(α)↾_O` を `α(O)` へ置き換える）。 -/
theorem charPoly_shiftMatrix_eq_sum_family (L : ℕ) [NeZero L] :
    charPoly L (shiftMatrix L)
      = ∑ α : OrbitPermFamily L,
          ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 (α O)) := by
  classical
  calc charPoly L (shiftMatrix L)
      = ∑ φ ∈ orbitPreservingFinset L,
          ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 ⇑φ :=
        charPoly_shiftMatrix_eq_sum_orbitFactor L
    -- 添字の取り替え（res と gl が互いに逆であることによる）。
    _ = ∑ α : OrbitPermFamily L,
          ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 ⇑(gluePermOf α) := by
        refine Finset.sum_bij'
          (fun φ hφ => restrictionFamily (mem_orbitPreservingFinset.mp hφ))
          (fun α _ => gluePermOf α)
          (fun _ _ => Finset.mem_univ _)
          (fun α _ => mem_orbitPreservingFinset.mpr (gluePermOf_orbitPreserving α))
          ?_ ?_ ?_
        · intro φ hφ
          exact glue_restrictionFamily (mem_orbitPreservingFinset.mp hφ)
        · intro α _
          exact restrictionFamily_glue α
        · intro φ hφ
          rw [glue_restrictionFamily (mem_orbitPreservingFinset.mp hφ)]
    -- gl(α)↾_O を α(O) へ置き換える。
    _ = ∑ α : OrbitPermFamily L,
          ∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitFactor L (charMatrix L (shiftMatrix L)) O.1 (ambientOf O.1 (α O)) := by
        refine Finset.sum_congr rfl ?_
        intro α _
        refine Finset.prod_congr rfl ?_
        intro O _
        refine orbitFactor_congr _ ?_
        intro τ hτ
        rw [ambientOf_apply O.1 (α O) hτ]
        have h : restrictionFamily (gluePermOf_orbitPreserving α) O = α O :=
          congrFun (restrictionFamily_glue α) O
        calc gluePermOf α τ
            = (restrictionFamily (gluePermOf_orbitPreserving α) O ⟨τ, hτ⟩).1 := rfl
          _ = (α O ⟨τ, hτ⟩).1 := by rw [h]

end Ising2DLambda.AlgebraicEigenvalue
