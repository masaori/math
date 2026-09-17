/-
正本: content/finite-permutation-complex-phase-boundary.ts の Lean 具体版。

有限舞台上の二元配位と可逆大域写像に固定し、整数置換行列、有限位数、
複素係数作用、固有値の一の冪根性、実数値位相生成子の整数持ち上げの
非一意性を人手証明と同じ順序で示す。複素対数、内積、完備性、極限は使わない。
-/
import CellularAutomata.ReversibleGlobalMapCycleType
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Data.Matrix.PEquiv

namespace CellularAutomata.FinitePermutationComplexPhaseBoundary

variable {V : Type} [Fintype V] [DecidableEq V]

abbrev Configuration (V : Type) := V → Bool

/-- 有限二元配位上の可逆な大域時間発展。 -/
abbrev ReversibleEvolution (V : Type) := Equiv.Perm (Configuration V)

/-- 行を終状態、列を始状態で添字づける整数置換行列。 -/
noncomputable def permutationMatrix (F : ReversibleEvolution V) :
    Matrix (Configuration V) (Configuration V) ℤ :=
  F.symm.toPEquiv.toMatrix

theorem permutationMatrix_apply (F : ReversibleEvolution V) (y x : Configuration V) :
    permutationMatrix F y x = if y = F x then 1 else 0 := by
  classical
  rw [permutationMatrix, PEquiv.toMatrix_apply]
  by_cases h : y = F x
  · subst y
    simp
  · have h' : x ≠ F.symm y := by
      intro hx
      apply h
      simpa [hx]
    simp [h, Ne.symm h']

/-- 置換行列の冪は、同じ回数だけ反復した有限時間発展の表である。 -/
theorem permutationMatrix_pow (F : ReversibleEvolution V) (n : ℕ) :
    permutationMatrix F ^ n = permutationMatrix (F ^ n) := by
  classical
  induction n with
  | zero =>
      ext y x
      simp [permutationMatrix_apply, Matrix.one_apply]
  | succ n ih =>
      rw [pow_succ, ih]
      ext y x
      simp only [Matrix.mul_apply, permutationMatrix_apply]
      simp [pow_succ]

/-- 有限可逆時間発展の位数。 -/
noncomputable def finiteOrder (F : ReversibleEvolution V) : ℕ := orderOf F

theorem finiteOrder_positive (F : ReversibleEvolution V) : 0 < finiteOrder F := by
  exact orderOf_pos F

/-- 有限位数で時間発展と整数置換行列が恒等化する。 -/
theorem finiteOrder_identity (F : ReversibleEvolution V) :
    F ^ finiteOrder F = 1 ∧ permutationMatrix F ^ finiteOrder F = 1 := by
  have hF : F ^ finiteOrder F = 1 := pow_orderOf_eq_one F
  refine ⟨hF, ?_⟩
  rw [permutationMatrix_pow, hF]
  ext y x
  simp [permutationMatrix_apply, Matrix.one_apply]

/-- 整数置換行列を複素数値配位関数へ作用させた写像。 -/
def complexAction (F : ReversibleEvolution V)
    (z : Configuration V → ℂ) : Configuration V → ℂ :=
  fun y => z (F.symm y)

/-- 整数置換行列を標準単射で複素係数へ移した行列。 -/
noncomputable def complexPermutationMatrix (F : ReversibleEvolution V) :
    Matrix (Configuration V) (Configuration V) ℂ :=
  F.symm.toPEquiv.toMatrix

/-- 複素係数置換行列の有限和作用は、逆置換による引き戻しに一致する。 -/
theorem complexPermutationMatrix_mulVec (F : ReversibleEvolution V)
    (z : Configuration V → ℂ) :
    Matrix.mulVec (complexPermutationMatrix F) z = complexAction F z := by
  classical
  exact PEquiv.toMatrix_toPEquiv_mulVec F.symm z

theorem complexAction_mul (F G : ReversibleEvolution V) (z : Configuration V → ℂ) :
    complexAction (F * G) z = complexAction F (complexAction G z) := by
  rfl

theorem complexAction_pow (F : ReversibleEvolution V) (z : Configuration V → ℂ)
    (n : ℕ) : complexAction (F ^ n) z = (complexAction F)^[n] z := by
  induction n generalizing z with
  | zero => rfl
  | succ n ih =>
      rw [pow_succ, complexAction_mul, ih]
      exact (Function.iterate_succ_apply (complexAction F) n z).symm

/-- 複素固有値は有限位数の一の冪根である。 -/
theorem eigenvalue_is_root_of_unity (F : ReversibleEvolution V)
    (z : Configuration V → ℂ) (lambda : ℂ)
    (hz : z ≠ 0) (heigen : complexAction F z = lambda • z) :
    lambda ^ finiteOrder F = 1 := by
  have hiter : ∀ n : ℕ, (complexAction F)^[n] z = (lambda ^ n) • z := by
    intro n
    induction n with
    | zero => simp
    | succ n ih =>
        rw [Function.iterate_succ_apply', ih]
        funext y
        change lambda ^ n * z (F.symm y) = lambda ^ (n + 1) * z y
        have hy := congrFun heigen y
        change z (F.symm y) = lambda * z y at hy
        rw [hy, pow_succ]
        ring
  obtain ⟨y, hy⟩ : ∃ y, z y ≠ 0 := by
    simpa [Function.ne_iff] using hz
  have horder : F ^ finiteOrder F = 1 := (finiteOrder_identity F).1
  have hsame := congrFun (hiter (finiteOrder F)) y
  rw [← complexAction_pow, horder] at hsame
  change z y = lambda ^ finiteOrder F * z y at hsame
  have : lambda ^ finiteOrder F * z y = 1 * z y := by simpa using hsame.symm
  exact mul_right_cancel₀ hy this

/-- 有限位相符号 `(k,d)` の複素実現。 -/
noncomputable def phaseValue (d : ℕ) (k : ℕ) : ℂ :=
  Complex.exp (((2 * Real.pi * ((k : ℝ) / d) : ℝ) : ℂ) * Complex.I)

/-- 正の周期長を持つ有限位相符号の複素像は一の冪根である。 -/
theorem phaseValue_pow_period (d : ℕ) (hd : 0 < d) (k : ℕ) :
    phaseValue d k ^ d = 1 := by
  have hd0 : (d : ℂ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hd)
  rw [phaseValue, ← Complex.exp_nat_mul]
  convert Complex.exp_nat_mul_two_pi_mul_I k using 1
  push_cast
  field_simp [hd0]

/-- 正の周期長の巡回添字における直前の位置。 -/
def cyclicPrevious (d : ℕ) (hd : 0 < d) (j : Fin d) : Fin d :=
  if hj : j.1 = 0 then
    ⟨d - 1, Nat.sub_lt hd (by omega)⟩
  else
    ⟨j.1 - 1,
      (Nat.sub_lt (n := j.1) (m := 1) (Nat.pos_of_ne_zero hj) (by omega)).trans j.2⟩

/-- 正の周期長の巡回添字における直後の位置。 -/
def cyclicNext (d : ℕ) (hd : 0 < d) (j : Fin d) : Fin d :=
  ⟨(j.1 + 1) % d, Nat.mod_lt _ hd⟩

/-- 位相符号に対応する、巡回添字ごとの複素係数。 -/
noncomputable def orbitPhaseCoefficient (d k : ℕ) (j : Fin d) : ℂ :=
  phaseValue d k ^ (d - j.1)

/-- 直前の巡回位置の係数は、現在位置の係数に位相値を掛けたものである。 -/
theorem orbitPhaseCoefficient_previous (d : ℕ) (hd : 0 < d) (k : ℕ) (j : Fin d) :
    orbitPhaseCoefficient d k (cyclicPrevious d hd j) =
      phaseValue d k * orbitPhaseCoefficient d k j := by
  by_cases hj : j.1 = 0
  · have hsub : d - (d - 1) = 1 := by omega
    simp [orbitPhaseCoefficient, cyclicPrevious, hj, hsub, phaseValue_pow_period d hd k]
  · have hjpos : 0 < j.1 := Nat.pos_of_ne_zero hj
    have hexponent : d - (j.1 - 1) = (d - j.1) + 1 := by omega
    simp [orbitPhaseCoefficient, cyclicPrevious, hj, hexponent, pow_succ, mul_comm]

/-- 一つの周期軌道の列挙に支えられた複素位相ベクトル。 -/
noncomputable def orbitPhaseVector (d k : ℕ)
    (points : Fin d → Configuration V) : Configuration V → ℂ :=
  fun x => ∑ j : Fin d, if x = points j then orbitPhaseCoefficient d k j else 0

theorem orbitPhaseVector_at_point (d k : ℕ)
    (points : Fin d → Configuration V) (hpoints : Function.Injective points) (j : Fin d) :
    orbitPhaseVector d k points (points j) = orbitPhaseCoefficient d k j := by
  classical
  simp [orbitPhaseVector, hpoints.eq_iff]

theorem orbitPhaseVector_outside (d k : ℕ)
    (points : Fin d → Configuration V) (x : Configuration V)
    (hx : ¬∃ j, x = points j) :
    orbitPhaseVector d k points x = 0 := by
  classical
  rw [orbitPhaseVector]
  apply Finset.sum_eq_zero
  intro j _
  simp only [ite_eq_right_iff]
  intro hxj
  exact (hx ⟨j, hxj⟩).elim

/--
周期軌道を巡回順に列挙すると、各有限位相符号はその軌道に支えられた
非零固有ベクトルを明示的に与える。
-/
theorem orbitPhaseVector_nonzero_and_eigenpair (F : ReversibleEvolution V)
    (d : ℕ) (hd : 0 < d) (k : ℕ)
    (points : Fin d → Configuration V) (hpoints : Function.Injective points)
    (hforward : ∀ j, F (points j) = points (cyclicNext d hd j))
    (hbackward : ∀ j, F.symm (points j) = points (cyclicPrevious d hd j)) :
    orbitPhaseVector d k points ≠ 0 ∧
      complexAction F (orbitPhaseVector d k points) =
        phaseValue d k • orbitPhaseVector d k points := by
  classical
  constructor
  · intro hzero
    let j0 : Fin d := ⟨0, hd⟩
    have hat := orbitPhaseVector_at_point d k points hpoints j0
    rw [hzero] at hat
    have hcoefficient : orbitPhaseCoefficient d k j0 = 1 := by
      simp [orbitPhaseCoefficient, j0, phaseValue_pow_period d hd k]
    simp [hcoefficient] at hat
  · funext y
    by_cases hy : ∃ j, y = points j
    · obtain ⟨j, rfl⟩ := hy
      rw [show complexAction F (orbitPhaseVector d k points) (points j) =
          orbitPhaseVector d k points (F.symm (points j)) by rfl]
      rw [hbackward, orbitPhaseVector_at_point d k points hpoints]
      change orbitPhaseCoefficient d k (cyclicPrevious d hd j) =
        phaseValue d k * orbitPhaseVector d k points (points j)
      rw [orbitPhaseVector_at_point d k points hpoints,
        orbitPhaseCoefficient_previous d hd k j]
    · have hpre : ¬∃ j, F.symm y = points j := by
        rintro ⟨j, hj⟩
        apply hy
        refine ⟨cyclicNext d hd j, ?_⟩
        rw [← hforward j, ← hj]
        exact (F.apply_symm_apply y).symm
      rw [show complexAction F (orbitPhaseVector d k points) y =
          orbitPhaseVector d k points (F.symm y) by rfl]
      rw [orbitPhaseVector_outside d k points _ hpre]
      change 0 = phaseValue d k * orbitPhaseVector d k points y
      rw [orbitPhaseVector_outside d k points _ hy]
      simp

/-- 正の時間尺度と整数持ち上げから得る実数値位相生成子。 -/
noncomputable def phaseGenerator (tau : ℝ) (d k : ℕ) (n : ℤ) : ℝ :=
  (2 * Real.pi / tau) * ((k : ℝ) / d + n)

/-- 相異なる整数持ち上げは、正の時間尺度に対して相異なる実数値を与える。 -/
theorem phaseGenerator_injective (tau : ℝ) (htau : 0 < tau)
    (d : ℕ) (_hd : 0 < d) (k : ℕ) :
    Function.Injective (phaseGenerator tau d k) := by
  intro n m hnm
  have hcoefficient : 2 * Real.pi / tau ≠ 0 := by positivity
  change (2 * Real.pi / tau) * ((k : ℝ) / d + (n : ℝ)) =
    (2 * Real.pi / tau) * ((k : ℝ) / d + (m : ℝ)) at hnm
  have hadd : (k : ℝ) / d + (n : ℝ) = (k : ℝ) / d + (m : ℝ) :=
    mul_left_cancel₀ hcoefficient hnm
  have hcast : (n : ℝ) = (m : ℝ) := add_left_cancel hadd
  exact_mod_cast hcast

/-- 全ての整数持ち上げは同じ複素位相を与える。 -/
theorem phaseGenerator_realizes_phase (tau : ℝ) (htau : 0 < tau)
    (d : ℕ) (hd : 0 < d) (k : ℕ) (n : ℤ) :
    Complex.exp (((tau * phaseGenerator tau d k n : ℝ) : ℂ) * Complex.I) =
      phaseValue d k := by
  have htau0 : tau ≠ 0 := ne_of_gt htau
  have hreal : tau * phaseGenerator tau d k n =
      2 * Real.pi * ((k : ℝ) / d + (n : ℝ)) := by
    rw [phaseGenerator]
    field_simp
  rw [hreal]
  have hsplit :
      (((2 * Real.pi * ((k : ℝ) / d + (n : ℝ)) : ℝ) : ℂ) * Complex.I) =
        (((2 * Real.pi * ((k : ℝ) / d) : ℝ) : ℂ) * Complex.I) +
        (n : ℂ) * (2 * Real.pi * Complex.I) := by
    push_cast
    ring
  rw [hsplit, Complex.exp_add, Complex.exp_int_mul_two_pi_mul_I]
  simp [phaseValue]

/-- 同じ有限位相と時間尺度から実数値生成子は一意に決まらない。 -/
theorem phaseGenerator_not_unique (tau : ℝ) (htau : 0 < tau)
    (d : ℕ) (hd : 0 < d) (k : ℕ) :
    ∃ G H : ℤ → ℝ,
      G ≠ H ∧
      (∀ n, Complex.exp (((tau * G n : ℝ) : ℂ) * Complex.I) = phaseValue d k) ∧
      (∀ n, Complex.exp (((tau * H n : ℝ) : ℂ) * Complex.I) = phaseValue d k) := by
  refine ⟨phaseGenerator tau d k, fun n => phaseGenerator tau d k (n + 1), ?_, ?_, ?_⟩
  · intro h
    have := congrFun h 0
    exact Int.zero_ne_one ((phaseGenerator_injective tau htau d hd k) (by simpa using this))
  · exact fun n => phaseGenerator_realizes_phase tau htau d hd k n
  · exact fun n => phaseGenerator_realizes_phase tau htau d hd k (n + 1)

end CellularAutomata.FinitePermutationComplexPhaseBoundary
