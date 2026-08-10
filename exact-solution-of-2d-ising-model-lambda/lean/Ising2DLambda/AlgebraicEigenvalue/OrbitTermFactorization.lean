/-
章「固有値の代数性」の「軌道を保つ置換の項は、軌道ごとの因子の積である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 1 件
（`def_orbit_term_factor`）と主張 3 件（`claim_const_embedding_prod` /
`claim_prod_orbit_decomposition` / `claim_orbit_term_factorization`）に対応する。

  人手証明                                          このファイル
  ι(κ(∏ n_i)) = ∏ ι(κ(n_i))                        constSecond_constPoly_prod
  ∏_{τ∈R_L} f(τ) = ∏_O ∏_{τ∈O} f(τ)                 prod_eq_prod_orbit
  W_O(ψ) = ι(κ(sgn_O(ψ)))·∏_{τ∈O} B_{τ,ψ(τ)}        orbitFactor
  項 = ∏_O W_O(φ↾_O)                                 term_eq_prod_orbitFactor

`W_O` の引数の持ち方は前のセクションの `orbitPermSign` に合わせ、`O` の上で値を取る
ambient の写像として受ける。

mathlib の `Matrix.det` と群作用の軌道の一般論は引いていない。使ったのは
`Finset.prod_cons`（人手証明の「元を 1 つ足す」帰納法）、`Finset.prod_biUnion`
（同「互いに素な族の合併の上の積は積の積」）、`Finset.prod_attach`、
`Finset.prod_mul_distrib`（同「2 つの有限積の積は成分ごとの積の有限積」）だけである。
κ と ι の積の保存は、人手証明が定義の中で述べているものをそのまま補題にした。

住処: 人手証明のこれらのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（係数は ℤ[x][t]、符号は ℤ、添字は有限集合 R_L）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitPermutationSign

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の定義が述べている「κ は積を保つ」。 -/
lemma constPoly_mul (a b : ℤ) : constPoly (a * b) = constPoly a * constPoly b :=
  map_mul _ _ _

/-- 人手証明の定義が述べている「ι は積を保つ」。 -/
lemma constSecond_mul (a b : Polynomial ℤ) :
    constSecond (a * b) = constSecond a * constSecond b :=
  map_mul _ _ _

/-- 人手証明の主張「ι∘κ は有限積を有限積へ写す」。

証明は人手証明どおり、添字集合の元の個数についての帰納法（空の積が単位元であることから始め、
元を 1 つ足すごとに κ と ι の積の保存を当てる）。 -/
theorem constSecond_constPoly_prod {β : Type*} [DecidableEq β] (s : Finset β) (f : β → ℤ) :
    constSecond (constPoly (∏ i ∈ s, f i)) = ∏ i ∈ s, constSecond (constPoly (f i)) := by
  induction s using Finset.cons_induction with
  | empty =>
      rw [Finset.prod_empty, Finset.prod_empty, constSecond_constPoly_one]
  | cons a s ha ih =>
      rw [Finset.prod_cons, Finset.prod_cons, constPoly_mul, constSecond_mul, ih]

/-- 人手証明の主張「有限積は軌道ごとの積の積である」。

証明は人手証明どおり、軌道の全体が `R_L` の分割であること（合併と互いに素であること）による。 -/
theorem prod_eq_prod_orbit (L : ℕ) [NeZero L] (f : RowConfig L → SecondPoly) :
    ∏ τ : RowConfig L, f τ
      = ∏ O ∈ (rowShiftOrbitSet L).attach, ∏ τ ∈ O.1, f τ := by
  classical
  obtain ⟨-, hdisj, hunion⟩ := rowShiftOrbitSet_partition L
  have hpd : Set.PairwiseDisjoint (↑(rowShiftOrbitSet L))
      (id : Finset (RowConfig L) → Finset (RowConfig L)) := by
    intro O₁ h₁ O₂ h₂ hne
    exact hdisj O₁ (by simpa using h₁) O₂ (by simpa using h₂) hne
  calc ∏ τ : RowConfig L, f τ
      = ∏ τ ∈ (rowShiftOrbitSet L).biUnion id, f τ := by rw [hunion]
    _ = ∏ O ∈ rowShiftOrbitSet L, ∏ τ ∈ id O, f τ := Finset.prod_biUnion hpd
    _ = ∏ O ∈ (rowShiftOrbitSet L).attach, ∏ τ ∈ O.1, f τ :=
        (Finset.prod_attach (rowShiftOrbitSet L) (fun O => ∏ τ ∈ O, f τ)).symm

/-- 人手証明の定義「軌道の因子」`W_O(ψ) = ι(κ(sgn_O(ψ)))·∏_{τ∈O} B_{τ,ψ(τ)}`。 -/
noncomputable def orbitFactor (L : ℕ) [NeZero L] (B : SecondRowMatrix L)
    (O : Finset (RowConfig L)) (g : RowConfig L → RowConfig L) : SecondPoly :=
  constSecond (constPoly (orbitPermSign L O g)) * ∏ τ ∈ O, B τ (g τ)

/-- 人手証明の主張「軌道を保つ置換の項は、軌道ごとの因子の積である」。

人手証明の式変形の 6 段をそのまま辿る（最後の 2 段は、制限が値を変えないことを当てる段と、
軌道の因子の定義へ畳む段であり、1 段にまとめない）。 -/
theorem term_eq_prod_orbitFactor (B : SecondRowMatrix L) {φ : Equiv.Perm (RowConfig L)}
    (hφ : OrbitPreserving L φ) :
    constSecond (constPoly (permSign L φ)) * ∏ τ : RowConfig L, B τ (φ τ)
      = ∏ O ∈ (rowShiftOrbitSet L).attach,
          orbitFactor L B O.1 (orbitRestrictionAmbient hφ O.2) := by
  classical
  calc constSecond (constPoly (permSign L φ)) * ∏ τ : RowConfig L, B τ (φ τ)
      = constSecond (constPoly (∏ O ∈ (rowShiftOrbitSet L).attach,
            orbitPermSign L O.1 (orbitRestrictionAmbient hφ O.2)))
          * ∏ τ : RowConfig L, B τ (φ τ) := by
        rw [permSign_eq_prod_orbitPermSign hφ]
    _ = (∏ O ∈ (rowShiftOrbitSet L).attach,
            constSecond (constPoly (orbitPermSign L O.1 (orbitRestrictionAmbient hφ O.2))))
          * ∏ τ : RowConfig L, B τ (φ τ) := by
        rw [constSecond_constPoly_prod]
    _ = (∏ O ∈ (rowShiftOrbitSet L).attach,
            constSecond (constPoly (orbitPermSign L O.1 (orbitRestrictionAmbient hφ O.2))))
          * ∏ O ∈ (rowShiftOrbitSet L).attach, ∏ τ ∈ O.1, B τ (φ τ) := by
        rw [prod_eq_prod_orbit L (fun τ => B τ (φ τ))]
    _ = ∏ O ∈ (rowShiftOrbitSet L).attach,
          constSecond (constPoly (orbitPermSign L O.1 (orbitRestrictionAmbient hφ O.2)))
            * ∏ τ ∈ O.1, B τ (φ τ) := (Finset.prod_mul_distrib).symm
    _ = ∏ O ∈ (rowShiftOrbitSet L).attach,
          constSecond (constPoly (orbitPermSign L O.1 (orbitRestrictionAmbient hφ O.2)))
            * ∏ τ ∈ O.1, B τ (orbitRestrictionAmbient hφ O.2 τ) := by
        refine Finset.prod_congr rfl ?_
        intro O _
        refine congrArg _ ?_
        refine Finset.prod_congr rfl ?_
        intro τ hτ
        rw [orbitRestrictionAmbient_eq hφ O.2 hτ]
    _ = ∏ O ∈ (rowShiftOrbitSet L).attach,
          orbitFactor L B O.1 (orbitRestrictionAmbient hφ O.2) := by
        refine Finset.prod_congr rfl ?_
        intro O _
        rw [orbitFactor]

end Ising2DLambda.AlgebraicEigenvalue
