/-
節「有限集合の上の和」のうち、有限集合の番号付けの導出版。具体版と必要十分版の `IsNumbering` は同じ形の別の structure、
`IsFiniteSet` は同じ形の別の定義なので、条件を写して行き来する。`Idx` と `numberedFamily` は同じ式なので、定義により一致する。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.Numbering
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.FiniteSetSum.Numbering

namespace CliffordMatrixIsomorphism

universe u v

namespace IsNumbering

variable {X : Type u} {n : ℕ} {e : Idx n → X}

/-- 具体版の番号付けは、必要十分版の番号付けである（単射と全射の条件を写す）。 -/
theorem toNecSuf (h : IsNumbering n e) : NecSuf.IsNumbering n e :=
  ⟨h.injective, h.surjective⟩

/-- 必要十分版の番号付けは、具体版の番号付けである（単射と全射の条件を写す）。 -/
theorem ofNecSuf (h : NecSuf.IsNumbering n e) : IsNumbering n e :=
  ⟨h.injective, h.surjective⟩

/-- 具体版の逆写像 e^{-1} は、必要十分版の逆写像 e^{-1} と同じ写像である（どちらも全射の条件で同じ命題から一つ選ぶ）。 -/
theorem inv_toNecSuf (h : IsNumbering n e) : h.inv = h.toNecSuf.inv := rfl

end IsNumbering

namespace IsFiniteSet

variable {X : Type u}

/-- 具体版の有限集合は、必要十分版の有限集合である（番号付けを写す）。 -/
theorem toNecSuf (h : IsFiniteSet X) : NecSuf.IsFiniteSet X :=
  let ⟨n, e, he⟩ := h
  ⟨n, e, he.toNecSuf⟩

/-- 必要十分版の有限集合は、具体版の有限集合である（番号付けを写す）。 -/
theorem ofNecSuf (h : NecSuf.IsFiniteSet X) : IsFiniteSet X :=
  let ⟨n, e, he⟩ := h
  ⟨n, e, IsNumbering.ofNecSuf he⟩

end IsFiniteSet

/-- 具体版の {1,…,n} の外へ延ばした族は、必要十分版の同じ族である（同じ式）。 -/
theorem extendFamily_toNecSuf {α : Type v} {n : ℕ} (g : Idx n → α) (d : α) :
    extendFamily g d = NecSuf.extendFamily g d := rfl

/-- 具体版の族 k ↦ f(e(k)) は、必要十分版の同じ族である（同じ式）。 -/
theorem numberedFamily_toNecSuf {X : Type u} {α : Type v} {n : ℕ} (e : Idx n → X) (f : X → α) (d : α) :
    numberedFamily e f d = NecSuf.numberedFamily e f d := rfl

end CliffordMatrixIsomorphism
