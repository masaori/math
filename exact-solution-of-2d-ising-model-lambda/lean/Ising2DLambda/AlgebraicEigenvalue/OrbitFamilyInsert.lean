/-
章「固有値の代数性」の「軌道を 1 つ足した組の全体は、その軌道の上の全単射と
残りの組との対に 1 対 1 に対応する」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは定義 2 件
（`def_orbit_bijection_set` / `def_orbit_family_on_subset`）と主張 1 件
（`claim_orbit_family_insert_bijection`）に対応する。

  人手証明                                      このファイル
  𝔅_O（O の上の全単射の全体）                   OrbitBij
  𝔄(s)（s の各元へ 𝔅_O の元を 1 つずつ）        OrbitPermFamilyOn
  ins(ψ, α)                                     orbitInsertFamily
  spl(β)                                        orbitSplitFamily
  spl(ins(ψ, α)) = (ψ, α)                       orbitFamilyInsert_leftInverse
  ins(spl(β)) = β                               orbitFamilyInsert_rightInverse

型の持ち方について。`OrbitPermFamilyOn s` は「`s` の元 `O` と、その所属の証明を受け取って
`𝔅_O` の元を返す対応」である。前のセクションの `OrbitPermFamily`（`OrbitFamilySum.lean`）は
これを `s = univ` に固定したものに当たる。`s` を動かせるようにしたのは、次のセクションで
有限積の分配則を `s` の元の個数についての帰納法で示すためである（人手証明も同じ理由で
`𝔄(s)` を置いている）。

ただし、人手証明が `𝔄(𝒪_L) = 𝔄_L` と等号で書いているのに対し、Lean のこの 2 つは
**同じ型ではない**。`OrbitPermFamily L` は `∀ O, 𝔅_O`、`OrbitPermFamilyOn univ` は
`∀ O, O ∈ univ → 𝔅_O` であり、後者は所属の証明を余分に受け取る（所属は常に成り立つので
中身は同じだが、型としては別物である）。したがって分配則を `χ_U` へ当てる段
（セクション 10f'''b5）では、この 2 つを行き来する全単射を明示的に置いてから和の添字を
取り替える必要がある。**その橋渡しはまだ書かれていない。**
人手証明の側では両者は同じ対応の集合なので、直すべきは Lean の持ち方ではなく、
橋渡しを省かないことである。

mathlib の `Finset.pi` や `Fintype.piFinset` の一般論は引いていない
（引くと「軌道を 1 つ足す」という人手証明の一歩が既製の構成へ置き換わる）。
使ったのは `Finset.mem_insert` 系の基本補題だけである。

住処: 人手証明のこれらのブロックは ℕ を宣言している。
ここに ℝ / ℂ は現れない（現れるのは行配位とその部分集合、およびその上の写像だけ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.OrbitFamilySum

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 人手証明の定義「1 つの軌道の上の全単射の全体」`𝔅_O`。

`𝔖_L` の部分集合ではない（定義域が `O` であって `R_L` ではない）ことは人手証明のとおり、
型が違うことにそのまま現れている。 -/
abbrev OrbitBij (O : Finset (RowConfig L)) : Type :=
  {τ : RowConfig L // τ ∈ O} ≃ {τ : RowConfig L // τ ∈ O}

/-- 人手証明の定義「軌道の部分集合ごとの置換の組」`𝔄(s)`。

`s` の各元 `O` へ `𝔅_O` の元 `α(O)` を 1 つずつ対応させる組である。 -/
def OrbitPermFamilyOn (s : Finset (OrbitIndex L)) : Type :=
  ∀ O : OrbitIndex L, O ∈ s → OrbitBij O.1

/-- 人手証明の `ins`。`O = O₀` なら `ψ`、`O ∈ s` ならもとの組の値。 -/
def orbitInsertFamily {s : Finset (OrbitIndex L)} (O₀ : OrbitIndex L)
    (ψ : OrbitBij O₀.1) (α : OrbitPermFamilyOn s) :
    OrbitPermFamilyOn (insert O₀ s) :=
  fun O hO =>
    if h : O = O₀ then cast (congrArg (fun O : OrbitIndex L => OrbitBij O.1) h).symm ψ
    else α O ((Finset.mem_insert.mp hO).resolve_left h)

/-- 人手証明の `spl`。`spl(β) = (β(O₀), β↾_s)`。 -/
def orbitSplitFamily {s : Finset (OrbitIndex L)} (O₀ : OrbitIndex L)
    (β : OrbitPermFamilyOn (insert O₀ s)) : OrbitBij O₀.1 × OrbitPermFamilyOn s :=
  (β O₀ (Finset.mem_insert_self O₀ s),
    fun O hO => β O (Finset.mem_insert_of_mem hO))

/-- 人手証明の主張の第 1 の等式 `spl(ins(ψ, α)) = (ψ, α)`。

第 1 成分は `ins` の場合分けの前者（`O₀ = O₀`）、第 2 成分は後者である。
後者へ入るために要る `O ≠ O₀` は、`O ∈ s` と `O₀ ∉ s` から出る——
これが人手証明で `O₀ ∉ s` を使っている箇所である。 -/
theorem orbitFamilyInsert_leftInverse {s : Finset (OrbitIndex L)} {O₀ : OrbitIndex L}
    (hO₀ : O₀ ∉ s) (ψ : OrbitBij O₀.1) (α : OrbitPermFamilyOn s) :
    orbitSplitFamily O₀ (orbitInsertFamily O₀ ψ α) = (ψ, α) := by
  refine Prod.ext ?_ ?_
  · show (if h : O₀ = O₀ then
            cast (congrArg (fun O : OrbitIndex L => OrbitBij O.1) h).symm ψ else _) = ψ
    rw [dif_pos rfl]
    rfl
  · funext O
    funext hO
    have hne : O ≠ O₀ := fun h => hO₀ (h ▸ hO)
    show (if h : O = O₀ then
            cast (congrArg (fun O : OrbitIndex L => OrbitBij O.1) h).symm ψ
          else α O _) = α O hO
    rw [dif_neg hne]

/-- 人手証明の主張の第 2 の等式 `ins(spl(β)) = β`。

`insert O₀ s` の元 `O` について `O = O₀` か否かで場合を分ける。
どちらの場合も値が `β O` に一致する（人手証明の 2 つの場合そのもの）。 -/
theorem orbitFamilyInsert_rightInverse {s : Finset (OrbitIndex L)} {O₀ : OrbitIndex L}
    (β : OrbitPermFamilyOn (insert O₀ s)) :
    orbitInsertFamily O₀ (orbitSplitFamily O₀ β).1 (orbitSplitFamily O₀ β).2 = β := by
  funext O
  funext hO
  by_cases h : O = O₀
  · subst h
    simp only [orbitInsertFamily, orbitSplitFamily, dif_pos rfl]
    rfl
  · simp only [orbitInsertFamily, orbitSplitFamily, dif_neg h]

end Ising2DLambda.AlgebraicEigenvalue
