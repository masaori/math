/-
節「環」の導出版。具体版の環の組と必要十分版の環の組は同じ形の別の structure なので、欄を写す写像で行き来する。
二つの定義は ℂ を含まないので、行き来は欄を写すだけで、往復すると元に戻る（定義による）。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.Ring.UnitalRing
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.Ring.UnitalRing

namespace CliffordMatrixIsomorphism

universe u v

namespace UnitalRing

variable {R : Type u}

/-- 具体版の環の組を、必要十分版の環の組として読む（欄を写すだけ）。 -/
def toNecSuf (r : UnitalRing R) : NecSuf.UnitalRing R where
  add := r.add
  mul := r.mul
  zero := r.zero
  one := r.one
  add_assoc := r.add_assoc
  add_comm := r.add_comm
  add_zero := r.add_zero
  exists_add_inverse := r.exists_add_inverse
  mul_assoc := r.mul_assoc
  mul_one := r.mul_one
  one_mul := r.one_mul
  left_distrib := r.left_distrib
  right_distrib := r.right_distrib

/-- 必要十分版の環の組を、具体版の環の組として読む（欄を写すだけ）。 -/
def ofNecSuf (r : NecSuf.UnitalRing R) : UnitalRing R where
  add := r.add
  mul := r.mul
  zero := r.zero
  one := r.one
  add_assoc := r.add_assoc
  add_comm := r.add_comm
  add_zero := r.add_zero
  exists_add_inverse := r.exists_add_inverse
  mul_assoc := r.mul_assoc
  mul_one := r.mul_one
  one_mul := r.one_mul
  left_distrib := r.left_distrib
  right_distrib := r.right_distrib

theorem ofNecSuf_toNecSuf (r : UnitalRing R) : ofNecSuf r.toNecSuf = r := rfl

theorem toNecSuf_ofNecSuf (r : NecSuf.UnitalRing R) : (ofNecSuf r).toNecSuf = r := rfl

end UnitalRing

namespace IsRingHomomorphism

variable {R : Type u} {S : Type v}

/-- 具体版の環の準同型は、欄を写した必要十分版の環の組の間の環の準同型である。 -/
theorem toNecSuf {r : UnitalRing R} {s : UnitalRing S} {φ : R → S} (h : IsRingHomomorphism r s φ) :
    NecSuf.IsRingHomomorphism r.toNecSuf s.toNecSuf φ :=
  ⟨h.map_add, h.map_mul, h.map_one⟩

/-- 必要十分版の環の準同型は、欄を写した具体版の環の組の間の環の準同型である。 -/
theorem ofNecSuf {r : NecSuf.UnitalRing R} {s : NecSuf.UnitalRing S} {φ : R → S}
    (h : NecSuf.IsRingHomomorphism r s φ) :
    IsRingHomomorphism (UnitalRing.ofNecSuf r) (UnitalRing.ofNecSuf s) φ :=
  ⟨h.map_add, h.map_mul, h.map_one⟩

end IsRingHomomorphism

end CliffordMatrixIsomorphism
