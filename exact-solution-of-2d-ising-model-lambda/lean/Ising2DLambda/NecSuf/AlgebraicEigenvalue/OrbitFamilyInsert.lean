/-
主張「軌道を 1 つ足した組の全体は、その軌道の上の全単射と残りの組との対に
1 対 1 に対応する」の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.OrbitFamilyInsert`）の証明が実際に
使っているのは次だけである。証明手順は具体版と同じ（`ins` と `spl` を定め、
2 つの往復を、添字が `O₀` か否かの場合分けで示す）。

  使っている性質                                    どこで
  添字の相等が判定できること                          ins の場合分け
  足す添字がもとの集合に属さないこと                   ins の値が一意に定まること

削れなかった仮定と、その理由。

1. `[DecidableEq ι]`。`ins` は「添字が `O₀` に等しいか」で値を分けるので、
   これが無いと写像そのものが書けない。人手証明の場合分けに当たる。
2. `hO₀ : O₀ ∉ s`。これを外すと、`O₀ ∈ s` の添字で `ins` の 2 つの場合が
   食い違う値を与えうる（第 1 の往復が成り立たなくなる）。
   人手証明が「場合分けはちょうど 1 つの値を与える」と述べている箇所である。
   SageMath 側でも、この仮定を外すと値が衝突する組が $L\ge2$ で実在することを確かめてある。

具体版との差で言えば、次はいずれも使っていない。

* 添字が軌道であること。ここでは相等が判定できるだけの型でよい。
* 各成分が全単射であること・写像であることすら使っていない。
  成分の型 `B i` は添字ごとに勝手な型でよい（`B : ι → Type*`）。
* 添字の型が有限であること・順序 `≺` があること・値の側の代数構造。

住処: ここに ℝ / ℂ は現れない（現れるのは有限集合 `s : Finset ι` と、
添字ごとの型 `B i` の元だけである）。
-/
import Mathlib.Data.Finset.Insert

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {ι : Type*} [DecidableEq ι] {B : ι → Type*}

/-- 人手証明の `𝔄(s)`（`s` の各元へ、その元ごとの型の元を 1 つずつ対応させる組）。

具体版では `B O` が「`O` の上の全単射の全体」だが、ここでは添字ごとの勝手な型でよい。 -/
def FamilyOn (B : ι → Type*) (s : Finset ι) : Type _ := ∀ i : ι, i ∈ s → B i

/-- 人手証明の `ins`。`i = i₀` なら `x`、そうでなければもとの組の値を返す。 -/
def insertFamily {s : Finset ι} (i₀ : ι) (x : B i₀) (α : FamilyOn B s) :
    FamilyOn B (insert i₀ s) :=
  fun i hi =>
    if h : i = i₀ then cast (congrArg B h).symm x
    else α i ((Finset.mem_insert.mp hi).resolve_left h)

/-- 人手証明の `spl`。`spl(β) = (β(i₀), β↾_s)`。 -/
def splitFamily {s : Finset ι} (i₀ : ι) (β : FamilyOn B (insert i₀ s)) :
    B i₀ × FamilyOn B s :=
  (β i₀ (Finset.mem_insert_self i₀ s),
    fun i hi => β i (Finset.mem_insert_of_mem hi))

/-- 人手証明の第 1 の等式 `spl(ins(x, α)) = (x, α)`。

第 1 成分は `i₀ = i₀` の側、第 2 成分は `i ∈ s`（したがって `i ≠ i₀`）の側である。
`i ≠ i₀` を出すところで `hi₀` が効く。 -/
theorem insertFamily_leftInverse {s : Finset ι} {i₀ : ι} (hi₀ : i₀ ∉ s)
    (x : B i₀) (α : FamilyOn B s) :
    splitFamily i₀ (insertFamily i₀ x α) = (x, α) := by
  refine Prod.ext ?_ ?_
  · -- 第 1 成分。`ins` の場合分けの前者。
    show (if h : i₀ = i₀ then cast (congrArg B h).symm x else _) = x
    rw [dif_pos rfl]
    rfl
  · -- 第 2 成分。`i ∈ s` なら `i ≠ i₀`（`hi₀` による）なので後者。
    funext i
    funext hi
    have hne : i ≠ i₀ := fun h => hi₀ (h ▸ hi)
    show (if h : i = i₀ then cast (congrArg B h).symm x else α i _) = α i hi
    rw [dif_neg hne]

/-- 人手証明の第 2 の等式 `ins(spl(β)) = β`。

`insert i₀ s` の元 `i` について `i = i₀` か `i ≠ i₀` かで場合を分ける。
どちらの場合も値は `β i` に一致する。

**この向きは `i₀ ∉ s` を要求しない。** `i = i₀` の側は `ins` の前者が `β i₀` を返し、
`i ≠ i₀` の側は後者が `β i` を返すだけで、`i₀ ∈ s` であっても値は食い違わないからである
（食い違いうるのは第 1 の等式の側で、そこでは `x` と `α i₀` という別々に与えられた
2 つの値を突き合わせる）。したがって仮定は第 1 の等式にだけ置いてある。 -/
theorem insertFamily_rightInverse {s : Finset ι} {i₀ : ι}
    (β : FamilyOn B (insert i₀ s)) :
    insertFamily i₀ (splitFamily i₀ β).1 (splitFamily i₀ β).2 = β := by
  funext i
  funext hi
  by_cases h : i = i₀
  · subst h
    simp only [insertFamily, splitFamily, dif_pos rfl]
    rfl
  · simp only [insertFamily, splitFamily, dif_neg h]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
