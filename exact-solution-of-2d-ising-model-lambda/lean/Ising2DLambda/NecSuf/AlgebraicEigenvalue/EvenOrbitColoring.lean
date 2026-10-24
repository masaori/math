import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationOrbitInvariant

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 有限性・順序・逆写像は不要。基点と周期の不変性は座標を比較するため、
帰還は末端を零へ戻すため、短い反復の単射性は次座標の同定に必要。
偶数性がなければ末端で色が反転しない。次座標の法則そのものは仮定しない。 -/
theorem cyclicCoordinates_alternate_necSuf {J : Type*}
    (f b : J → J) (p r : J → ℕ)
    (hb : ∀ i, b (f i) = b i) (hp : ∀ i, p (f i) = p i)
    (hreturn : ∀ i, f^[p i] (b i) = b i)
    (hbound : ∀ i, r i < p i) (hcoord : ∀ i, f^[r i] (b i) = i)
    (hinj : ∀ i, Set.InjOn (fun n : ℕ => f^[n] (b i)) (Set.Iio (p i)))
    (heven : ∀ i, p i % 2 = 0) (i : J) :
    r (f i) % 2 = 0 ↔ ¬ r i % 2 = 0 := by
  have hr := hbound i
  have hpos : 0 < p i := by omega
  have hnextbound : r (f i) < p i := by rw [← hp i]; exact hbound (f i)
  have hnextcoord : f^[r (f i)] (b i) = f i := by
    rw [← hb i]
    exact hcoord (f i)
  have hstep : f^[r i + 1] (b i) = f i := by
    calc
      f^[r i + 1] (b i) = f^[r i] (f (b i)) := rfl
      _ = f (f^[r i] (b i)) := (iterate_commute_necSuf f (r i) (b i)).symm
      _ = f i := congrArg f (hcoord i)
  by_cases hnext : r i + 1 < p i
  · have hindex : r (f i) = r i + 1 :=
      hinj i hnextbound hnext (hnextcoord.trans hstep.symm)
    rw [hindex]
    rcases Nat.mod_two_eq_zero_or_one (r i) with hzero | hone
    · have hodd : (r i + 1) % 2 = 1 := by
        calc
          (r i + 1) % 2 = (r i % 2 + 1) % 2 := by omega
          _ = (0 + 1) % 2 := by rw [hzero]
          _ = 1 := rfl
      omega
    · have hevenNext : (r i + 1) % 2 = 0 := by
        calc
          (r i + 1) % 2 = (r i % 2 + 1) % 2 := by omega
          _ = (1 + 1) % 2 := by rw [hone]
          _ = 0 := rfl
      omega
  · have hend : r i + 1 = p i := by omega
    have hwrap : f i = b i := by
      calc
        f i = f^[r i + 1] (b i) := hstep.symm
        _ = f^[p i] (b i) := congrArg (fun n => f^[n] (b i)) hend
        _ = b i := hreturn i
    have hzero : f^[0] (b i) = f i := hwrap.symm
    have hindex : r (f i) = 0 := hinj i hnextbound hpos (hnextcoord.trans hzero.symm)
    have hpar := heven i
    rw [hindex]
    have hnot : ¬ r i % 2 = 0 := by
      intro hzero
      have hfalse : (0 : ℕ) = 1 := by
        calc
          0 = p i % 2 := hpar.symm
          _ = (r i + 1) % 2 := congrArg (fun n => n % 2) hend.symm
          _ = (r i % 2 + 1) % 2 := by omega
          _ = (0 + 1) % 2 := by rw [hzero]
          _ = 1 := rfl
      exact Nat.zero_ne_one hfalse
    exact iff_of_true rfl hnot

/-- 基点での座標零に必要なのは基点の冪等性と短い座標の一意性だけ。 -/
theorem cyclicCoordinates_basepoint_zero_necSuf {J : Type*}
    (f b : J → J) (p r : J → ℕ)
    (hb : ∀ i, b (b i) = b i)
    (hbound : ∀ i, r i < p i) (hcoord : ∀ i, f^[r i] (b i) = i)
    (hinj : ∀ i, Set.InjOn (fun n : ℕ => f^[n] (b i)) (Set.Iio (p i)))
    (i : J) : r (b i) = 0 := by
  have hr := hbound (b i)
  have hp : 0 < p (b i) := by omega
  have hzero : f^[0] (b (b i)) = b i := hb i
  exact hinj (b i) hr hp ((hcoord (b i)).trans hzero.symm)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
